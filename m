Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTBDU37>; Tue, 4 Feb 2003 15:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBDU37>; Tue, 4 Feb 2003 15:29:59 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:45523 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267466AbTBDU34>;
	Tue, 4 Feb 2003 15:29:56 -0500
Date: Tue, 4 Feb 2003 21:39:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Cuenta de la lista de linux <user_linux@citma.cu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help with promise sx6000 card
Message-ID: <20030204213903.A21554@ucw.cz>
References: <20030203221923.M79151@webmail.citma.cu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030203221923.M79151@webmail.citma.cu>; from user_linux@citma.cu on Mon, Feb 03, 2003 at 05:19:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

To make a SX6000 card work with Linux:

1) Make sure the card BIOS is enabled.
2) In the BIOS of the card, set it to "Other OS', not Linux
3) Disable support for Promise cards in Linux
4) Enable I2O and I2O block devices
5) Make new kernel & reboot
6) With luck, it'll work. Anyway, SX6000's are DAMN SLOW.

I succeeded last time I tried.

Now to get a SX4000 working, that's a much more interesting task ...

On Mon, Feb 03, 2003 at 05:19:23PM -0500, Cuenta de la lista de linux wrote:
> Hi all:
> 
> I have installed Red Hat 8 with 2.4.18-14 ,i2o support as module, but i can
> not find my card anywhere.
> 
> Here  i am sending you my dmesg and my modules.conf .
> Notes I have a  120GB in hda where i have installed red hat , and 5 hardrives
> in the promise card .
> ............. 
> .........
> 
> VP_IDE: IDE controller on PCI bus 00 dev 21
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
>    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
> PDC20276: IDE controller on PCI bus 02 dev 00
> PDC20276: chipset revision 1
> ide: Found promise 20265 in RAID mode.
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: simplex device:  DMA disabled
> ide2: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: simplex device:  DMA disabled
> ide3: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: IDE controller on PCI bus 02 dev 08
> PDC20276: chipset revision 1
> ide: Found promise 20265 in RAID mode.
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: simplex device:  DMA disabled
> ide4: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: simplex device:  DMA disabled
> ide5: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: IDE controller on PCI bus 02 dev 10
> PDC20276: chipset revision 1
> ide: Found promise 20265 in RAID mode.
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: simplex device:  DMA disabled
> ide6: PDC20276 Bus-Master DMA disabled (BIOS)
> PDC20276: simplex device:  DMA disabled
> ide7: PDC20276 Bus-Master DMA disabled (BIOS)
> hda: WDC WD1200JB-75CRA0, ATA DISK drive
> hdb: no response (status = 0xa1), resetting drive
> hdb: no response (status = 0xa1)
> hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: setmax LBA 234441648, native  234375000
> hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=14589/255/63, UDMA(100)
> ide-floppy driver 0.99.newide
> Partition check:
> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> NET4: Frame Diverter 0.46
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> ide-floppy driver 0.99.newide
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> pci_hotplug: PCI Hot Plug PCI Core version: 0.4
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 16384 buckets, 128Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 220k freed
> VFS: Mounted root (ext2 filesystem).
> SCSI subsystem driver Revision: 1.00
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> I2O Core - (C) Copyright 1999 Red Hat Software
> I2O: Event thread created as pid 17
> I2O Block Storage OSM v0.9
>   (c) Copyright 1999-2001 Red Hat Software.
> i2o_block: registered device at major 80
> i2o_block: Checking for Boot device...
> i2o_block: Checking for I2O Block devices...
> Journalled Block Device driver loaded
> 
> Why is not my RAID under /dev/i2o/hda ?
> 
> David 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
