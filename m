Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262771AbTCVODB>; Sat, 22 Mar 2003 09:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbTCVODB>; Sat, 22 Mar 2003 09:03:01 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:26107 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S262771AbTCVOC4>;
	Sat, 22 Mar 2003 09:02:56 -0500
Date: Sat, 22 Mar 2003 15:13:54 +0100 (CET)
From: Jody Pearson <J.Pearson@cern.ch>
X-X-Sender: jpearson@lxplus072.cern.ch
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1 Cardbus does not work
Message-ID: <Pine.LNX.4.44.0303221512300.31801-100000@lxplus072.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I can confirm this problem with 2.5.65-mm1 running on an ACER Aspire 1300.

I can't figure out why card services complains with
cs: unable to map card memory!

I also have a niggling problem with the CPU frequency scaling - 
2.5.65-mm1 seems to think that the maximum
frequency for my CPU is 700Mhz - the real max is double that.

I have also had error messages about running out of MTRR's.

Mar 22 13:04:16 jplaptop kernel: mtrr: no more MTRRs available

I include cpuinfo, and dmesg below.

Any pointers would be very much appreciated.

Thanks

Jody Pearson

[root@jplaptop root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : mobile AMD Athlon(tm) XP 1800+
stepping        : 0
cpu MHz         : 799.894
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 1581.41

Linux version 2.5.65-mm1 (root@jplaptop.jody.dyndns.org) (gcc version 
3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #8 Sat Mar 22 14:42:28 CET 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000effffc0 (ACPI data)
 BIOS-e820: 000000000effffc0 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 OID_00                     ) @ 0x000e4010
ACPI: RSDT (v001 OID_00 RSDT_000 12336.12336) @ 0x0efffbc0
ACPI: FADT (v001 INSYDE FACP_000 00000.00256) @ 0x0efffac0
ACPI: BOOT (v001 INSYDE SYS_BOOT 00000.00256) @ 0x0efffb50
ACPI: DBGP (v001 INSYDE SYS_DBGP 00000.00256) @ 0x0efffb80
ACPI: DSDT (v001 INSYDE   VT8362 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1533.131 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3031.04 BogoMIPS
Memory: 239572k/245696k available (1824k kernel code, 5424k reserved, 
738k data, 128k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD mobile AMD Athlon(tm) XP 1800+  stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xe8a64, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11)
Linux Plug and Play Support v0.95 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
PCI: Cannot allocate resource region 0 of device 00:0a.0
NET4: Frame Diverter 0.46
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00e5100
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 1 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:0 (@c00e5110)
powernow:  cpuid: 0x780    fsb: 100    maxFID: 0x1    startvid: 0x9
powernow:    FID: 0x4 (5.0x [500MHz])    VID: 0xc (1.400V)
powernow:    FID: 0x4 (5.0x [500MHz])    VID: 0xc (1.400V)
powernow:    FID: 0x4 (5.0x [500MHz])    VID: 0xc (1.400V)
powernow:    FID: 0x4 (5.0x [500MHz])    VID: 0xc (1.400V)
powernow:    FID: 0x6 (6.0x [600MHz])    VID: 0xc (1.400V)

powernow: Minimum speed 500 MHz. Maximum speed 600 MHz.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Initializing Cryptographic API
Applying VIA southbridge workaround.
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (81 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.11
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Enabling device 00:12.0 (0001 -> 0003)
divert: allocating divert_blk for eth0
eth0: VIA VT6102 Rhine-II at 0xe800, 00:c0:9f:1f:b7:a9, IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link 
45e1.
orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=38760/16/63, 
UDMA(100)
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
Yenta IRQ list 0038, PCI irq11
Socket status: 30000411
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Linux I2O PCI support (c) 1999-2002 Red Hat.
i2o: Checking for PCI I2O controllers...
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 10
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
PCMCIA: insert failed: -16
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,3): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1630429
EXT3-fs: ide0(3,3): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Adding 521632k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Module parport cannot be unloaded due to unsafe usage in 
include/linux/module.h:457
Module parport_pc cannot be unloaded due to unsafe usage in 
include/linux/module.h:457
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?




