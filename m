Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271825AbRIEHxd>; Wed, 5 Sep 2001 03:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271822AbRIEHxZ>; Wed, 5 Sep 2001 03:53:25 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:24900 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271810AbRIEHxQ>; Wed, 5 Sep 2001 03:53:16 -0400
Date: Wed, 5 Sep 2001 08:52:51 +0100
From: kernel@corrosive.freeserve.co.uk
To: linux-kernel@vger.kernel.org
Subject: IDE Problems on SIS 735?
Message-ID: <20010905085251.A3154@corrosive.freeserve.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.9-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've been having repeated DMA problems on my SIS 735 based board, I've done a
search for the meaning of the error message I'm getting, but I must be looking
in the wrong places since I can't seem to find something that explains it
fully.  Since this chipset is fairly new I thought I'd mention it here to see
if anyone has an idea what might be wrong (I'm suspecting the cables, but I've
already swapped them over once..).

I've stuck some (possibly) useful/relevant information below.  I'm running
2.4.9-ac7.

Cheers,
Adrian.

(Boot information)
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 91024U4, ATA DISK drive
hdb: FUJITSU MPE3064AT, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 9300, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19999728 sectors (10240 MB) w/2048KiB Cache, CHS=1244/255/63, UDMA(66)
hdb: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=788/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 >
 hdb: hdb1 hdb2 < hdb5 >

(Error message itself)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command

(Result from "cat /proc/ide/sis")
--------------- Primary Channel ---------------- Secondary Channel -------------
Channel Status: On 	 	 	 	 On 
Operation Mode: Compatible 	 	 	 Compatible 
Cable Type:     80 pins 	 	 	 80 pins
Prefetch Count: 512 	 	 	 	 512
Drive 0:        Postwrite Enabled 	 	 Postwrite Disabled
                Prefetch  Enabled 	 	 Prefetch  Disabled
                UDMA Enabled 	 	 	 UDMA Enabled
                UDMA Cycle Time    2 CLK 	 UDMA Cycle Time    2 CLK
                Data Active Time   2 PCICLK 	 Data Active Time   5 PCICLK
                Data Recovery Time 1 PCICLK 	 Data Recovery Time 1 PCICLK
Drive 1:        Postwrite Enabled 	 	 Postwrite Disabled
                Prefetch  Enabled 	 	 Prefetch  Disabled
                UDMA Enabled 	 	 	 UDMA Enabled
                UDMA Cycle Time    2 CLK 	 UDMA Cycle Time    2 CLK
                Data Active Time   2 PCICLK 	 Data Active Time   2 PCICLK
                Data Recovery Time 1 PCICLK 	 Data Recovery Time 1 PCICLK

