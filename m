Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270270AbTGVJQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270275AbTGVJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 05:16:37 -0400
Received: from [203.145.184.221] ([203.145.184.221]:58385 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S270270AbTGVJQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 05:16:33 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [PATCH] - ac2-test1: Removing the obselete EXPORT_NO_SYMBOLS
Date: Tue, 22 Jul 2003 15:03:53 +0530
User-Agent: KMail/1.5
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200307221342.30374.krishnakumar@naturesoft.net> <20030722082212.GA24515@triplehelix.org>
In-Reply-To: <20030722082212.GA24515@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307221503.53281.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please find the patch with the #ifndef removed.


On Tuesday 22 July 2003 13:52, Joshua Kwan wrote:
> On Tue, Jul 22, 2003 at 01:42:30PM +0530, Krishnakumar. R wrote:
> >  #ifndef METH_DEBUG
> > -	EXPORT_NO_SYMBOLS;
> >  #endif
>
> Why not just pull the whole #ifdef/#endif?
>
> -Josh
======================================================
Output of diffstat

arch/cris/arch-v10/drivers/pcf8563.c |    1 -
 drivers/net/meth.c                          |    3 ---
 sound/oss/harmony.c                     |    1 -
 sound/oss/swarm_cs4297a.c          |    1 -
 4 files changed, 6 deletions(-)
======================================================

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
+++ linux-2.6.0-test1-ac2/drivers/net/meth.c	2003-07-22 14:47:51.000000000 +0530
@@ -844,9 +844,6 @@
 		printk("meth: error %i registering device \"%s\"\n",
 		       result, meth_devs->name);
 	else device_present++;
-#ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
-#endif
 	
 	return device_present ? 0 : -ENODEV;
 }
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







