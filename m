Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264759AbUEKOgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbUEKOgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUEKOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:36:13 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:4817 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S264759AbUEKOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:35:14 -0400
Date: Tue, 11 May 2004 10:35:14 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: linux-kernel@vger.kernel.org
Subject: Long boot delay with 2.6 on Tyan S2464 Dual Athlon
Message-ID: <20040511143514.GB27033@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting 2.6 on a Tyan S2464 dual Athlon, the kernel pauses
for about two minutes before the first boot message appears.
This does not occur with 2.4 kernels.

The machine has a Matrox G450 AGP (which overrides the onboard ATI),
a 3ware 7500 RAID controller, IDE on the motherboard, and 1GB of RAM.

I've tried numerous option combinations in both the BIOS and the
kernel: MPS 1.1/1.4, (no-)SMP, acpi=off, pci=noacpi, noapic, nolapic,
nousb, etc.

This happens with all of the following:
	
	Fedora Core Test 3 boot kernel
	Arjan's latest kernel RPMS (2.6.5-1.356)
	2.6.6
	2.6.6-mm1

Boot log for 2.6.6-mm1 follows.

Regards,

	Bill Rugolsky

Linux version 2.6.6-mm1 (rugolsky@thor) (gcc version 3.3.2 20031107 (Red Hat Linux 3.3.2-2)) #1 SMP Tue May 11 08:57:29 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff6c00 (ACPI data)
 BIOS-e820: 000000003fff6c00 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f74c0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
early console enabled
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7460
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x3fff451b
ACPI: FADT (v001 TYAN   GUINNESS 0x06040000 PTEC 0x000f4240) @ 0x3fff6b2e
ACPI: MADT (v001 PTLTD    APIC   0x06040000  LTP 0x00000000) @ 0x3fff6ba2
ACPI: DSDT (v001    AMD  AMDACPI 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:6 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=LABEL=/ earlyprintk=vga
CPU 0 irqstacks, hard=c03a1000 soft=c0399000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1194.770 MHz processor.
Using tsc for high-res timesource
disabling early console
Console: colour VGA+ 80x25
Memory: 1035660k/1048512k available (1593k kernel code, 11944k reserved, 771k data, 268k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2359.29 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(tm) MP stepping 01
per-CPU timeslice cutoff: 731.41 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
CPU 1 irqstacks, hard=c03a2000 soft=c039a000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2383.87 BogoMIPS
CPU:     After generic identify, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 01
Total of 2 processors activated (4743.16 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1194.0488 MHz.
..... host bus clock speed is 265.0441 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 03
  groups: 01 02
CPU1:  online
 domain 0: span 03
  groups: 02 01
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 376k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040326
    ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
search_node f7ec7abc start_node f7ec7abc return_node 00000000
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.COM1._STA] (Node f7ec7abc), AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
search_node f7ec593c start_node f7ec593c return_node 00000000
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.COM2._STA] (Node f7ec593c), AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
search_node f7ec573c start_node f7ec573c return_node 00000000
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.LPT_._STA] (Node f7ec573c), AE_NOT_FOUND
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 11) *9
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
    ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
search_node f7ec7abc start_node f7ec7abc return_node 00000000
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.COM1._STA] (Node f7ec7abc), AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
search_node f7ec593c start_node f7ec593c return_node 00000000
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.COM2._STA] (Node f7ec593c), AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
search_node f7ec573c start_node f7ec573c return_node 00000000
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.ISA_.SIO_.LPT_._STA] (Node f7ec573c), AE_NOT_FOUND
Linux Plug and Play Support v0.97 (c) Adam Belay
00:00:0d[A] -> 2-16 -> IRQ 16 level low
00:00:0d[B] -> 2-17 -> IRQ 17 level low
00:00:0f[A] -> 2-18 -> IRQ 18 level low
00:00:10[A] -> 2-19 -> IRQ 19 level low
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 0FF 0F  0    0    0   0   0    1    1    39
 02 0FF 0F  0    0    0   0   0    1    1    31
 03 0FF 0F  0    0    0   0   0    1    1    41
 04 0FF 0F  0    0    0   0   0    1    1    49
 05 0FF 0F  0    0    0   0   0    1    1    51
 06 0FF 0F  0    0    0   0   0    1    1    59
 07 0FF 0F  0    0    0   0   0    1    1    61
 08 0FF 0F  0    0    0   0   0    1    1    69
 09 0FF 0F  0    1    0   1   0    1    1    71
 0a 0FF 0F  0    0    0   0   0    1    1    79
 0b 0FF 0F  0    0    0   0   0    1    1    81
 0c 0FF 0F  0    0    0   0   0    1    1    89
 0d 0FF 0F  0    0    0   0   0    1    1    91
 0e 0FF 0F  0    0    0   0   0    1    1    99
 0f 0FF 0F  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
PCI: Using ACPI for IRQ routing
vesafb: probe of vesafb0 failed with error -6
Starting balanced_irq
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
BIOS failed to enable PCI standards compliance, fixing this error.
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller at PCI slot 0000:00:07.1
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD7411: 0000:00:07.1 (rev 01) UDMA100 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 5T030H3, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD_RW ND-1300A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60030432 sectors (30735 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(100)
 hda: hda1 hda4 < hda5 hda6 hda7 hda8 hda9 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

3ware Storage Controller device driver for Linux v1.26.00.039.
scsi2 : Found a 3ware Storage Controller at 0x1c50, IRQ: 17, P-chip: 1.3
scsi2 : 3ware Storage Controller
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
 sda:
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
  Vendor: 3ware     Model: Logical Disk 1    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write through
 sdb:
Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
  Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdc: drive cache: write through
 sdc:
Attached scsi disk sdc at scsi2, channel 0, id 2, lun 0
  Vendor: 3ware     Model: Logical Disk 3    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdd: drive cache: write through
 sdd:
Attached scsi disk sdd at scsi2, channel 0, id 3, lun 0
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 268k freed
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
EXT3 FS on hda6, internal journal
Adding 2097608k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
