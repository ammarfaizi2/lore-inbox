Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTAWWH0>; Thu, 23 Jan 2003 17:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTAWWH0>; Thu, 23 Jan 2003 17:07:26 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:19644 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267335AbTAWWHV>; Thu, 23 Jan 2003 17:07:21 -0500
Message-ID: <3E3069B8.1030209@bogonomicon.net>
Date: Thu, 23 Jan 2003 16:16:24 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: thunder7@xs4all.nl
Subject: Re: 2.4.21pre3-ac4 ide trouble (HPT370 and IBM DTLA-30745)
References: <20030123121527.GA29958@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen something that may be related with a disk on a PDC20269 based 
IDE controller.  The disk initially came up under DMA, but experienced a 
DMA error and DMA was disabled for that disk.  My motherboard is ASUS 
A7N8X with an nForce2 chipset.  I'm trying to recreate it but haven't 
had any luck.

Jurriaan wrote:
> I've just upgraded to a new motherboard, and now I have a disk that
> won't do DMA anymore. It used to work with the same kernel on a Promise
> 20265 controller, but on the new HPT370 it doesn't work (or at least,
> doesn't do DMA):


This dmesg output dosen't contain the messages from the DMA loss. 
Unfortunately that dmesg output was lost.  I'm including this one to 
provide system configuration information.  There is also an output from 
/proc/interrupts at the end.
---------------
Linux version 2.4.21-pre3-ac4 (root@blip) (gcc version 2.95.4 20011002 
(Debian prerelease)) #21 SMP Sun Jan 19 13:54:23 CST 2003
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
Detected 1737.273 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515228k/524224k available (1600k kernel code, 8604k reserved, 
676k data, 112k init, 0k highmem)
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
..... CPU clock speed is 1737.3002 MHz.
..... host bus clock speed is 267.2769 MHz.
cpu: 0, clocks: 2672769, slice: 1336384
CPU0<T0:2672768,T1:1336384,D:0,S:1336384,C:2672769>
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
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
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
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)
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
nvidia: loading NVIDIA Linux x86 NVdriver Kernel Module  1.0-3123  Tue 
Aug 27 15:56:48 PDT 2002
PCI: Setting latency timer of device 00:04.0 to 64
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
  [events: 0000001a]
md: bind<hdc7,1>
  [events: 0000001a]
md: bind<hda7,2>
md: hda7's event counter: 0000001a
md: hdc7's event counter: 0000001a
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda7 operational as mirror 0
raid1: device hdc7 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hda7 [events: 0000001b]<6>(write) hda7's sb offset: 28772736
md: hdc7 [events: 0000001b]<6>(write) hdc7's sb offset: 28772736
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
spurious 8259A interrupt: IRQ7.
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
NVRM: AGPGART: unable to retrieve symbol table
spurious 8259A interrupt: IRQ15.
---------------
# cat interrupts
            CPU0
   0:    4563852          XT-PIC  timer
   1:      15453          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:    9490010          XT-PIC  eth0
   8:          3          XT-PIC  rtc
  10:   11549087          XT-PIC  ide2, ide3, nvidia
  12:     359011          XT-PIC  PS/2 Mouse
  14:     191436          XT-PIC  ide0
  15:     107507          XT-PIC  ide1
NMI:          0
LOC:    4563809
ERR:     206558
MIS:          0
---------------

