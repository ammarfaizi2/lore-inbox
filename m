Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271692AbTG2Moo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271700AbTG2Mog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:44:36 -0400
Received: from [203.145.184.221] ([203.145.184.221]:7692 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S271692AbTG2Mm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:42:58 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: davej@suse.de
Subject: [PATCH]2.6.0-test2 : removing obsolete EXPORT_NO_SYMBOLS
Date: Tue, 29 Jul 2003 18:14:28 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307291814.28363.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave,

This patch removes the obsolete EXPORT_NO_SYMBOLS 
from some of the source code. The above said macro has become
obsolete for 2.6 kernel series.

The patch is against 2.6.0-test2.

Please push it to linus for inclusion.

Regards
KK


=================================================
diffstat output of the patch:


arch/cris/arch-v10/drivers/pcf8563.c  |    1 -
drivers/net/meth.c                            |    4 ----
sound/oss/harmony.c                       |    1 -
sound/oss/swarm_cs4297a.c            |    2 --
4 files changed, 8 deletions(-)

=================================================
Here is the patch

diff -urN -X dontdiff linux-2.6.0-test2.orig/arch/cris/arch-v10/drivers/pcf8563.c linux-2.6.0-test2/arch/cris/arch-v10/drivers/pcf8563.c
--- linux-2.6.0-test2.orig/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-27 22:30:21.000000000 +0530
+++ linux-2.6.0-test2/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-29 17:53:23.000000000 +0530
@@ -282,6 +282,5 @@
 	return 0;
 }
 
-EXPORT_NO_SYMBOLS;
 module_init(pcf8563_init);
 module_exit(pcf8563_exit);
diff -urN -X dontdiff linux-2.6.0-test2.orig/drivers/net/meth.c linux-2.6.0-test2/drivers/net/meth.c
--- linux-2.6.0-test2.orig/drivers/net/meth.c	2003-07-27 22:37:22.000000000 +0530
+++ linux-2.6.0-test2/drivers/net/meth.c	2003-07-29 17:53:53.000000000 +0530
@@ -844,10 +844,6 @@
 		printk("meth: error %i registering device \"%s\"\n",
 		       result, meth_devs->name);
 	else device_present++;
-#ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
-#endif
-	
 	return device_present ? 0 : -ENODEV;
 }
 
diff -urN -X dontdiff linux-2.6.0-test2.orig/sound/oss/harmony.c linux-2.6.0-test2/sound/oss/harmony.c
--- linux-2.6.0-test2.orig/sound/oss/harmony.c	2003-07-27 22:37:05.000000000 +0530
+++ linux-2.6.0-test2/sound/oss/harmony.c	2003-07-29 17:55:07.000000000 +0530
@@ -1296,7 +1296,6 @@
 	unregister_parisc_driver(&harmony_driver);
 }
 
-EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Alex DeVries <alex@linuxcare.com>");
 MODULE_DESCRIPTION("Harmony sound driver");
diff -urN -X dontdiff linux-2.6.0-test2.orig/sound/oss/swarm_cs4297a.c linux-2.6.0-test2/sound/oss/swarm_cs4297a.c
--- linux-2.6.0-test2.orig/sound/oss/swarm_cs4297a.c	2003-07-27 22:32:56.000000000 +0530
+++ linux-2.6.0-test2/sound/oss/swarm_cs4297a.c	2003-07-29 17:54:47.000000000 +0530
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

