Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270827AbTGVM6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270828AbTGVM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:58:19 -0400
Received: from [203.145.184.221] ([203.145.184.221]:28677 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S270827AbTGVM6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:58:12 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][2.6.0-test1]:Removes obsolete EXPORT_NO_SYMBOL
Date: Tue, 22 Jul 2003 18:45:52 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307221845.52636.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch removes the obsolete EXPORT_NO_SYMBOL
from many sources.

The patch is against 2.6.0-test1.
Please do apply.

Regards
KK


============================================
diffstat output

arch/cris/arch-v10/drivers/pcf8563.c |    1 -
drivers/net/meth.c                           |    3 ---
sound/oss/swarm_cs4297a.c           |    2 --
3 files changed, 6 deletions(-)

============================================
The following is the patch:-



diff -urN -X dontdiff linux-2.6.0-test1.orig/arch/cris/arch-v10/drivers/pcf8563.c linux-2.6.0-test1/arch/cris/arch-v10/drivers/pcf8563.c
--- linux-2.6.0-test1.orig/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-14 09:02:40.000000000 +0530
+++ linux-2.6.0-test1/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-22 18:24:11.000000000 +0530
@@ -282,6 +282,5 @@
 	return 0;
 }
 
-EXPORT_NO_SYMBOLS;
 module_init(pcf8563_init);
 module_exit(pcf8563_exit);
diff -urN -X dontdiff linux-2.6.0-test1.orig/drivers/net/meth.c linux-2.6.0-test1/drivers/net/meth.c
--- linux-2.6.0-test1.orig/drivers/net/meth.c	2003-07-14 09:07:16.000000000 +0530
+++ linux-2.6.0-test1/drivers/net/meth.c	2003-07-22 18:24:50.000000000 +0530
@@ -844,9 +844,6 @@
 		printk("meth: error %i registering device \"%s\"\n",
 		       result, meth_devs->name);
 	else device_present++;
-#ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
-#endif
 	
 	return device_present ? 0 : -ENODEV;
 }
diff -urN -X dontdiff linux-2.6.0-test1.orig/sound/oss/swarm_cs4297a.c linux-2.6.0-test1/sound/oss/swarm_cs4297a.c
--- linux-2.6.0-test1.orig/sound/oss/swarm_cs4297a.c	2003-07-14 09:04:39.000000000 +0530
+++ linux-2.6.0-test1/sound/oss/swarm_cs4297a.c	2003-07-22 18:25:25.000000000 +0530
@@ -90,7 +90,6 @@
 #include <asm/sibyte/64bit.h>
 
 struct cs4297a_state;
-EXPORT_NO_SYMBOLS;
 
 static void stop_dac(struct cs4297a_state *s);
 static void stop_adc(struct cs4297a_state *s);
@@ -2734,7 +2733,6 @@
 
 // --------------------------------------------------------------------- 
 
-EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Kip Walker, kwalker@broadcom.com");
 MODULE_DESCRIPTION("Cirrus Logic CS4297a Driver for Broadcom SWARM board");

-
