Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUDMEyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUDMEyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:54:10 -0400
Received: from [210.55.139.211] ([210.55.139.211]:54247 "EHLO
	giger.nz.reeltwo.com") by vger.kernel.org with ESMTP
	id S263315AbUDMExD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:53:03 -0400
Message-ID: <407B7228.802@reeltwo.com>
Date: Tue, 13 Apr 2004 16:52:56 +1200
From: Stuart Inglis <stuart@reeltwo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 5GB instead of 6GB RAM using 2.6.5 x86_64 (amd)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a dual Opteron 244 on a Tyan Thunder K8W/S2885 m/b.

It is a custom compiled vanilla 2.6.5 kernel.

It has 3 x 2GB RAM modules installed, 2 on one CPU and the other RAM 
module on the other CPU. The BIOS reports 6144MB on boot up.

An AGP line reports (see dmesg below)

   agpgart: Maximum main memory to use for agp memory: 5944M

during bootup, so the kernel looks like it thinks we have ~6GB available.

But a free reports 5GB, not 6GB.

Does anyone know where the missing 1GB is?

cheers
Stuart

--free--
              total     used     free  shared buffers cached
Mem:       5126164  2824632  2301532       0    5812 417316
-/+ buffers/cache:  2401504  2724660
Swap:     32764556  5279976 27484580



--dmesg follows--
al zone: 1044479 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
setting up node 1 100000-17ffff
On node 1 totalpages: 524287
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 524287 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 
0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 
0x00000000bfff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 
0x00000000bfff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 
0x00000000bfff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 
0x00000000bffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 
0x00000000bfff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 
0x00000000bfff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 
0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xff4fe000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xff4fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xff4ff000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xff4ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Kernel command line: ro root=/dev/hda3 rhgb console=tty0
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1794.707 MHz processor.
Console: colour VGA+ 80x25
Memory: 5125168k/6291456k available (2903k kernel code, 0k reserved, 
1036k data, 220k init)
Calibrating delay loop... 3530.75 BogoMIPS
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 244 stepping 08
per-CPU timeslice cutoff: 1024.02 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10037f2df58
Initializing CPU#1
Calibrating delay loop... 3588.09 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 244 stepping 08
Total of 2 processors activated (7118.84 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.463 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully 
acquired
Parsing all Control 
Methods:................................................................................................................................................
Table [DSDT](id F004) - 519 Objects with 45 Devices 144 Methods 13 Regions
ACPI Namespace successfully loaded at root ffffffff80531e60
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
0000000000005020 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 5 
Runtime GPEs in this block
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 16 to 47 [_GPE] 4 regs at 
00000000000050B0 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 1 
Runtime GPEs in this block
Completing Region/Field/Buffer/Package 
initialization:.........................................................................................................................................
Initialized 12/13 Regions 68/68 Fields 39/39 Buffers 18/18 Packages (528 
nodes)
Executing all Device _STA and_INI 
methods:................................................
48 Devices found containing: 48 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Root Bridge [PCIB] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.PBP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:07[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:07[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:07[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:07[D] -> 2-19 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (3-3 -> 0xc9 -> IRQ 27 Mode:1 Active:1)
00:02:08[A] -> 3-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (3-0 -> 0xd1 -> IRQ 24 Mode:1 Active:1)
00:02:08[B] -> 3-0 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xd9 -> IRQ 25 Mode:1 Active:1)
00:02:08[C] -> 3-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xe1 -> IRQ 26 Mode:1 Active:1)
00:02:08[D] -> 3-2 -> IRQ 26
IOAPIC[2]: Set PCI routing entry (4-0 -> 0xe9 -> IRQ 28 Mode:1 Active:1)
00:01:03[A] -> 4-0 -> IRQ 28
IOAPIC[2]: Set PCI routing entry (4-1 -> 0x32 -> IRQ 29 Mode:1 Active:1)
00:01:03[B] -> 4-1 -> IRQ 29
IOAPIC[2]: Set PCI routing entry (4-2 -> 0x3a -> IRQ 30 Mode:1 Active:1)
00:01:03[C] -> 4-2 -> IRQ 30
IOAPIC[2]: Set PCI routing entry (4-3 -> 0x42 -> IRQ 31 Mode:1 Active:1)
00:01:03[D] -> 4-3 -> IRQ 31
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 001 01  0    0    0   0   0    1    1    51
  06 001 01  0    0    0   0   0    1    1    59
  07 001 01  0    0    0   0   0    1    1    61
  08 001 01  0    0    0   0   0    1    1    69
  09 001 01  0    1    0   1   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 001 01  0    0    0   0   0    1    1    91
  0e 001 01  0    0    0   0   0    1    1    99
  0f 001 01  0    0    0   0   0    1    1    A1
  10 001 01  1    1    0   1   0    1    1    A9
  11 001 01  1    1    0   1   0    1    1    B1
  12 001 01  1    1    0   1   0    1    1    B9
  13 001 01  1    1    0   1   0    1    1    C1
  14 000 00  1    0    0   0   0    0    0    00
  15 000 00  1    0    0   0   0    0    0    00
  16 000 00  1    0    0   0   0    0    0    00
  17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 001 01  1    1    0   1   0    1    1    D1
  01 001 01  1    1    0   1   0    1    1    D9
  02 001 01  1    1    0   1   0    1    1    E1
  03 001 01  1    1    0   1   0    1    1    C9

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 001 01  1    1    0   1   0    1    1    E9
  01 001 01  1    1    0   1   0    1    1    32
  02 001 01  1    1    0   1   0    1    1    3A
  03 001 01  1    1    0   1   0    1    1    42
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 2:0
IRQ29 -> 2:1
IRQ30 -> 2:2
IRQ31 -> 2:3
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: Maximum main memory to use for agp memory: 5944M
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Total HugeTLB memory allocated, 0
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin 
is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k2
Copyright (c) 1999-2004 Intel Corporation.
tg3.c:v2.9 (March 8, 2004)
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] 
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:28:14:04
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-121 0102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(100)
  hda: hda1 hda2 hda3
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
Fusion MPT base driver 3.01.01
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.01
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Intel 810 + AC97 Audio, version 0.24, 13:37:53 Apr  5 2004
i810: AMD-8111 IOHub found at IO 0xac00 and 0xa800, MEM 0x0000 and 
0x0000, IRQ 17
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 48834
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Software Suspend has malfunctioning SMP support. Disabled :(
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 32768) 4194304
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
EXT3 FS on hda3, internal journal
Adding 32764556k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
eth0: no IPv6 routers present


