Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUGTT5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUGTT5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUGTTmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:42:39 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:54295 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S266153AbUGTSjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:46 -0400
Date: Tue, 20 Jul 2004 20:39:44 +0200
Message-Id: <200407201839.i6KIdiWb015510@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: VIA686A i2c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIA686A i2c unconditionally depends on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/i2c/chips/Kconfig	2004-07-18 15:55:14.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/i2c/chips/Kconfig	2004-07-19 18:20:16.000000000 +0200
@@ -193,7 +193,7 @@
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
 	select I2C_SENSOR
 	select I2C_ISA
 	help

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
