Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130358AbRBBWWK>; Fri, 2 Feb 2001 17:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130357AbRBBWWC>; Fri, 2 Feb 2001 17:22:02 -0500
Received: from meta.math.spbu.ru ([195.19.229.66]:60164 "EHLO
	meta.math.spbu.ru") by vger.kernel.org with ESMTP
	id <S130277AbRBBWVv>; Fri, 2 Feb 2001 17:21:51 -0500
Date: Sat, 3 Feb 2001 01:23:18 +0300 (MSK)
From: Igor Nekrestyanov <igor@meta.math.spbu.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1: DMA gets disabled due to irq timeout
Message-ID: <Pine.LNX.4.21.0102030103340.5440-100000@meta.math.spbu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying 2.4.1 kernel but under some IO load (bonnie++)
DMA gets disabled with following messages:

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled
ide0: reset: success

I am wondering is there known way how to fix (workaround) this problem?

May it be because of ServerWorks chipset (support for ServerWorks was
compiled in)? or SMP?

Here is except from dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPG3307AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 60046560 sectors (30744 MB) w/2048KiB Cache, CHS=3737/255/63, UDMA(33)

I will appreciate your help, 

-igor

p.s.
  Please cc: me explicitly, because i am not on the list now.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
