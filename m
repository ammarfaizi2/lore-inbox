Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTJCXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJCXml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:42:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25044 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261575AbTJCXkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:40:16 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:43:42 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040143.42410.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] opti621: kill dummy init_dma_opti621()

 drivers/ide/pci/opti621.c |    5 -----
 drivers/ide/pci/opti621.h |    3 ---
 2 files changed, 8 deletions(-)

diff -puN drivers/ide/pci/opti621.c~ide-opti621-init_dma drivers/ide/pci/opti621.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/opti621.c~ide-opti621-init_dma	2003-10-04 01:02:44.897329608 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/opti621.c	2003-10-04 01:02:44.903328696 +0200
@@ -348,11 +348,6 @@ static void __init init_hwif_opti621 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_opti621 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static void __init init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
diff -puN drivers/ide/pci/opti621.h~ide-opti621-init_dma drivers/ide/pci/opti621.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/opti621.h~ide-opti621-init_dma	2003-10-04 01:02:44.900329152 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/opti621.h	2003-10-04 01:03:31.271279696 +0200
@@ -7,7 +7,6 @@
 
 static void init_setup_opti621(struct pci_dev *, ide_pci_device_t *);
 static void init_hwif_opti621(ide_hwif_t *);
-static void init_dma_opti621(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -18,7 +17,6 @@ static ide_pci_device_t opti621_chipsets
 		.init_chipset	= NULL,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_opti621,
-		.init_dma	= init_dma_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
@@ -32,7 +30,6 @@ static ide_pci_device_t opti621_chipsets
 		.init_chipset	= NULL,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_opti621,
-                .init_dma	= init_dma_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},

_

