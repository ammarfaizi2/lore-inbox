Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUGTTpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUGTTpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGTToS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:44:18 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:52001
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266149AbUGTSjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:45 -0400
Date: Tue, 20 Jul 2004 20:39:43 +0200
Message-Id: <200407201839.i6KIdhn5015505@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       R.E.Wolff@BitWizard.nl
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] !PCI warnings: Specialix serial
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill warnings in Specialix serial driver when !PCI.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/char/sx.c	2004-04-15 11:44:11.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/sx.c	2004-07-19 23:10:48.000000000 +0200
@@ -251,11 +251,13 @@
 #define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
 #endif
 
+#ifdef CONFIG_PCI
 static struct pci_device_id sx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
+#endif /* CONFIG_PCI */
 
 /* Configurable options: 
    (Don't be too sure that it'll work if you toggle them) */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
