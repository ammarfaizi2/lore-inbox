Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTJCXof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTJCXoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:44:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14036 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261570AbTJCXjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:39:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:43:02 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040143.02984.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] hpt34x: kill dummy init_dma_hpt34x()

 drivers/ide/pci/hpt34x.c |    5 -----
 drivers/ide/pci/hpt34x.h |    2 --
 2 files changed, 7 deletions(-)

diff -puN drivers/ide/pci/hpt34x.c~ide-hpt34x-init_dma drivers/ide/pci/hpt34x.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt34x.c~ide-hpt34x-init_dma	2003-10-04 01:00:19.821384504 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt34x.c	2003-10-04 01:00:19.827383592 +0200
@@ -315,11 +315,6 @@ static void __init init_hwif_hpt34x (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_hpt34x (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static int __devinit hpt34x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -puN drivers/ide/pci/hpt34x.h~ide-hpt34x-init_dma drivers/ide/pci/hpt34x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt34x.h~ide-hpt34x-init_dma	2003-10-04 01:00:19.823384200 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt34x.h	2003-10-04 01:00:19.827383592 +0200
@@ -33,7 +33,6 @@ static ide_pci_host_proc_t hpt34x_procs[
 
 static unsigned int init_chipset_hpt34x(struct pci_dev *, const char *);
 static void init_hwif_hpt34x(ide_hwif_t *);
-static void init_dma_hpt34x(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -43,7 +42,6 @@ static ide_pci_device_t hpt34x_chipsets[
 		.init_chipset	= init_chipset_hpt34x,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_hpt34x,
-		.init_dma	= init_dma_hpt34x,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

