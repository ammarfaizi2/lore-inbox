Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTATSmp>; Mon, 20 Jan 2003 13:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbTATSmp>; Mon, 20 Jan 2003 13:42:45 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:27062 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S262469AbTATSml>; Mon, 20 Jan 2003 13:42:41 -0500
Message-ID: <3E2C4535.70902@bogonomicon.net>
Date: Mon, 20 Jan 2003 12:51:33 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
References: <Pine.LNX.4.10.10301191521020.12087-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10301191521020.12087-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------090602090600070003060401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090602090600070003060401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Andre Hedrick wrote:
> One thing to ask, did you get an 0x51 , 0x04 error set prior to seeing the
> flush cache message error?

No.  I've attached the dmesg output from the system.  Look near the end 
of the file.  All I see are repeated "ide: no cache flush required." 
messages.  Often one right after another.  I can spawn another one by 
closing an IDE HD.  Is there something I can do to generate the 
0x51/0x04 error message set?  At this point the system hasn't entered 
production so I can still play with it.

> If not then those changes need to be stripped out as more proof of letting
> the device protect itself from properly formed commands.
> 
> The change to hid one noise maker pollutes another wrongly.

>>To me they seam like a candidate for output at a higher
>>debug level or ide specific debug.  They aren't a driver
>>setup, odd condition, or error message.

--------------090602090600070003060401
Content-Type: text/plain;
 name="dmesg.blip.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.blip.txt"

Linux version 2.4.21-pre3-ac4 (root@blip) (gcc version 2.95.4 20011002 (Debian prerelease)) #21 SMP Sun Jan 19 13:54:23 CST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 ide0=ata66 ide1=ata66
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Found and enabled local APIC!
Initializing CPU#0
Detected 1737.276 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515228k/524224k available (1600k kernel code, 8604k reserved, 676k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU0: AMD Athlon(tm) XP 2100+ stepping 02
per-CPU timeslice cutoff: 731.30 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1737.2988 MHz.
..... host bus clock speed is 267.2768 MHz.
cpu: 0, clocks: 2672768, slice: 1336384
CPU0<T0:2672768,T1:1336384,D:0,S:1336384,C:2672768>
migration_task 0 on cpu=0
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 33 at 0xe0800000, 00:A0:CC:3B:5A:6B, IRQ 10.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unsupported bridge
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 01:07.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hda: C/H/S=22070/16/255 from BIOS ignored
hda: Maxtor 54610H6, ATA DISK drive
hdb: CREATIVE DVD-ROM DVD1241E, ATAPI CD/DVD-ROM drive
blk: queue c03c0e40, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 54610H6, ATA DISK drive
blk: queue c03c12ac, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 4G160J8, ATA DISK drive
blk: queue c03c1718, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4G160J8, ATA DISK drive
blk: queue c03c1b84, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9402 on irq 10
ide3 at 0x9800-0x9807,0x9c02 on irq 10
hda: host protected area => 1
hda: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdc: host protected area => 1
hdc: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hde: host protected area => 1
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdb: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
 hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
 hde: hde1 hde2
 hdg: hdg1 hdg2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 1999832k swap-space (priority -1)
Adding Swap: 1999832k swap-space (priority -2)
Adding Swap: 530104k swap-space (priority -3)
Adding Swap: 530104k swap-space (priority -4)
ide: no cache flush required.
ide: no cache flush required.
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
nvidia: loading NVIDIA Linux x86 NVdriver Kernel Module  1.0-3123  Tue Aug 27 15:56:48 PDT 2002
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
 [events: 0000000c]
md: bind<hdc7,1>
 [events: 0000000c]
md: bind<hda7,2>
md: hda7's event counter: 0000000c
md: hdc7's event counter: 0000000c
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda7 operational as mirror 0
raid1: device hdc7 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hda7 [events: 0000000d]<6>(write) hda7's sb offset: 28772736
md: hdc7 [events: 0000000d]<6>(write) hdc7's sb offset: 28772736
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide3(34,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
eth0: Setting full-duplex based on MII#1 link partner capability of 05e1.
spurious 8259A interrupt: IRQ7.
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: DMA disabled
hdb: ATAPI reset complete
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0x40LastFailedSense 0x04 
hdb: ATAPI reset complete
end_request: I/O error, dev 03:40 (hdb), sector 0
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
ide: no cache flush required.
VFS: Can't find ext3 filesystem on dev ide1(22,6).
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ide: no cache flush required.

--------------090602090600070003060401--

