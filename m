Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136859AbREKGrc>; Fri, 11 May 2001 02:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137064AbREKGrX>; Fri, 11 May 2001 02:47:23 -0400
Received: from smtp7.xs4all.nl ([194.109.127.133]:14076 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S137082AbREKGrG>;
	Fri, 11 May 2001 02:47:06 -0400
From: thunder7@xs4all.nl
Date: Fri, 11 May 2001 08:44:17 +0200
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.4.4-ac6: timeout waiting for DMA on hpt370 / ibm DJNA drive
Message-ID: <20010511084417.A4460@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got these messages in 2.4.4-ac5, and now in 2.4.4-ac6, when I expire
my news-spool. In 2.4.4, there's no problem expring my newsspool and
running 2 bonnie's in the background.

May 11 00:47:25 middle kernel: hdg: timeout waiting for DMA
May 11 00:47:25 middle kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May 11 00:47:25 middle kernel: hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
May 11 00:56:20 middle kernel: hdg: timeout waiting for DMA
May 11 00:56:20 middle kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May 11 00:56:20 middle kernel: hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
May 11 00:56:30 middle kernel: hdg: timeout waiting for DMA
May 11 00:56:30 middle kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May 11 00:56:30 middle kernel: hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }

Info from 2.4.4:

block: queued sectors max/low 340506kB/209434kB, 1024 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 33073H3, ATA DISK drive
hde: IBM-DTLA-307045, ATA DISK drive
hdg: IBM-DJNA-372200, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdc00-0xdc07,0xe002 on irq 10
ide3 at 0xe400-0xe407,0xe802 on irq 10
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdg: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=43800/16/63, UDMA(33)
Partition check:
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 > hda4
 hde: [PTBL] [5606/255/63] hde1 hde2 hde3 hde4
 hdg: hdg1 hdg2 hdg3 hdg4
Floppy drive(s): fd0 is 1.44M


                                HPT370 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no 
UDMA
DMA
PIO

Good luck,
Jurriaan
-- 
BOFH excuse #24:

network packets travelling uphill (use a carrier pigeon)
GNU/Linux 2.4.4 SMP/ReiserFS 2x1402 bogomips load av: 0.42 0.10 0.03
