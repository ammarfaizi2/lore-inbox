Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSGaHyO>; Wed, 31 Jul 2002 03:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317847AbSGaHyO>; Wed, 31 Jul 2002 03:54:14 -0400
Received: from gremlin.ics.uci.edu ([128.195.1.70]:21984 "HELO
	gremlin.ics.uci.edu") by vger.kernel.org with SMTP
	id <S317842AbSGaHyN>; Wed, 31 Jul 2002 03:54:13 -0400
Date: Wed, 31 Jul 2002 00:57:31 -0700 (PDT)
From: Mukesh Rajan <mrajan@ics.uci.edu>
To: linux-kernel@vger.kernel.org
cc: mlord@pobox.com
Subject: IDE, putting HD to sleep causes "lost interrupt"
Message-ID: <Pine.SOL.4.20.0207310013490.15380-100000@hobbit.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

things work perfectly fine on my desktop. but on my laptop (toshiba
satellite) if i try,

%hdparm -Y /dev/hda           <--- put to sleep followed by
%hdparm -C /dev/hda           <--- query status

gives me

hda: lost interrupt
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: lost interrupt
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: DMA disabled
ide0: reset: success

if i try the above from X, the machine freezes and i need to do hard
reboot.

the boot message regarding ide are as follows

boot messages
-------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 20
PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using
pci=biosirq.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive

the closest i think i got to on google is the following but there are no
answers

http://mail.nl.linux.org/kernelnewbies/2001-01/msg00064.html

please help.

- mukesh

