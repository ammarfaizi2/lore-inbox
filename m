Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSIDTbR>; Wed, 4 Sep 2002 15:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSIDTbQ>; Wed, 4 Sep 2002 15:31:16 -0400
Received: from dsl-213-023-006-169.arcor-ip.net ([213.23.6.169]:59404 "HELO
	is1.blocksberg.com") by vger.kernel.org with SMTP
	id <S315276AbSIDTbF> convert rfc822-to-8bit; Wed, 4 Sep 2002 15:31:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
Date: Wed, 4 Sep 2002 21:35:17 +0200
User-Agent: KMail/1.4.2
References: <200209030153.47433.jh@ionium.org> <3D75B0A1.3070707@hrzpub.tu-darmstadt.de> <1031139394.3017.61.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1031139394.3017.61.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209042135.17630.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 13:36, Alan Cox wrote:
> On Wed, 2002-09-04 at 08:05, Jens Wiesecke wrote:
> > so the problem seems to be BIOS related. But what I don't understand is
> > that since I tell the kernel to use 512 MByte of RAM (mem=512M) and
> > kernels up to 2.4.19pre6 can handle this:
> >
> > What changed and is there a workaround for kernels newer than 2.4.19pre6
> > (for example telling the kernel not to rely on the memory information of
> > the BIOS e820 procedure) ?
> >
> > I tried to compile 2.4.20pre5-(ac) with the arch/i386/kernel/setup.c
> > from 2.4.19pre6 but that didn't work.
>
> I don't know. Without a serial console oops dump I don't have time to
> figure it out either
>

when i used the boot option:
mem=exactmap mem=640K@0 mem=510M@1M
i was able to boot the kernel.

however.. when i tried to boot from a 2.4.19 kernel boot cd, it failed with:



here is the dmesg:

Linux version 2.4.20-pre5-ac1 (root@lux) (gcc version 2.95.3 20010315 
(release)) #1 Sun Sep 1 17:26:49 Local time zone must be set--see zic manua
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000a0000 - 000000001fef0000 (reserved)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000000100000 - 000000001ff00000 (usable)
511MB LOWMEM available.
On node 0 totalpages: 130816
zone(0): 4096 pages.
zone(1): 126720 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=test ro root=304 mem=exactmap mem=640k@0 
mem=510M@1M console=ttyS0,9600n8
Initializing CPU#0
Detected 2019.977 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4023.91 BogoMIPS
Memory: 514460k/523264k available (1052k kernel code, 8420k reserved, 421k 
data, 60k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=64307 max_file_pages=0 max_inodes=0 max_dentries=64307
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfae70, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:02.0
ICH4: Not fully BIOS configured!
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380020A, ATA DISK drive
hdc: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 11 for device 01:04.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe0804000, 00:04:61:42:29:5a, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 60k freed
Adding Swap: 498004k swap-space (priority -1)
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 
45e1.



However.. when i tried to boot from a 2.4.19 boot cd (same boot option as 
above) it only got as far as 


read_super_block: can't find a reiserfs filesystem on (dev 01:00, block 64, 
size 1024)
read_super_block: can't find a reiserfs filesystem on (dev 01:00, block 8, 
size 1024)
XFS: bad magic number
XFS: SB validate failed
Kernel panic: VFS: Unable to mount root fs on 01:00



-- 
Best Regards,
Justin Heesemann

