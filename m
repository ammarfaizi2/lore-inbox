Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281297AbRKTTtG>; Tue, 20 Nov 2001 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281302AbRKTTsr>; Tue, 20 Nov 2001 14:48:47 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:3278 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S281297AbRKTTsg>;
	Tue, 20 Nov 2001 14:48:36 -0500
Date: Tue, 20 Nov 2001 20:48:30 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.15pre6: CONFIG_APM=m causes hangup on boot
Message-ID: <Pine.GSO.4.30.0111202035080.19555-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've just been playing with config possibilities and found that if i
compile a kernel with CONFIG_APM=m it hangs during boot (see bootlog).
If i choose CONFIG_APM=y everything works well except that i cannot use
acpi since apm is initialized first (btw, why?? -> i would rahter use acpi
if both are available).

The kernel is 2.4.15pre6 with lowlatency +preempt patch. (hope that
doesn't matter, sorry but didn't have time to check w/o them)
The machine is p3/800 in a abit vp6 mobo.


The hangup is pretty interesting: Only sysrq keys work (even shift-PGUP
stops working), but after a short time (say 15 secs) the machine gets
completely dead.


The bootlog (from the same kernel with CONFIG_APM=y):

Linux version 2.4.15-pre6 (pozsy@localhost.localdomain) (gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)) #4 SMP Sun Nov 18 19:22:04 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: root=/dev/hda3 apm=power-off hdc=ide-scsi noapic
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 798.709 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 512980k/524224k available (1544k kernel code, 10856k reserved, 409k data, 248k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order:
6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order:
7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping
06
per-CPU timeslice cutoff: 731.14 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Error: only one processor found.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 798.7140 MHz.
..... host bus clock speed is 133.1188 MHz.
cpu: 0, clocks: 1331188, slice: 665594
CPU0<T0:1331184,T1:665584,D:6,S:665594,C:1331188>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0,
last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.120 (20011103) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: APM is already active, exiting
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision:
6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 11 for device 00:0e.0
HPT370: chipset revision 3
HPT370: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:DMA
hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive

--->  CONFIG_APM=m hangs here.

hde: Maxtor 54610H6, ATA DISK drive
hdh: Maxtor 54610H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe000-0xe007,0xe402 on irq 11
hda: 40132503 sectors (20548 MB) w/1902KiB Cache, CHS=39813/16/63, UDMA(100)
hde: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdh: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5
p6 >
 /dev/ide/host2/bus1/target1/lun0: p1 p2 p3
Highpoint HPT370 Softwareraid driver for linux version 0.01
No raid array found
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 248k freed
Real Time Clock Driver v1.10e
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27


-- 
Balazs Pozsar.

