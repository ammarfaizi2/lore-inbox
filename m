Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSHBSqr>; Fri, 2 Aug 2002 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSHBSqr>; Fri, 2 Aug 2002 14:46:47 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:8442 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316684AbSHBSqo>; Fri, 2 Aug 2002 14:46:44 -0400
Date: Fri, 2 Aug 2002 14:50:14 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: ide in 2.5.30 is busted
Message-ID: <20020802145014.A29181@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.29 and other kernels are fine on this crashbox, but 2.5.30 falls 
over immediately after booting with:

hdb: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hdb: ide_dma_intr: error=0x84 [ invalid checksum] 
hdb: request error, nr. 1

and a complete lockup of userland.  The hardware is a standard Dell 
box running an SMP kernel, no preempt.  IDE boot messages are below.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82801AA IDE, PCI slot 00:1f.1
ATA: chipset rev.: 2
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82801AA IDE UDMA66 controller on pci00:1f.1
PCI: Setting latency timer of device 00:1f.1 to 64
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
PCI: Setting latency timer of device 00:1f.1 to 64
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD100BB-75AUA1, DISK drive
hdb: WDC WD100BB-75AUA1, DISK drive
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 19541088 sectors w/2048KiB Cache, CHS=19386/16/63, UDMA(66)
 hda: hda1 hda2
 hdb: 19541088 sectors w/2048KiB Cache, CHS=19386/16/63, UDMA(66)
 hdb: hdb1 hdb2 < hdb5 hdb6 >
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)

