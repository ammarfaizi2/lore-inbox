Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbUK3CiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUK3CiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUK3CBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:01:08 -0500
Received: from baikonur.stro.at ([213.239.196.228]:55434 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261821AbUK3B5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:31 -0500
Subject: [patch 07/11] Subject: ifdef typos: drivers_net_wireless_wavelan_cs.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:28 +0100
Message-ID: <E1CYxGj-0002sU-2F@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



wavelan.p.h defines *_ERROR
wavelan_cs.p.h defines *_ERRORS
Since only second one is included, change #ifdefs

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/drivers/net/wireless/wavelan_cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/net/wireless/wavelan_cs.c~ifdef-drivers_net_wireless_wavelan_cs drivers/net/wireless/wavelan_cs.c
--- linux-2.6.10-rc2-bk13/drivers/net/wireless/wavelan_cs.c~ifdef-drivers_net_wireless_wavelan_cs	2004-11-30 02:41:40.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/drivers/net/wireless/wavelan_cs.c	2004-11-30 02:41:40.000000000 +0100
@@ -950,7 +950,7 @@ wv_diag(struct net_device *	dev)
 		  OP0_DIAGNOSE, SR0_DIAGNOSE_PASSED))
     ret = TRUE;
 
-#ifdef DEBUG_CONFIG_ERROR
+#ifdef DEBUG_CONFIG_ERRORS
   printk(KERN_INFO "wavelan_cs: i82593 Self Test failed!\n");
 #endif
   return(ret);
@@ -3463,7 +3463,7 @@ wv_ru_stop(struct net_device *	dev)
   /* If there was a problem */
   if(spin <= 0)
     {
-#ifdef DEBUG_CONFIG_ERROR
+#ifdef DEBUG_CONFIG_ERRORS
       printk(KERN_INFO "%s: wv_ru_stop(): The chip doesn't want to stop...\n",
 	     dev->name);
 #endif
_
