Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTJCXof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTJCXnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:43:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14036 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261569AbTJCXjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:39:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:43:21 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200310040143.21915.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] it8172: kill dummy init_dma_it8172()

 drivers/ide/pci/it8172.c |    5 -----
 drivers/ide/pci/it8172.h |    2 --
 2 files changed, 7 deletions(-)

diff -puN drivers/ide/pci/it8172.c~ide-it8172-init_dma drivers/ide/pci/it8172.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/it8172.c~ide-it8172-init_dma	2003-10-04 01:00:35.851947488 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/it8172.c	2003-10-04 01:00:35.857946576 +0200
@@ -284,11 +284,6 @@ static void __init init_hwif_it8172 (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_it8172 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static int __devinit it8172_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -puN drivers/ide/pci/it8172.h~ide-it8172-init_dma drivers/ide/pci/it8172.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/it8172.h~ide-it8172-init_dma	2003-10-04 01:00:35.853947184 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/it8172.h	2003-10-04 01:00:35.857946576 +0200
@@ -17,7 +17,6 @@ static int it8172_config_chipset_for_dma
 static void init_setup_it8172(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_it8172(struct pci_dev *, const char *);
 static void init_hwif_it8172(ide_hwif_t *);
-static void init_dma_it8172(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t it8172_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -28,7 +27,6 @@ static ide_pci_device_t it8172_chipsets[
 		.init_chipset	= init_chipset_it8172,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_it8172,
-                .init_dma	= init_dma_it8172,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},

_

