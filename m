Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318957AbSH1Uh5>; Wed, 28 Aug 2002 16:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318960AbSH1Uhx>; Wed, 28 Aug 2002 16:37:53 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:12552 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318957AbSH1Uhd>; Wed, 28 Aug 2002 16:37:33 -0400
Date: Wed, 28 Aug 2002 22:41:30 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com
Subject: Re: ide-2.4.20-pre4-ac2.patch
Message-ID: <20020828204130.GA16551@louise.pinerecords.com>
References: <20020828182616.GA16018@louise.pinerecords.com> <Pine.LNX.4.10.10208281126560.24156-100000@master.linux-ide.org> <20020828183153.GB16018@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020828183153.GB16018@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 3 days, 12:55
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Big jump in clean up and debloating.
> > If you try the patch and it repeats, you can re-LART me.
> 
> Since I have to reinstall the darn system anyway, I will
> at least test the patch. Will let you know later tonight.

Okay, I screwed up. Obviously I haven't had much sleep lately.
In the end it _was_ the new code that made me feel soooo happy
today. So another sorry goes to Alan for blaming 2.4.20-pre4-ac2.
What a fine example of hasty reporting I've managed to display. :)

Let's revise, though:

$ tar xzf linux-2.4.19.tgz
$ mv linux-2.4.19 linux-2.4.20-pre4-ac2-newide
$ cd linux-2.4.20-pre4-ac2-newide
$ zcat ../patch-2.4.20-pre4.gz ../patch-2.4.20-pre4-ac2.gz \
	../2.4.20-pre4-ac2-newide.gz| patch -sp1
$ vi Makefile
	(modify EXTRAVERSION)
$ cp /tmp/.config .
$ make oldconfig dep clean bzImage modules

...

Proceed to boot with 'init=/bin/bash ro':

Linux version 2.4.20-pre4-ac2-newide (kala@nibbler) (gcc version 3.2) #2 Wed Aug 28 21:51:20 CEST 2002BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f1a60 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000005fffc00 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
95MB LOWMEM available.
On node 0 totalpages: 24575
zone(0): 4096 pages.
zone(1): 20479 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=test ro root=900 ide2=ata66 ide3=ata66 reboot=w init=/bin/bash
ide_setup: ide2=ata66
ide_setup: ide3=ata66
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 233.035 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 465.30 BogoMIPS
Memory: 94696k/98300k available (1184k kernel code, 3212k reserved, 281k data, 256k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=11837 max_file_pages=0 max_inodes=0 max_dentries=11837
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
CPU:             Common caps: 0080fbff 00000000 00000000 00000000
CPU: Intel Pentium II (Klamath) stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 233.0181 MHz.
..... host bus clock speed is 66.5763 MHz.
cpu: 0, clocks: 665763, slice: 332881
CPU0<T0:665760,T1:332864,D:15,S:332881,C:665763>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf6ebd, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:04.1
PCI: Enabling device 00:04.1 (0000 -> 0001)
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
PDC20268: IDE controller at PCI slot 00:06.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xf8b0-0xf8b7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xf8b8-0xf8bf, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD205BA, ATA DISK drive
hde: DMA disabled
hde: DMA disabled
hde: DMA disabled
hdg: IBM-DJNA-351520, ATA DISK drive
hdg: DMA disabled
hdg: DMA disabled
hdg: DMA disabled
ide2 at 0xf898-0xf89f,0xf8aa on irq 9
ide3 at 0xf8a0-0xf8a7,0xf8ae on irq 9
hde: host protected area => 1
hde: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63
hdg: host protected area => 1
hdg: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=29795/16/63
Partition check:
 hde: [PTBL] [2495/255/63] hde1 hde2 hde3
 hdg: [PTBL] [1869/255/63] hdg1 hdg2
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
[snip]

Right, let's play "mess the fs," shall we?

init-2.05a# mount -o remount,rw /
init-2.05a# >x
hde: status error: status=0x50 { DriveReady SeekComplete }

hde: no DRQ after issuing WRITE
hdg: status error: status=0x50 { DriveReady SeekComplete }

hdg: no DRQ after issuing WRITE
init-2.05a# sync

--> You are now dead. Thanks for using stop'n'drop.

T.
