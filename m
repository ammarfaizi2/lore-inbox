Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292932AbSCSVsq>; Tue, 19 Mar 2002 16:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292888AbSCSVsg>; Tue, 19 Mar 2002 16:48:36 -0500
Received: from Expansa.sns.it ([192.167.206.189]:26636 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S292870AbSCSVsX>;
	Tue, 19 Mar 2002 16:48:23 -0500
Date: Tue, 19 Mar 2002 22:48:33 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <3C9788B0.30100@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203192243290.28639-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> > that is: __get_hash_table
>
> The only code which could use this can propably be
> the partition table grocking code!
> So apparently the driver is oopsing on the first actual transfer attempts.
> By the way I have found the following on my desktop system:
>
>
> 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
>          Subsystem: Intel Corporation 82801AA IDE
>          Flags: bus master, medium devsel, latency 0
>          I/O ports at 1020 [size=16]
>
>
> So heck this is precisely the same chipset as yours!
> And I'm writing this message exactly on very this system!
>
> However what may be significant is the following:
>
> VFS: Diskquotas version dquot_6.4.0 initialized
> Journalled Block Device driver loaded
> pty: 2048 Unix98 ptys configured
> Real Time Clock Driver v1.11
> block: 256 slots per queue, batch=32
> Uniform Multi-Platform E-IDE driver ver.:7.0.0
> ide: system bus speed 33MHz
> Intel Corp. 82801AA IDE: IDE controller on PCI slot 00:1f.1
> Intel Corp. 82801AA IDE: chipset revision 2
> Intel Corp. 82801AA IDE: not 100% native mode: will probe irqs later
> PIIX: Intel Corp. 82801AA IDE UDMA66 controller on pci00:1f.1
>      ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:DMA
> hda: IBM-DPTA-372050, ATA DISK drive
> hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> hdd: LTN485S, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> blk: queue c02c076c, I/O limit 4095Mb (mask 0xffffffff)
> hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
> Partition check:
>   hda: hda1 hda2
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
>

> Could you please just underline where the oops occurs above?

 Intel Corp. 82801AA IDE: IDE controller on PCI slot 00:1f.1
 Intel Corp. 82801AA IDE: chipset revision 2
 Intel Corp. 82801AA IDE: not 100% native mode: will probe irqs later
 PIIX: Intel Corp. 82801AA IDE UDMA66 controller on pci00:1f.1

wait a couple of seconds

      ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
      ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:DMA

OOPS!!


>
> I would rather expect it to happen before the Parition check part.
>
> Please note as well that the only single real disk in this system
> is enabled to do UDMA by default. What's the status of yours?
> It could well be that the PIO code is the culprit here.
I have just hdam which is configured to use DMA66 as default, as I can see
from 2.4.18 boot messages.
Then i have an ATA cdrom on hdc.
>
> Do you have the ATA floppy driver enabled?
no
> I use a setup on this system where everything with the exception of
> hard disks is compiled as module.
me too.

Tomorrow I will provide more details on the disk. I use DMA as default,
and not PIO.

Luigi


