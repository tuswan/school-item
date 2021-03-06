<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>病虫害列表</title>
    <%@ include file="/WEB-INF/jsp/public/common.jspf"%>
    <script type="text/javascript" src="${pageContext.request.contextPath }/laypage-v1.3/laypage/laypage.js"></script>
<style type="text/css">
	body{ padding-bottom:20px;}
    *{ font-size: 14px;}
        .fl{float: left;} 
        .fr{float: right;}
        .clear{clear:both;}
        ul,ol{ list-style: none;}
        .newsList{ width:800px; height: auto; margin: 0 auto;}
        .newsList .list{ width: 800px; height: 120px; background-color: #DCDBDB; padding: 15px 20px; margin: 10px 0;}
        .list-pic{ width: 120px; height: 120px; background-color: #ccc; overflow: hidden; border-radius: 10px;}
        .list-pic img{ width: 120px; height:120px;}
        .list-infor{ margin-left: 20px; width:660px; padding-top: 10px;}
        .list-infor .title{ font-size: 18px; color: #FF7300; line-height: 25px; display:inline-block;}
        .list-infor .types,#typesParams a{ width:50px; height:25px; background-color:#ff6400;display:inline-block; vertical-align:middle; border-radius:5px; 
        line-height:25px; text-align: center; color: #fff;}
        #yearsParam2 a,.date{width:50px; height:25px; background-color:#F66464;display:inline-block; vertical-align:middle; border-radius:5px; 
        line-height:25px; text-align: center; color:#fff}
       
        .list-infor .descript{color: #490000; line-height: 25px;    height: 25px; white-space:nowrap; text-overflow: ellipsis; overflow: hidden;}
        .collection{ float: right; margin-left:5px; margin-top:5px;}
        .delete{ float:right;  margin-top:5px;}
        
        #pageForm{ margin:10px 0 0 100px;}
        .lititle{margin:100px 0 0 100px; font-size:28px; color:#000;}
        #typesParams{ margin-bottom:15px;}
        #yearsParam2{ margin-bottom:15px;}
        #typesParams a{border-radius:5px; color: #fff;background-color:#F66464;}
        #typesParams a:first-child{background-color:#ff6400;}
        #typesParams a:last-child{background-color:#F66464;}
        #yearsParam2 a{color: #fff;background-color:#F66464;}
        #yearsParam2 a:first-child{background-color:#ff6400;}
        #yearsParam2 a:not(first-child){background-color:#F66464;}
        .informate{ }
        .newsList{margin:0;}
        .area {margin: 5px 0;}
    	.addinfo{margin:10px 0 0 140px; width:120px;height:35px; line-height:35px;     display: block;}
</style>
</head>
<body>
<div class="lititle">综合查询</div>
<form id="pageForm" action="disasterInfoAction_list" method="post"> 
<div id="params">	
	<input id="nameParam" type="hidden" name="name" value="${name}"/>
	<input id="typesParam" type="hidden" name="types" value="${types}"/>
	<input id="yearsParam" type="hidden" name="years" value="${years}"/>
</div>
病虫害查询：<input id="nameParam2" type="text" value="${name }"/><a id="find" href="javascript:void(0);"><button>搜索</button></a><br><br>
<div id="typesParams">
	病虫害类型：
	<a href="javascript:void();" value="all">全部</a>
	<c:forEach items="${disasterInfoTypes }" var="list">
		<c:if test="${list.types eq '1' }">
			<a href="javascript:void();" value="1">病害</a>
		</c:if>
		<c:if test="${list.types eq '2' }">
			<a href="javascript:void();" value="2">虫害</a>
		</c:if>
	</c:forEach>  
</div>
<div id="yearsParam2">  
	按年份查找：
	<a href="javascript:void();" value="all">全部</a>
	<c:forEach items="${yearsList}"  var="list">  
	    <a href="javascript:void();" value="${list.years }">${list.years }</a>
	</c:forEach> 
</div>
<div class="informate">
    <ul class="newsList">
    	<c:forEach items="${disasterInfoList }" var="list">
    	 <li class="list">
            <div class="list-pic fl">
                <a href="disasterInfoAction_detail?id=${list.id}"><img src="${pageContext.request.contextPath}/${list.savepath }/${list.uuidname }" width="100%" height="100%" alt="缩略图" /></a>
            </div>
            <div class="list-infor fl">
                <div class="title"><a href="disasterInfoAction_detail?id=${list.id}">${list.name}</a></div>
                <div class="types">
                	<c:if test="${list.types eq '1'}">
                		病害
                	</c:if>
                	<c:if test="${list.types eq '2'}">
                		虫害
                	</c:if>
                </div>
                <div class="date">
                	${list.years }
                </div>
                <div class="area">
                	区域：
                	${list.province}
         			${list.city } 
         			${list.counties }
                </div>
                <div class="descript">${list.symptoms }</div>
                <div class="collection">
                	<button>
                		<c:if test="${list.collections eq '0' }"> 
                			<a class="collectionYes" href="collectionsAction_addCollections?id=${list.id}">收藏</a>
                		</c:if>
                		<c:if test="${list.collections eq '1' }"> 
                			<a class="collectionNo" href="javascript:void();">已收藏</a>
                		</c:if>
                	</button>
                </div>
                <c:if test="${user.username eq 'admin' }"> 
                <div class="delete">
                	<button><a href="disasterInfoAction_delete?id=${list.id}" onclick="return window.confirm('您确定要删除此新闻吗？')">删除</a></button>
                </div> 
                </c:if>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </li>	
    	</c:forEach>
    </ul>
</div>
</form>
<c:if test="${user.username eq 'admin' }"> 
	<button class="addinfo"><a href="disasterInfoAction_addUI">新增灾害信息</a></button>
</c:if>
<div id="page1"></div>
<script type="text/javascript">

	$("#find").click(function(){
		$("#params").children("input").val(null);
		$("#nameParam").val($("#nameParam2").val());
		check();
	});
	//灾害类型
	$("#typesParams a").click(function(){
		if($(this).attr("value")=='all'){
			$("#typesParam").val(null);
			$("#nameParam").val(null);
		}else{
			$("#nameParam").val(null);
			$("#typesParam").val($(this).attr("value"));
		}
		check();
	});
	//灾害时间
	$("#yearsParam2 a").click(function(){
		if($(this).attr("value")=='all'){
			$("#yearsParam").val(null);
			$("#nameParam").val(null);
		}else{
			$("#nameParam").val(null);
			$("#yearsParam").val($(this).attr("value"));
		}
		check();
	});
	
	//提交表单
	function check(){
		$("#pageForm").submit();
	};
jQuery(function(){ 
	$(".collectionYes").click(function(){
		layer.msg('成功收藏');
	});
	$(".collectionNO").click(function(){
		layer.msg('已成功收藏，请到我的收藏查看详细信息');
	});
	//以下将以jquery.ajax为例，演示一个异步分页
	function demo(curr){
	        //显示分页
	        laypage({
	            cont: 'page1', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
	            pages: 10, //通过后台拿到的总页数
	            curr: curr, //当前页
	            jump: function(obj, first){ //触发分页后的回调
	                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
	                	alert(obj.curr);
	                    demo(obj.curr);
	                }
	            }
	        });
	};
	//运行
	demo(1);        
}); 
</script>
</body>
</html>
	