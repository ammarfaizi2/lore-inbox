Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWFRRZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWFRRZC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWFRRZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:25:01 -0400
Received: from bay105-f21.bay105.hotmail.com ([65.54.224.31]:660 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932265AbWFRRZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:25:00 -0400
Message-ID: <BAY105-F21382E917E2BE0FD5E0D3BA3810@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
In-Reply-To: <BAY105-F37E386C7671BF4F79ABE01A3810@phx.gbl>
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: tobiasoed@hotmail.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: RE: [patch] Remove code that has long been commented out from pdc20265_old
Date: Sun, 18 Jun 2006 13:24:56 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2006 17:25:00.0599 (UTC) FILETIME=[20C76470:01C692FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

diff -r -u linux-2.6.17-1/drivers/ide/pci/pdc202xx_old.c 
linux-2.6.17-2/drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.17-1/drivers/ide/pci/pdc202xx_old.c       2006-06-18 
19:00:34.000000000 +0200
+++ linux-2.6.17-2/drivers/ide/pci/pdc202xx_old.c       2006-06-18 
19:00:57.000000000 +0200
@@ -415,8 +415,6 @@
        if (drive->addressing == 1) {
                struct request *rq      = HWGROUP(drive)->rq;
                ide_hwif_t *hwif        = HWIF(drive);
-//             struct pci_dev *dev     = hwif->pci_dev;
-//             unsgned long high_16    = pci_resource_start(dev, 4);
                unsigned long high_16   = hwif->dma_master;
                unsigned long atapi_reg = high_16 + (hwif->channel ? 0x24 : 
0x20);
                u32 word_count  = 0;
@@ -436,7 +434,6 @@
{
        if (drive->addressing == 1) {
                ide_hwif_t *hwif        = HWIF(drive);
-//             unsigned long high_16   = pci_resource_start(hwif->pci_dev, 
4);
                unsigned long high_16   = hwif->dma_master;
                unsigned long atapi_reg = high_16 + (hwif->channel ? 0x24 : 
0x20);
                u8 clock                = 0;
@@ -453,8 +450,6 @@
static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
{
        ide_hwif_t *hwif        = HWIF(drive);
-//     struct pci_dev *dev     = hwif->pci_dev;
-//     unsigned long high_16   = pci_resource_start(dev, 4);
        unsigned long high_16   = hwif->dma_master;
        u8 dma_stat             = hwif->INB(hwif->dma_status);
        u8 sc1d                 = hwif->INB((high_16 + 0x001d));
@@ -492,7 +487,6 @@

static void pdc202xx_reset_host (ide_hwif_t *hwif)
{
-//     unsigned long high_16   = hwif->dma_base - (8*(hwif->channel));
        unsigned long high_16   = hwif->dma_master;
        u8 udma_speed_flag      = hwif->INB(high_16|0x001f);

@@ -554,7 +548,6 @@
static int pdc202xx_tristate (ide_drive_t * drive, int state)
{
        ide_hwif_t *hwif        = HWIF(drive);
-//     unsigned long high_16   = hwif->dma_base - (8*(hwif->channel));
        unsigned long high_16   = hwif->dma_master;
        u8 sc1f                 = hwif->INB(high_16|0x001f);

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

