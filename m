Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTJCXoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTJCXoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:44:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14036 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261566AbTJCXjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:39:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:42:49 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040142.49273.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] generic: kill dummy init_dma_generic()

 drivers/ide/pci/generic.c |    5 -----
 drivers/ide/pci/generic.h |   12 ------------
 2 files changed, 17 deletions(-)

diff -puN drivers/ide/pci/generic.c~ide-generic-init_dma drivers/ide/pci/generic.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/generic.c~ide-generic-init_dma	2003-10-04 01:00:02.388034776 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/generic.c	2003-10-04 01:00:02.394033864 +0200
@@ -72,11 +72,6 @@ static void __init init_hwif_generic (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void init_dma_generic (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 #if 0
diff -puN drivers/ide/pci/generic.h~ide-generic-init_dma drivers/ide/pci/generic.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/generic.h~ide-generic-init_dma	2003-10-04 01:00:02.391034320 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/generic.h	2003-10-04 01:00:02.395033712 +0200
@@ -7,7 +7,6 @@
 
 static unsigned int init_chipset_generic(struct pci_dev *, const char *);
 static void init_hwif_generic(ide_hwif_t *);
-static void init_dma_generic(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t generic_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -17,7 +16,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
@@ -30,7 +28,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -43,7 +40,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -56,7 +52,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -69,7 +64,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -82,7 +76,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -95,7 +88,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -108,7 +100,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -121,7 +112,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -134,7 +124,6 @@ static ide_pci_device_t generic_chipsets
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -157,7 +146,6 @@ static ide_pci_device_t unknown_chipset[
 		.init_chipset	= init_chipset_generic,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_generic,
-		.init_dma	= init_dma_generic,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

