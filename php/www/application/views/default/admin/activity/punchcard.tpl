{extends file="mainlayout.tpl"}
{block name=javascript}
    <script type="text/javascript">
        layui.config({
            base: theme_url + 'plugins/layui/modules/'
        });
        layui.use(['jquery', 'form', 'icheck', 'laypage', 'layer', 'laydate', 'query'], function () {
            var $ = layui.jquery,
                    form = layui.form(),
                    laypage = layui.laypage,
                    layer = parent.layer === undefined ? layui.layer : parent.layer,
                    laydate = layui.laydate;



            $("[data-tab]").on('click', function () {
                var t = $(this);
                parent.tab.tabAdd({
                    title: t.data('title'),
                    icon: t.data('icon'),
                    href: t.attr('href')
                });
                return false;
            });

        {if empty( $list)}
            layer.msg('没有任何数据');
        {elseif $pages>1}
            laypage({
                cont: 'page',
                pages: {$pages},
                curr:{$page},
                groups: 5,
                jump: function (obj, first) {

                    var curr = obj.curr;
                    if (!first) {
                        self.location = $.query.set("page", obj.curr);
                    }
                }
            });
        {/if}


            $('.site-table tbody tr').on('click', function (event) {
                var $this = $(this);
                var $input = $this.children('td').eq(0).find('input');
                $input.on('ifChecked', function (e) {
                    $this.css('background-color', '#EEEEEE');
                });
                $input.on('ifUnchecked', function (e) {
                    $this.removeAttr('style');
                });
                $input.iCheck('toggle');
            }).find('input').each(function () {
                var $this = $(this);
                $this.on('ifChecked', function (e) {
                    $this.parents('tr').css('background-color', '#EEEEEE');
                });
                $this.on('ifUnchecked', function (e) {
                    $this.parents('tr').removeAttr('style');
                });
            });


            $("[name='shelves']").each(function () {
                var $this = $(this);
                $this.on('ifChecked', function (e) {
                    $this.parents('tr').css('background-color', '#EEEEEE');
                });
                $this.on('ifUnchecked', function (e) {
                    $this.parents('tr').removeAttr('style');
                });
            });

        });
    </script>
{/block}
{block name=body}
    <div class="admin-main">
        <blockquote id='searchform' class="layui-elem-quote">


            <form class="layui-form" action="{site_url('activity/punchCard')}" method="get">
                <div>
                    <input type="hidden" name="id" value="{$aid}" autocomplete="off" class="layui-input" placeholder="">
                    <input type="hidden" name="act" value="{$act}" autocomplete="off" class="layui-input" placeholder="">
                    {if (string)$act==='clock'}
                        <div class="layui-input-inline">
                            <input type="text" name="keyword" value="{$keyword}" autocomplete="off" class="layui-input" placeholder="打卡人">
                        </div>
                    {else}
                        <div class="layui-input-inline">
                            <input type="text" name="usernick" value="{$usernick}" autocomplete="off" class="layui-input" placeholder="昵称">
                        </div>
                    {/if}
                    <div class="layui-inline">

                        <input type="text" name="date" id="date" value="{$date}" placeholder="发布时间" autocomplete="off" class="layui-input" {literal} onclick="layui.laydate({elem: this})"{/literal}>

                    </div>

                    <div class="layui-inline">
                        <button class="layui-btn" lay-submit="" lay-filter="demo1"><i class="layui-icon">&#xe615;</i> 搜索</button>
                    </div>
                    <div class="layui-inline">
                        <a class="layui-btn"  onclick="javascript:history.back();" ><i class="fa fa-history" aria-hidden="true"></i>&nbsp;返回</a>
                    </div>
                </div>
            </form>

        </blockquote>
        {if !empty( $list)}

            <div class="layui-field-box">
                <table class="site-table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                                {if (string)$act==='clock'}
                                <th>打卡人</th>
                                <th>性别</th>
                                <th>电话</th>
                                <th>打卡时间</th>
                                <th>打卡类型</th>
                                {else}
                                <th>昵称</th>
                                <th>电话</th>
                                <th>报名时间</th>
                                <th>备注</th>  
                                {/if}

                        </tr>
                    </thead>
                    <tbody>
                        {foreach $list as $row}
                            <tr>
                                <td>{$row.id}</td>
                                {if (string)$act==='clock'}
                                    <td>
                                        {$row.username}
                                    </td>
                                    <td>{$row.sex}</td>

                                    <td>{$row.tel}</td>
                                    <td>
                                        {$row.time}
                                    </td>
                                    <td>
                                        {if (int)$row.type===1}
                                            管理员扫普通用户
                                        {elseif (int)$row.type===2}
                                            委员代打
                                        {else}
                                            用户扫二维码
                                        {/if}
                                    </td>
                                {else}
                                    <td>{$row.usernick}</td>
                                    <td>
                                        {$row.usertel}
                                    </td>
                                    <td>
                                        {$row.time}
                                    </td>
                                    <td>{$row.beizhu}</td>   
                                {/if}


                            </tr>
                        {/foreach}
                    </tbody>
                </table>

            </div>


            {if $pages>1}
                <div class="admin-table-page">
                    <div id="page" class="page">
                    </div>
                </div>
            {/if}
        {/if}
    </div>
{/block}