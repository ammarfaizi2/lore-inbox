Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUGTTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUGTTXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUGTTO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:14:27 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:48224 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S266161AbUGTSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:52 -0400
Date: Tue, 20 Jul 2004 20:39:50 +0200
Message-Id: <200407201839.i6KIdo2I015550@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI DMA API: Adaptec AIC7xxx_old
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adaptec AIC7xxx_old unconditionally depends on the PCI DMA API, so mark it
broken if !PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/scsi/Kconfig	2004-07-18 15:55:26.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/scsi/Kconfig	2004-07-19 23:16:48.000000000 +0200
@@ -320,7 +320,7 @@
 
 config SCSI_AIC7XXX_OLD
 	tristate "Adaptec AIC7xxx support (old driver)"
-	depends on SCSI
+	depends on SCSI && (PCI || BROKEN)
 	help
 	  WARNING This driver is an older aic7xxx driver and is no longer
 	  under active development.  Adaptec, Inc. is writing a new driver to

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
