Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUBBQGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUBBQGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:06:50 -0500
Received: from witte.sonytel.be ([80.88.33.193]:57264 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265681AbUBBQGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:06:49 -0500
Date: Mon, 2 Feb 2004 17:06:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       support@stallion.oz.au
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] istallion compile fix
Message-ID: <Pine.GSO.4.58.0402021705230.19699@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix compilation if CONFIG_PCI is not set

--- linux-2.6.2-rc3/drivers/char/istallion.c.orig	2003-10-09 10:02:39.000000000 +0200
+++ linux-2.6.2-rc3/drivers/char/istallion.c	2004-01-10 04:18:44.000000000 +0100
@@ -417,7 +417,6 @@
 #ifndef PCI_DEVICE_ID_ECRA
 #define	PCI_DEVICE_ID_ECRA		0x0004
 #endif
-#endif

 static struct pci_device_id istallion_pci_tbl[] = {
 	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -425,6 +424,8 @@
 };
 MODULE_DEVICE_TABLE(pci, istallion_pci_tbl);

+#endif /* CONFIG_PCI */
+
 /*****************************************************************************/

 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
