Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUJaLD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUJaLD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUJaKkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:40:13 -0500
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:8210
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261544AbUJaKEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:04:21 -0500
Date: Sun, 31 Oct 2004 11:03:38 +0100
Message-Id: <200410311003.i9VA3cPu009601@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 496] hades-pci.c: replace pci_find_device() with pci_get_device()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device() is going away I have replaced this call with
pci_get_device().

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/atari/hades-pci.c	2004-09-29 20:04:57.000000000 -0700
+++ linux-m68k-2.6.10-rc1/arch/m68k/atari/hades-pci.c	2004-10-04 13:30:44.120362824 -0700
@@ -311,7 +311,7 @@ static void __init hades_fixup(int pci_m
 	 * Go through all devices, fixing up irqs as we see fit:
 	 */
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 	{
 		if (dev->class >> 16 != PCI_BASE_CLASS_BRIDGE)
 		{

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
