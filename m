Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUIWV2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUIWV2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIWVZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:25:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:54448 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267378AbUIWVWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:22:40 -0400
Subject: [patch 1/3]  __FUNCTION__ string concatenation 	deprecated
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, drizzd@aon.at
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:22:40 +0200
Message-ID: <E1CAb32-0005nS-Is@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Description: __FUNCTION__ string concatenation is deprecated

Diff against linux-2.6 up to ChangeSet@1.1938 (04/09/18 20:30:01)

Status: untested

Signed-off-by: Clemens Buchacher <drizzd@aon.at>

# arch/mips/au1000/db1x00/mirage_ts.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +1 -1
#   __FUNCTION__ string concatenation is deprecated
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/arch/mips/au1000/db1x00/mirage_ts.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/mips/au1000/db1x00/mirage_ts.c~function-string-arch_mips_au1000_db1x00_mirage_ts arch/mips/au1000/db1x00/mirage_ts.c
--- linux-2.6.9-rc2-bk7/arch/mips/au1000/db1x00/mirage_ts.c~function-string-arch_mips_au1000_db1x00_mirage_ts	2004-09-21 21:07:15.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/arch/mips/au1000/db1x00/mirage_ts.c	2004-09-21 21:07:15.000000000 +0200
@@ -68,7 +68,7 @@ int wm97xx_comodule_present = 1;
 #define err(format, arg...) printk(KERN_ERR TS_NAME ": " format "\n" , ## arg)
 #define info(format, arg...) printk(KERN_INFO TS_NAME ": " format "\n" , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING TS_NAME ": " format "\n" , ## arg)
-#define DPRINTK(format, arg...) printk(__FUNCTION__ ": " format "\n" , ## arg)
+#define DPRINTK(format, arg...) printk("%s: " format "\n", __FUNCTION__ , ## arg)
 
 
 #define PEN_DOWN_IRQ	AU1000_GPIO_7
_
