Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266131AbUGTSoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUGTSoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUGTSni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:43:38 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:56881
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S266131AbUGTSj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:57 -0400
Date: Tue, 20 Jul 2004 20:39:51 +0200
Message-Id: <200407201839.i6KIdpOu015555@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, johnpol@2ka.mipt.ru
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: Matrox 1-wire
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matrox 1-wire unconditionally depends on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/w1/Kconfig	2004-07-18 15:55:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/w1/Kconfig	2004-07-19 00:03:26.000000000 +0200
@@ -13,7 +13,7 @@
 
 config W1_MATROX
 	tristate "Matrox G400 transport layer for 1-wire"
-	depends on W1
+	depends on W1 && PCI
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using Matrox's G400 GPIO pins.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
