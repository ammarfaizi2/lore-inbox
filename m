Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSHFSv7>; Tue, 6 Aug 2002 14:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSHFSv6>; Tue, 6 Aug 2002 14:51:58 -0400
Received: from host.greatconnect.com ([209.239.40.135]:13829 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S315455AbSHFSv6>; Tue, 6 Aug 2002 14:51:58 -0400
Subject: OSB4 issues on 2.4.19-ac4
From: Samuel Flory <sflory@rackable.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 11:55:21 -0700
Message-Id: <1028660121.4771.1242.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  It appears that the OSB4 ide controller isn't working on ac4.  I have
a Tyan 2515, and 2518 which hang when dma is enabled.

The 2518 hangs on a "hdparm -t /dev/hda" after enabling dma:  
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SvrWks OSB4: IDE controller on PCI bus 00 dev 79
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 5T040H4, ATA DISK drive
hdc: Maxtor 5T040H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=4982/255/63
hdc: host protected area => 1
hdc: setmax LBA 80043264, native  78125000
hdc: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=77504/16/63
ide-floppy driver 0.99.newide
Partition check:
 hda: unknown partition table
 hdc: unknown partition table


2515 hangs on a "hdparm -t /dev/hda" after enabling dma:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 18
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfeae0000
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0xdf00-0xdf07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdg:pio, hdh:pio
SvrWks OSB4: IDE controller on PCI bus 00 dev 79
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST320410A, ATA DISK drive
hdc: ST320410A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63
hdc: host protected area => 1
hdc: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
 hdc: [PTBL] [2434/255/63] hdc1 hdc2 hdc3


