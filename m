Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbRBLOzb>; Mon, 12 Feb 2001 09:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129726AbRBLOzV>; Mon, 12 Feb 2001 09:55:21 -0500
Received: from H-135-207-30-103.research.att.com ([135.207.30.103]:42506 "HELO
	mail-green.research.att.com") by vger.kernel.org with SMTP
	id <S129404AbRBLOzN>; Mon, 12 Feb 2001 09:55:13 -0500
Message-ID: <3A87F935.3CD58613@research.att.com>
Date: Mon, 12 Feb 2001 09:54:45 -0500
From: "D. Sen" <dsen@research.att.com>
Organization: AT&T Labs Research
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en-US,en-GB,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard drive messages on syslog
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any idea whats causing this? 

kernel: hda: status error: status=0x50 { DriveReady SeekComplete }
kernel: hda: no DRQ after issuing WRITE
kernel: hda: status error: status=0x50 { DriveReady SeekComplete }
kernel: hda: no DRQ after issuing WRITE
kernel: hda: lost interrupt
kernel: hda: status error: status=0x50 { DriveReady SeekComplete }
kernel: hda: no DRQ after issuing WRITE
kernel: hda: status error: status=0x50 { DriveReady SeekComplete }
kernel: hda: no DRQ after issuing WRITE
kernel: hda: DMA disabled
kernel: ide0: reset: success

also:
kernel: hda: timeout waiting for DMA
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: timeout waiting for DMA
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: lost interrupt
kernel: hda: timeout waiting for DMA
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: timeout waiting for DMA
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: DMA disabled
kernel: ide0: reset: success

and,

kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: timeout waiting for DMA
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: lost interrupt
kernel: hda: timeout waiting for DMA
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: timeout waiting for DMA
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: hda: irq timeout: status=0x50 { DriveReady SeekComplete }
kernel: hda: DMA disabled
kernel: ide0: reset: success


Its a 32 G drive on a TP 21. I see the messages on kernels 2.2.17,
2.2.18 and 2.4.1. More info from the syslog:

Feb 12 08:36:12 localhost kernel: block: queued sectors max/low
169677kB/56559kB, 512 slots per queue
Feb 12 08:36:12 localhost kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Feb 12 08:36:12 localhost kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Feb 12 08:36:12 localhost kernel: PIIX4: IDE controller on PCI bus 00
dev 39
Feb 12 08:36:12 localhost kernel: PIIX4: chipset revision 1
Feb 12 08:36:12 localhost kernel: PIIX4: not 100%% native mode: will
probe irqs later
Feb 12 08:36:12 localhost kernel:     ide0: BM-DMA at 0x1c10-0x1c17,
BIOS settings: hda:DMA, hdb:pio
Feb 12 08:36:12 localhost kernel:     ide1: BM-DMA at 0x1c18-0x1c1f,
BIOS settings: hdc:DMA, hdd:pio
Feb 12 08:36:12 localhost kernel: hda: IBM-DJSA-232, ATA DISK drive
Feb 12 08:36:12 localhost kernel: hdc: MATSHITADVD-ROM SR-8175, ATAPI
CD/DVD-ROM drive
Feb 12 08:36:12 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 08:36:12 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 08:36:12 localhost kernel: hda: 62506080 sectors (32003 MB)
w/1874KiB Cache, CHS=4134/240/63, UDMA(33)
Feb 12 08:36:12 localhost kernel: Partition check:
Feb 12 08:36:12 localhost kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6
hda7 hda8 >


(Please cc the responses to me as I am not subscribed to the list)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
