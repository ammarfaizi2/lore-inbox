Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270092AbTGVH4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbTGVH4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:56:13 -0400
Received: from [203.145.184.221] ([203.145.184.221]:39437 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S270275AbTGVH4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:56:08 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
Subject: [PATCH] - ac2-test1: Removing the obselete EXPORT_NO_SYMBOLS
Date: Tue, 22 Jul 2003 13:42:30 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
To: Alan Cox <alan@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307221342.30374.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,

The following patch would remove the obselete EXPORT_NO_SYMBOLS from some of the sources. 
>From my understanding the EXPORT_NO_SYMBOLS is not needed any more as all the symbols, by default
are now kept away from being exported.

The patch is against the ac2 patched test1 kernel.

Hope it does not break anything !!

Regards
KK


===================================================
Result of  ' cat patch_export_no_symbol-ac2-test1.patch | diffstat '

 arch/cris/arch-v10/drivers/pcf8563.c |    1 -
 drivers/net/meth.c       		      |    1 -
 sound/oss/harmony.c                      |    1 -
 sound/oss/swarm_cs4297a.c           |    1 -
 4 files changed, 4 deletions(-)

===================================================
The following is the patch:
===================================================


diff -urN -X dontdiff linux-2.6.0-test1-ac2.orig/arch/cris/arch-v10/drivers/pcf8563.c linux-2.6.0-test1-ac2/arch/cris/arch-v10/drivers/pcf8563.c
--- linux-2.6.0-test1-ac2.orig/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-14 09:02:40.000000000 +0530
+++ linux-2.6.0-test1-ac2/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-22 12:33:24.000000000 +0530
@@ -282,6 +282,5 @@
 	return 0;
 }
 
-EXPORT_NO_SYMBOLS;
 module_init(pcf8563_init);
 module_exit(pcf8563_exit);
diff -urN -X dontdiff linux-2.6.0-test1-ac2.orig/drivers/net/meth.c linux-2.6.0-test1-ac2/drivers/net/meth.c
--- linux-2.6.0-test1-ac2.orig/drivers/net/meth.c	2003-07-14 09:07:16.000000000 +0530
+++ linux-2.6.0-test1-ac2/drivers/net/meth.c	2003-07-22 12:33:54.000000000 +0530
@@ -845,7 +845,6 @@
 		       result, meth_devs->name);
 	else device_present++;
 #ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
 #endif
 	
 	return device_present ? 0 : -ENODEV;
diff -urN -X dontdiff linux-2.6.0-test1-ac2.orig/sound/oss/harmony.c linux-2.6.0-test1-ac2/sound/oss/harmony.c
--- linux-2.6.0-test1-ac2.orig/sound/oss/harmony.c	2003-07-22 12:29:26.000000000 +0530
+++ linux-2.6.0-test1-ac2/sound/oss/harmony.c	2003-07-22 12:38:12.000000000 +0530
@@ -1285,7 +1285,6 @@
 	unregister_parisc_driver(&harmony_driver);
 }
 
-EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Alex DeVries <alex@linuxcare.com>");
 MODULE_DESCRIPTION("Harmony sound driver");
diff -urN -X dontdiff linux-2.6.0-test1-ac2.orig/sound/oss/swarm_cs4297a.c linux-2.6.0-test1-ac2/sound/oss/swarm_cs4297a.c
--- linux-2.6.0-test1-ac2.orig/sound/oss/swarm_cs4297a.c	2003-07-14 09:04:39.000000000 +0530
+++ linux-2.6.0-test1-ac2/sound/oss/swarm_cs4297a.c	2003-07-22 12:36:31.000000000 +0530
@@ -90,7 +90,6 @@
 #include <asm/sibyte/64bit.h>
 
 struct cs4297a_state;
-EXPORT_NO_SYMBOLS;
 
 static void stop_dac(struct cs4297a_state *s);
 static void stop_adc(struct cs4297a_state *s);

-





























