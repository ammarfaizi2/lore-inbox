Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSFFVHS>; Thu, 6 Jun 2002 17:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317185AbSFFVHR>; Thu, 6 Jun 2002 17:07:17 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:58898 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317191AbSFFVHN>; Thu, 6 Jun 2002 17:07:13 -0400
Date: Thu, 6 Jun 2002 21:21:23 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: Re: Linux 2.4.19-pre10-ac2
Message-ID: <20020606192123.GA197@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <200206051804.g55I4mK19323@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
User-Agent: Mutt/1.5.1i (Linux 2.4.19-pre10-ac2 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jun 05 2002, Alan Cox wrote:

> Linux 2.4.19pre10-ac2
[....]

After updating to pre10-ac2, the second harddisk gives the following error
output in dmesg:

      VP_IDE: not 100% native mode: will probe irqs later
      VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
      ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
      hda: IBM-DHEA-36481, ATA DISK drive
      hdb: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
      hdc: CD-540E, ATAPI CD/DVD-ROM drive
      hdd: CD-W54E, ATAPI CD/DVD-ROM drive
      ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
      ide1 at 0x170-0x177,0x376 on irq 15
      hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
      hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
      hdb: task_no_data_intr: error=0x04 { DriveStatusError }
      hdb: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=619/64/63, DMA
      Partition check:
      [....]

The drive itself works without any problems and is not defective.
All partitions are ext3. Here are the IDE related options from .config:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

hdparm -i says:

/dev/hdb:

Model=Conner Peripherals 1275MB - CFS1275A, FwRev=8.32, SerialNo=EV9228R
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
RawCHS=2477/16/63, TrkSize=40887, SectSize=649, ECCbytes=4
BuffType=DualPortCache, BuffSize=64kB, MaxMultSect=16, MultSect=8
CurCHS=2477/16/63, CurSects=2496816, LBA=yes, LBAsects=2496876
IORDY=on/off, tPIO={min:270,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio3 pio4 
DMA modes: mdma0 mdma1 *mdma2
Kernel Drive Geometry LogicalCHS=619/64/63 PhysicalCHS=2477/16/63

Does anybody know how to fix this/ what's the cause?

     	     Heinz
-- 
# Heinz Diehl, 68259 Mannheim, Germany
