Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbSL3Xtn>; Mon, 30 Dec 2002 18:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267090AbSL3XsO>; Mon, 30 Dec 2002 18:48:14 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:3593 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S267104AbSL3Xps>; Mon, 30 Dec 2002 18:45:48 -0500
Message-Id: <5.1.1.6.2.20021231003031.03333370@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Tue, 31 Dec 2002 00:54:17 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: system_lists@nullzone.org
Subject: Re: Highpoint HPT370 not working in 2.4.18+ versions
Cc: Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041253856.13076.5.camel@irongate.swansea.linux.org.uk>
References: <5.1.1.6.2.20021230100446.03168ec8@192.168.2.131>
 <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>
 <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>
 <5.1.1.6.2.20021230100446.03168ec8@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:10 30/12/2002 +0000, Alan Cox wrote:
>On Mon, 2002-12-30 at 09:10, system_lists@nullzone.org wrote:
> >
> > Hi there Scott,
> >
> >     my card (which not need any patch for working on in 2.4.18 but doesnt
> > work (its simply not detected) on next versions) is:
> >
> > HighPoint Technologies, Inc.
> > HPT370 UDMA/ATA100 RAID Controller BIOS v1.0.3b1
> >
> > have u any idea?
>
>Make sure you have the HPT driver compiled into your kernel

Yes,

   i will rewrite my original mail:

----------


* BOOTing using 2.4.18 (All ok here)
--------
VP_IDE: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
HPT370A: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 11 for device 00:0a.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
hda: FUJITSU MPA3026ATU, ATA DISK drive
hde: ST380020A, ATA DISK drive
hdf: ST360020A, ATA DISK drive
hdg: ST380020A, ATA DISK drive
hdh: ST360020A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xb000-0xb007,0xb402 on irq 11
ide3 at 0xb800-0xb807,0xbc02 on irq 11
hda: 5126964 sectors (2625 MB), CHS=635/128/63
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(33)
hdf: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(33)
hdh: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
Partition check:
hda: hda1 hda2 hda3 hda4
hde: unknown partition table
hdf: unknown partition table
hdg: [PTBL] [9729/255/63] hdg1
hdh: unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
ataraid/d0: ataraid/d0p1
Highpoint HPT370 Softwareraid driver for linux version 0.01
Drive 0 is 76319 Mb
Drive 1 is 57241 Mb
Raid array consists of 2 drives.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
--------


* BOOTing using 2.4.20 (or 2.4.21-pre2)
--------------------
...
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
Highpoint HPT370 Softwareraid driver for linux version ...
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
...

You can notice how the driver for HPT is loaded but nothing is found.
OF COURSE hde hdf etc is NOT found .. (at the begining of the boot).

Let me know what exactly u need for a good debug and i will get u all 
notes/files u need.

--------


>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/




