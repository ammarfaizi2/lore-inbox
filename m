Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbRCNXvi>; Wed, 14 Mar 2001 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131583AbRCNXvS>; Wed, 14 Mar 2001 18:51:18 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:17882 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S131581AbRCNXvJ>;
	Wed, 14 Mar 2001 18:51:09 -0500
Date: Thu, 15 Mar 2001 00:50:21 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IDE poweroff -> hangup
Message-ID: <Pine.GSO.4.30.0103150041540.14732-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I was courious, and I tried what happens if I power down my harddisk (ie
manually pull the power plug out), and then power it on again after a few
secs (put the plug back).

I do not know if the system should survive happily such an 'accident', but
it hadn't:
A few secs after the next access to the disc, I got the following on the
console:
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
and the machine froze the hard way (no respond to sysrq).

Tell me if this shouldn't be honoured by the kernel, but if there's a bug
around, here's some info:

Linux version 2.4.2 (root@brefatox.hell) (gcc version 2.95.3 19991030 (prerelease)) #1 SMP Wed Mar 7 22:58:36 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000017ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000017ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000017ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Lint: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 1
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: root=/dev/hdg4 apm=power-off noapic mem=393152K
Initializing CPU#0
Detected 434.815 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 865.07 BogoMIPS
Memory: 384580k/393152k available (856k kernel code, 8184k reserved, 294k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.86 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
CPU present map: 1
Before bogomips.
Error: only one processor found.
Boot done.
calibrating APIC timer ...
..... CPU clock speed is 434.8114 MHz.
..... host bus clock speed is 66.8940 MHz.
cpu: 0, clocks: 668940, slice: 334470
CPU0<T0:668928,T1:334448,D:10,S:334470,C:668940>
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 255296kB/124224kB, 768 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 11 for device 00:0e.0
PCI: The same IRQ used for device 00:0d.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
hdf: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdg: QUANTUM FIREBALLlct20 20, ATA DISK drive
ide2 at 0xdc00-0xdc07,0xe002 on irq 11
ide3 at 0xe400-0xe407,0xe802 on irq 11
hdg: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(100)
Partition check:
 /dev/ide/host2/bus1/target0/lun0: p1 p2 p3 p4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 184k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
SCSI subsystem driver Revision: 1.00
hdf: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache
Uniform CD-ROM driver Revision: 3.12
...

regards,
Balazs Pozsar.

