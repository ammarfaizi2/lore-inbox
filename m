Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271364AbTG2JdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTG2Jbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:31:53 -0400
Received: from mail.convergence.de ([212.84.236.4]:41694 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271362AbTG2Jam convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:30:42 -0400
Subject: [PATCH 6/6] [DVB] Hexium saa7146 driver update
In-Reply-To: <10594710321293@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 29 Jul 2003 11:30:32 +0200
Message-Id: <10594710322140@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[V4L] - set debug verbosity to 0 for both Hexium drivers
[V4L] - declare all local functions and variables static
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/video/hexium_gemini.c linux-2.6.0-test2.patch/drivers/media/video/hexium_gemini.c
--- linux-2.6.0-test2.work/drivers/media/video/hexium_gemini.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/video/hexium_gemini.c	2003-07-17 11:03:08.000000000 +0200
@@ -25,12 +25,12 @@
 
 #include <media/saa7146_vv.h>
 
-static int debug = 255;
+static int debug = 0;
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "debug verbosity");
 
 /* global variables */
-int hexium_num = 0;
+static int hexium_num = 0;
 
 #include "hexium_gemini.h"
 
@@ -388,7 +388,7 @@
 	.irq_func = NULL,
 };
 
-int __init hexium_init_module(void)
+static int __init hexium_init_module(void)
 {
 	if (0 != saa7146_register_extension(&hexium_extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -398,7 +398,7 @@
 	return 0;
 }
 
-void __exit hexium_cleanup_module(void)
+static void __exit hexium_cleanup_module(void)
 {
 	saa7146_unregister_extension(&hexium_extension);
 }
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/video/hexium_orion.c linux-2.6.0-test2.patch/drivers/media/video/hexium_orion.c
--- linux-2.6.0-test2.work/drivers/media/video/hexium_orion.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/video/hexium_orion.c	2003-07-17 11:03:08.000000000 +0200
@@ -25,7 +25,7 @@
 
 #include <media/saa7146_vv.h>
 
-static int debug = 255;
+static int debug = 0;
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "debug verbosity");
 

