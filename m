Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUGJLmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUGJLmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUGJLmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:42:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59594 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266214AbUGJLmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:42:19 -0400
Date: Sat, 10 Jul 2004 13:42:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: [2.6 patch] remove drivers/char/h8.{c,h} (fwd)
Message-ID: <20040710114213.GH28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_H8 in drivers/char/ depends in both 2.4 and 2.6 on 
CONFIG_OBSOLETE which is never enabled.
 
To remove this driver, the following is required additionally to the 
patch below: 
  rm drivers/char/h8.c
  rm drivers/char/h8.h

This patch was already ACK'ed by Richard Henderson.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-full/drivers/char/Kconfig.old	2004-07-03 00:36:17.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/char/Kconfig	2004-07-03 00:36:39.000000000 +0200
@@ -795,16 +795,6 @@
 	  This option enables support for the LCD display and buttons found
 	  on Cobalt systems through a misc device.
 
-config H8
-	bool "Tadpole ANA H8 Support (OBSOLETE)"
-	depends on OBSOLETE && ALPHA_BOOK1
-	help
-	  The Hitachi H8/337 is a microcontroller used to deal with the power
-	  and thermal environment. If you say Y here, you will be able to
-	  communicate with it via a character special device.
-
-	  If unsure, say N.
-
 config DTLK
 	tristate "Double Talk PC internal speech card support"
 	help
--- linux-2.6.7-mm5-full/drivers/char/Makefile.old	2004-07-03 00:37:03.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/char/Makefile	2004-07-03 00:37:14.000000000 +0200
@@ -69,7 +69,6 @@
 obj-$(CONFIG_QIC02_TAPE) += tpqic02.o
 obj-$(CONFIG_FTAPE) += ftape/
 obj-$(CONFIG_COBALT_LCD) += lcd.o
-obj-$(CONFIG_H8) += h8.o
 obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o


