Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVGAWIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVGAWIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVGAWIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:08:52 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:56259 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262776AbVGAWFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:05:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc1-mm1
Date: Sat, 2 Jul 2005 00:05:04 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050701044018.281b1ebd.akpm@osdl.org>
In-Reply-To: <20050701044018.281b1ebd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q4bxCa+Ayx9UxgC"
Message-Id: <200507020005.04947.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Q4bxCa+Ayx9UxgC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday, 1 of July 2005 13:40, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/
> 

I get this errors on a dual-Opteron box (64-bit):

3ware Storage Controller device driver for Linux v1.26.02.001.
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 27 (level, low) -> IRQ 18
scsi1 : 3ware Storage Controller
3w-xxxx: scsi1: Found a 3ware Storage Controller at 0x8c00, IRQ: 18.
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
]--snip--[
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
]--snip--[
ReiserFS: sdb3: warning: sh-2006: read_super_block: bread failed (dev sdb3, block 16, size 512)
ReiserFS: sdb3: warning: sh-2006: read_super_block: bread failed (dev sdb3, block 128, size 512)
EXT3-fs: unable to read superblock
EXT2-fs: unable to read superblock
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,19)

sdb is a 3ware 8006-2LP SATA RAID.

The problem is present in 2.6.12-mm2 and of course it is 100% reproducible.  The full dmesg
output is attached.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_Q4bxCa+Ayx9UxgC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="panic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="panic.txt"

Bootdata ok (command line is root=/dev/sdb3 vga=792 console=ttyS0,57600 console=tty0 debug)
Linux version 2.6.13-rc1-mm1 (rafael@chimera) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #1 SMP Fri Jul 1 23:47:55 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x5008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bf7c0000)
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sdb3 vga=792 console=ttyS0,57600 console=tty0 debug
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1388.419 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1025700k/1048512k available (2766k kernel code, 0k reserved, 1336k data, 228k init)
Calibrating delay using timer specific routine.. 2782.49 BogoMIPS (lpj=5564983)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
mtrr: v2.0 (20020519)
 tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
 dswload-0498: *** Warning: Encountered executable code at module level, [If]
 dswload-0498: *** Warning: Encountered executable code at module level, [If]
Parsing all Control Methods:..................................................................................................................
Table [DSDT](id F004) - 519 Objects with 45 Devices 144 Methods 13 Regions
ACPI Namespace successfully loaded at root ffffffff8052f940
evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
Using local APIC timer interrupts.
Detected 12.396 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/1 rip 6000 rsp ffff810001763f58
Initializing CPU#1
Calibrating delay using timer specific routine.. 2777.00 BogoMIPS (lpj=5554000)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 01
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
softlockup thread 1 started up.
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
CPU 1: synchronized TSC with CPU 0 (last diff -3 cycles, maxerr 930 cycles)
-> [0][1][  65536]   0.0 [  0.0] (0): (   82827    41413)
-> [0][1][  68985]   0.0 [  0.0] (0): (   27161    48539)
-> [0][1][  72615]   0.0 [  0.0] (0): (   28702    25040)
-> [0][1][  76436]   0.0 [  0.0] (0): (   29921    13129)
-> [0][1][  80458]   0.0 [  0.0] (0): (   31519     7363)
-> [0][1][  84692]   0.0 [  0.0] (0): (   32581     4212)
-> [0][1][  89149]   0.0 [  0.0] (0): (   32836     2233)
-> found max.
[0][1] working set size found: 65536, cost: 82827
---------------------
| migration cost matrix (max_cache_size: 0, cpu: 1388 MHz):
---------------------
          [00]    [01]
[00]:     -     0.1(0)
[01]:   0.1(0)    -
--------------------------------
| cacheflush times [1]: 0.1 (165654)
| calibration delay: 0 seconds
--------------------------------
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 5 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-1016 [06] ev_create_gpe_block   : GPE 10 to 2F [_GPE] 4 regs on int 0x9
evgpeblk-1024 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:........................................................................................
Initialized 12/13 Regions 68/68 Fields 39/39 Buffers 18/18 Packages (528 nodes)
Executing all Device _STA and_INI methods:.................................................
49 Devices found containing: 49 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCIB] segment is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Root Bridge [PCIB] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCIB] segment is 0
Boot video device is 0000:05:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.PBP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1120255509.632:1): initialized
Total HugeTLB memory allocated, 0
inotify device minor=63
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
vesafb: framebuffer at 0xe0000000, mapped to 0xffffc20000100000, using 6144k, total 131072k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
cn_fork is registered
cn_exit is registered
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
tg3.c:v3.32 (June 24, 2005)
acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:a0:bf
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[763f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HDS722580VLAT20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON DVDRW LDW-851S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 160836480 sectors (82348 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 26 (level, low) -> IRQ 17
sym0: <1010-66> rev 0x1 at pci 0000:02:07.0 irq 17
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Losing some ticks... checking if CPU frequency changed.
 target0:0:0: tagged command queuing enabled, command queue depth 16.
 target0:0:0: Beginning Domain Validation
 target0:0:0: asynchronous.
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
 target0:0:0: Ending Domain Validation
3ware Storage Controller device driver for Linux v1.26.02.001.
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 27 (level, low) -> IRQ 18
scsi1 : 3ware Storage Controller
3w-xxxx: scsi1: Found a 3ware Storage Controller at 0x8c00, IRQ: 18.
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 19
ata1: SATA max UDMA/100 cmd 0xFFFFC20000006C80 ctl 0xFFFFC20000006C8A bmdma 0xFFFFC20000006C00 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFC20000006CC0 ctl 0xFFFFC20000006CCA bmdma 0xFFFFC20000006C08 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFC20000006E80 ctl 0xFFFFC20000006E8A bmdma 0xFFFFC20000006E00 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFC20000006EC0 ctl 0xFFFFC20000006ECA bmdma 0xFFFFC20000006E08 irq 19
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata1: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata2: no device found (phy stat 00000000)
scsi3 : sata_sil
ata3: no device found (phy stat 00000000)
scsi4 : sata_sil
ata4: no device found (phy stat 00000000)
scsi5 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  4094.000 MB/sec
raid5: using function: generic_sse (4094.000 MB/sec)
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 336 bytes per conntrack
logips2pp: Detected unknown logitech mouse model 57
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
TCP bic registered
TCP westwood registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 15
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: sdb3: warning: sh-2006: read_super_block: bread failed (dev sdb3, block 16, size 512)
ReiserFS: sdb3: warning: sh-2006: read_super_block: bread failed (dev sdb3, block 128, size 512)
EXT3-fs: unable to read superblock
EXT2-fs: unable to read superblock
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,19)

--Boundary-00=_Q4bxCa+Ayx9UxgC--
