Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUIXDSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUIXDSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUIWUft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:35:49 -0400
Received: from baikonur.stro.at ([213.239.196.228]:16839 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266901AbUIWU2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:28:31 -0400
Subject: [patch 2/4]  mark __init/__exit static 	drivers/net/ppp_deflate
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:28:28 +0200
Message-ID: <E1CAaCb-0000bR-2Z@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



more static, applies clean on 2.6.7-rc1
compile tested


Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/net/ppp_deflate.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/net/ppp_deflate.c~static-ppp_deflate drivers/net/ppp_deflate.c
--- linux-2.6.9-rc2-bk7/drivers/net/ppp_deflate.c~static-ppp_deflate	2004-09-21 20:47:02.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/net/ppp_deflate.c	2004-09-21 20:47:02.000000000 +0200
@@ -636,7 +636,7 @@ struct compressor ppp_deflate_draft = {
 	.owner =		THIS_MODULE
 };
 
-int __init deflate_init(void)
+static int __init deflate_init(void)
 {  
         int answer = ppp_register_compressor(&ppp_deflate);
         if (answer == 0)
@@ -646,7 +646,7 @@ int __init deflate_init(void)
         return answer;
 }
      
-void __exit deflate_cleanup(void)
+static void __exit deflate_cleanup(void)
 {
 	ppp_unregister_compressor(&ppp_deflate);
 	ppp_unregister_compressor(&ppp_deflate_draft);
_
