Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUGTTpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUGTTpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUGTToZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:44:25 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:18786
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266144AbUGTSjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:44 -0400
Date: Tue, 20 Jul 2004 20:39:42 +0200
Message-Id: <200407201839.i6KIdgF0015490@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: Multi-Tech, SyncLink, Applicom serial
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-Tech, Microgate SyncLink, and Applicom serial unconditionally depend on
PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/char/Kconfig	2004-07-18 15:55:10.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/Kconfig	2004-07-19 18:19:29.000000000 +0200
@@ -203,7 +203,7 @@
 
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD && EXPERIMENTAL && BROKEN_ON_SMP && m
+	depends on SERIAL_NONSTANDARD && PCI && EXPERIMENTAL && BROKEN_ON_SMP && m
 	help
 	  This is a driver for the Multi-Tech cards which provide several
 	  serial ports.  The driver is experimental and can currently only be
@@ -212,7 +212,7 @@
 
 config SYNCLINK
 	tristate "Microgate SyncLink card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	help
 	  Provides support for the SyncLink ISA and PCI multiprotocol serial
 	  adapters. These adapters support asynchronous and HDLC bit
@@ -819,6 +819,7 @@
 
 config APPLICOM
 	tristate "Applicom intelligent fieldbus card support"
+	depends on PCI
 	---help---
 	  This driver provides the kernel-side support for the intelligent
 	  fieldbus cards made by Applicom International. More information

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
