Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263087AbTC1Swy>; Fri, 28 Mar 2003 13:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbTC1Swy>; Fri, 28 Mar 2003 13:52:54 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:52608 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S263087AbTC1Sws>;
	Fri, 28 Mar 2003 13:52:48 -0500
Subject: [2.5.66] Enormous interrupt load with ACPI
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048878306.714.11.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Mar 2003 21:05:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

If I enable ACPI on my machine I seem to get more than 80 000 interrupts
per second on IRQ9, sucking up roughly 30% of CPU time. Boot log
appended.

	MikaL

Mar 28 01:15:41 devil kernel: Linux version 2.5.66 (root@devil) (gcc version 3.2.3 20030316 (Debian prerelease)) #7 SMP Fri Mar 28 01:12:23 EET 2003
Mar 28 01:15:41 devil kernel: Video mode to be used for restore is f00
Mar 28 01:15:41 devil kernel: BIOS-provided physical RAM map:
Mar 28 01:15:41 devil kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Mar 28 01:15:41 devil kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Mar 28 01:15:41 devil kernel: 383MB LOWMEM available.
Mar 28 01:15:41 devil kernel: found SMP MP-table at 000f5b30
Mar 28 01:15:41 devil kernel: hm, page 000f5000 reserved twice.
Mar 28 01:15:41 devil kernel: hm, page 000f6000 reserved twice.
Mar 28 01:15:41 devil kernel: hm, page 000f1000 reserved twice.
Mar 28 01:15:41 devil kernel: hm, page 000f2000 reserved twice.
Mar 28 01:15:41 devil kernel: On node 0 totalpages: 98288
Mar 28 01:15:41 devil kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar 28 01:15:41 devil kernel:   Normal zone: 94192 pages, LIFO batch:16
Mar 28 01:15:41 devil kernel:   HighMem zone: 0 pages, LIFO batch:1
Mar 28 01:15:41 devil kernel: ACPI: RSDP (v000 GBT                        ) @ 0x000f7140
Mar 28 01:15:41 devil kernel: ACPI: RSDT (v001 GBT    AWRDACPI 16944.11825) @ 0x17ff3000
Mar 28 01:15:41 devil kernel: ACPI: FADT (v001 GBT    AWRDACPI 16944.11825) @ 0x17ff3040
Mar 28 01:15:41 devil kernel: ACPI: MADT (v001 GBT             00000.00000) @ 0x17ff5740
Mar 28 01:15:41 devil kernel: ACPI: DSDT (v001 GBT    AWRDACPI 00000.04096) @ 0x00000000
Mar 28 01:15:41 devil kernel: ACPI: BIOS passes blacklist
Mar 28 01:15:41 devil kernel: ACPI: Local APIC address 0xfee00000
Mar 28 01:15:41 devil kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Mar 28 01:15:41 devil kernel: Processor #0 6:5 APIC version 16
Mar 28 01:15:41 devil kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Mar 28 01:15:41 devil kernel: Processor #1 6:5 APIC version 16
Mar 28 01:15:41 devil kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Mar 28 01:15:41 devil kernel: IOAPIC[0]: Assigned apic_id 2
Mar 28 01:15:41 devil kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
Mar 28 01:15:41 devil kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
Mar 28 01:15:41 devil kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Mar 28 01:15:41 devil kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Mar 28 01:15:42 devil kernel: Using ACPI (MADT) for SMP configuration information
Mar 28 01:15:42 devil kernel: Building zonelist for node : 0
Mar 28 01:15:42 devil kernel: Kernel command line: BOOT_IMAGE=New ro root=307 rootflags=data=writeback video=matrox:sgram,vesa:261,maxclk:210,fh:100000,fv:85,fastfont:65536 parport=auto ide0=autotune ide1=autotune hdb=scsi apm=power-off,smp-power-off,debug acpi=on devfs=nomount nmi_watchdog=1 nomce
Mar 28 01:15:42 devil kernel: ide_setup: ide0=autotune
Mar 28 01:15:42 devil kernel: ide_setup: ide1=autotune
Mar 28 01:15:42 devil kernel: ide_setup: hdb=scsi
Mar 28 01:15:42 devil kernel: Initializing CPU#0
Mar 28 01:15:42 devil kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Mar 28 01:15:42 devil kernel: Detected 398.870 MHz processor.
Mar 28 01:15:42 devil kernel: Console: colour VGA+ 80x25
Mar 28 01:15:42 devil kernel: Calibrating delay loop... 786.43 BogoMIPS
Mar 28 01:15:42 devil kernel: Memory: 384532k/393152k available (2711k kernel code, 7872k reserved, 610k data, 340k init, 0k highmem)
Mar 28 01:15:42 devil kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar 28 01:15:42 devil kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar 28 01:15:42 devil kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mar 28 01:15:42 devil kernel: -> /dev
Mar 28 01:15:42 devil kernel: -> /dev/console
Mar 28 01:15:42 devil kernel: -> /root
Mar 28 01:15:42 devil kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 28 01:15:42 devil kernel: CPU: L2 cache: 512K
Mar 28 01:15:42 devil kernel: CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
Mar 28 01:15:42 devil kernel: Enabling fast FPU save and restore... done.
Mar 28 01:15:42 devil kernel: Checking 'hlt' instruction... OK.
Mar 28 01:15:42 devil kernel: POSIX conformance testing by UNIFIX
Mar 28 01:15:42 devil kernel: CPU0: Intel Pentium II (Deschutes) stepping 00
Mar 28 01:15:42 devil kernel: per-CPU timeslice cutoff: 1464.09 usecs.
Mar 28 01:15:42 devil kernel: task migration cache decay timeout: 2 msecs.
Mar 28 01:15:42 devil kernel: enabled ExtINT on CPU#0
Mar 28 01:15:42 devil kernel: ESR value before enabling vector: 00000000
Mar 28 01:15:42 devil kernel: ESR value after enabling vector: 00000000
Mar 28 01:15:42 devil kernel: Booting processor 1/1 eip 2000
Mar 28 01:15:42 devil kernel: Initializing CPU#1
Mar 28 01:15:42 devil kernel: masked ExtINT on CPU#1
Mar 28 01:15:42 devil kernel: ESR value before enabling vector: 00000000
Mar 28 01:15:42 devil kernel: ESR value after enabling vector: 00000000
Mar 28 01:15:42 devil kernel: Calibrating delay loop... 794.62 BogoMIPS
Mar 28 01:15:42 devil kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 28 01:15:42 devil kernel: CPU: L2 cache: 512K
Mar 28 01:15:42 devil kernel: CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
Mar 28 01:15:42 devil kernel: CPU1: Intel Pentium II (Deschutes) stepping 00
Mar 28 01:15:42 devil kernel: Total of 2 processors activated (1581.05 BogoMIPS).
Mar 28 01:15:42 devil kernel: ENABLING IO-APIC IRQs
Mar 28 01:15:42 devil kernel: init IO_APIC IRQs
Mar 28 01:15:42 devil kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Mar 28 01:15:42 devil kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Mar 28 01:15:42 devil kernel: activating NMI Watchdog ... done.
Mar 28 01:15:42 devil kernel: testing NMI watchdog ... OK.
Mar 28 01:15:42 devil kernel: number of MP IRQ sources: 16.
Mar 28 01:15:42 devil kernel: number of IO-APIC #2 registers: 24.
Mar 28 01:15:42 devil kernel: testing the IO APIC.......................
Mar 28 01:15:42 devil kernel: 
Mar 28 01:15:42 devil kernel: IO APIC #2......
Mar 28 01:15:42 devil kernel: .... register #00: 02000000
Mar 28 01:15:42 devil kernel: .......    : physical APIC id: 02
Mar 28 01:15:42 devil kernel: .......    : Delivery Type: 0
Mar 28 01:15:42 devil kernel: .......    : LTS          : 0
Mar 28 01:15:42 devil kernel: .... register #01: 00170011
Mar 28 01:15:42 devil kernel: .......     : max redirection entries: 0017
Mar 28 01:15:42 devil kernel: .......     : PRQ implemented: 0
Mar 28 01:15:42 devil kernel: .......     : IO APIC version: 0011
Mar 28 01:15:42 devil kernel: .... register #02: 00000000
Mar 28 01:15:42 devil kernel: .......     : arbitration: 00
Mar 28 01:15:42 devil kernel: .... IRQ redirection table:
Mar 28 01:15:42 devil kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Mar 28 01:15:42 devil kernel:  00 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  01 001 01  0    0    0   0   0    1    1    39
Mar 28 01:15:42 devil kernel:  02 001 01  0    0    0   0   0    1    1    31
Mar 28 01:15:42 devil kernel:  03 001 01  0    0    0   0   0    1    1    41
Mar 28 01:15:42 devil kernel:  04 001 01  0    0    0   0   0    1    1    49
Mar 28 01:15:42 devil kernel:  05 001 01  0    0    0   0   0    1    1    51
Mar 28 01:15:42 devil kernel:  06 001 01  0    0    0   0   0    1    1    59
Mar 28 01:15:42 devil kernel:  07 001 01  0    0    0   0   0    1    1    61
Mar 28 01:15:42 devil kernel:  08 001 01  0    0    0   0   0    1    1    69
Mar 28 01:15:42 devil kernel:  09 001 01  1    1    0   0   0    1    1    71
Mar 28 01:15:42 devil kernel:  0a 001 01  0    0    0   0   0    1    1    79
Mar 28 01:15:42 devil kernel:  0b 001 01  0    0    0   0   0    1    1    81
Mar 28 01:15:42 devil kernel:  0c 001 01  0    0    0   0   0    1    1    89
Mar 28 01:15:42 devil kernel:  0d 001 01  0    0    0   0   0    1    1    91
Mar 28 01:15:42 devil kernel:  0e 001 01  0    0    0   0   0    1    1    99
Mar 28 01:15:42 devil kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Mar 28 01:15:42 devil kernel:  10 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  11 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  12 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  13 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  14 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  15 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  16 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel:  17 000 00  1    0    0   0   0    0    0    00
Mar 28 01:15:42 devil kernel: IRQ to pin mappings:
Mar 28 01:15:42 devil kernel: IRQ0 -> 0:2
Mar 28 01:15:42 devil kernel: IRQ1 -> 0:1
Mar 28 01:15:42 devil kernel: IRQ3 -> 0:3
Mar 28 01:15:42 devil kernel: IRQ4 -> 0:4
Mar 28 01:15:42 devil kernel: IRQ5 -> 0:5
Mar 28 01:15:42 devil kernel: IRQ6 -> 0:6
Mar 28 01:15:42 devil kernel: IRQ7 -> 0:7
Mar 28 01:15:42 devil kernel: IRQ8 -> 0:8
Mar 28 01:15:42 devil kernel: IRQ9 -> 0:9
Mar 28 01:15:42 devil kernel: IRQ10 -> 0:10
Mar 28 01:15:42 devil kernel: IRQ11 -> 0:11
Mar 28 01:15:42 devil kernel: IRQ12 -> 0:12
Mar 28 01:15:42 devil kernel: IRQ13 -> 0:13
Mar 28 01:15:42 devil kernel: IRQ14 -> 0:14
Mar 28 01:15:42 devil kernel: IRQ15 -> 0:15
Mar 28 01:15:42 devil kernel: .................................... done.
Mar 28 01:15:42 devil kernel: Using local APIC timer interrupts.
Mar 28 01:15:42 devil kernel: calibrating APIC timer ...
Mar 28 01:15:42 devil kernel: ..... CPU clock speed is 398.0851 MHz.
Mar 28 01:15:42 devil kernel: ..... host bus clock speed is 99.0712 MHz.
Mar 28 01:15:42 devil kernel: checking TSC synchronization across 2 CPUs: passed.
Mar 28 01:15:42 devil kernel: Starting migration thread for cpu 0
Mar 28 01:15:42 devil kernel: Bringing up 1
Mar 28 01:15:42 devil kernel: CPU 1 IS NOW UP!
Mar 28 01:15:42 devil kernel: Starting migration thread for cpu 1
Mar 28 01:15:42 devil kernel: CPUS done 2
Mar 28 01:15:42 devil kernel: Linux NET4.0 for Linux 2.4
Mar 28 01:15:42 devil kernel: Based upon Swansea University Computer Society NET3.039
Mar 28 01:15:42 devil kernel: Initializing RT netlink socket
Mar 28 01:15:42 devil kernel: mtrr: v2.0 (20020519)
Mar 28 01:15:42 devil kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Mar 28 01:15:42 devil kernel: mtrr: probably your BIOS does not setup all CPUs.
Mar 28 01:15:42 devil kernel: mtrr: corrected configuration.
Mar 28 01:15:42 devil kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=1
Mar 28 01:15:42 devil kernel: PCI: Using configuration type 1
Mar 28 01:15:42 devil kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Mar 28 01:15:42 devil kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Mar 28 01:15:42 devil kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Mar 28 01:15:42 devil kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Mar 28 01:15:42 devil kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Mar 28 01:15:42 devil kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Mar 28 01:15:42 devil kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Mar 28 01:15:42 devil kernel: ACPI: Subsystem revision 20030228
Mar 28 01:15:42 devil kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Mar 28 01:15:42 devil kernel: Parsing all Control Methods:..............................................................................
Mar 28 01:15:42 devil kernel: Table [DSDT] - 340 Objects with 26 Devices 78 Methods 23 Regions
Mar 28 01:15:42 devil kernel: ACPI Namespace successfully loaded at root c04b203c
Mar 28 01:15:42 devil kernel: evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
Mar 28 01:15:42 devil kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000400C
Mar 28 01:15:42 devil kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Mar 28 01:15:42 devil kernel: Executing all Device _STA and_INI methods:..........................
Mar 28 01:15:42 devil kernel: 26 Devices found containing: 26 _STA, 0 _INI methods
Mar 28 01:15:42 devil kernel: Completing Region/Field/Buffer/Package initialization:......................................................................
Mar 28 01:15:42 devil kernel: Initialized 19/23 Regions 24/24 Fields 20/20 Buffers 7/7 Packages (340 nodes)
Mar 28 01:15:42 devil kernel: ACPI: Interpreter enabled
Mar 28 01:15:42 devil kernel: ACPI: Using IOAPIC for interrupt routing
Mar 28 01:15:42 devil kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Mar 28 01:15:42 devil kernel: PCI: Probing PCI hardware (bus 00)
Mar 28 01:15:42 devil kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar 28 01:15:42 devil kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Mar 28 01:15:42 devil kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
Mar 28 01:15:42 devil kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
Mar 28 01:15:42 devil kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Mar 28 01:15:42 devil kernel: Linux Plug and Play Support v0.95 (c) Adam Belay
Mar 28 01:15:42 devil kernel: pnp: the driver 'system' has been registered
Mar 28 01:15:42 devil kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe10
Mar 28 01:15:42 devil kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe38, dseg 0xf0000
Mar 28 01:15:42 devil kernel: pnp: match found with the PnP device '00:07' and the driver 'system'
Mar 28 01:15:42 devil kernel: pnp: match found with the PnP device '00:08' and the driver 'system'
Mar 28 01:15:42 devil kernel: pnp: match found with the PnP device '00:0b' and the driver 'system'
Mar 28 01:15:42 devil kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Mar 28 01:15:42 devil kernel: block request queues:
Mar 28 01:15:42 devil kernel:  128 requests per read queue
Mar 28 01:15:42 devil kernel:  128 requests per write queue
Mar 28 01:15:42 devil kernel:  8 requests per batch
Mar 28 01:15:42 devil kernel:  enter congestion at 15
Mar 28 01:15:42 devil kernel:  exit congestion at 17
Mar 28 01:15:42 devil kernel: SCSI subsystem initialized
Mar 28 01:15:42 devil kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Mar 28 01:15:42 devil kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
Mar 28 01:15:42 devil kernel: 00:00:08[A] -> 2-16 -> IRQ 16
Mar 28 01:15:42 devil kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
Mar 28 01:15:42 devil kernel: 00:00:08[B] -> 2-17 -> IRQ 17
Mar 28 01:15:42 devil kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
Mar 28 01:15:42 devil kernel: 00:00:08[C] -> 2-18 -> IRQ 18
Mar 28 01:15:42 devil kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
Mar 28 01:15:42 devil kernel: 00:00:08[D] -> 2-19 -> IRQ 19
Mar 28 01:15:42 devil kernel: Pin 2-17 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-18 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-19 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-16 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-18 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-19 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-16 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-17 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-19 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-16 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-17 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-18 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-16 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-17 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-18 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-19 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-16 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-17 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-18 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-19 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-16 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-17 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-18 already programmed
Mar 28 01:15:42 devil kernel: Pin 2-19 already programmed
Mar 28 01:15:42 devil kernel: PCI: Using ACPI for IRQ routing
Mar 28 01:15:42 devil kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Mar 28 01:15:42 devil kernel: IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Mar 28 01:15:42 devil kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Mar 28 01:15:42 devil kernel: apm: entry f000:8430 cseg16 f000 dseg fdf8 cseg len 0, dseg len 0 cseg16 len 0
Mar 28 01:15:42 devil kernel: apm: overridden by ACPI.
Mar 28 01:15:42 devil kernel: Starting balanced_irq
Mar 28 01:15:42 devil kernel: Enabling SEP on CPU 1
Mar 28 01:15:42 devil kernel: Enabling SEP on CPU 0
Mar 28 01:15:42 devil kernel: Journalled Block Device driver loaded
Mar 28 01:15:42 devil kernel: udf: registering filesystem
Mar 28 01:15:42 devil kernel: Initializing Cryptographic API
Mar 28 01:15:42 devil kernel: Limiting direct PCI/PCI transfers.
Mar 28 01:15:42 devil kernel: ACPI: Power Button (FF) [PWRF]
Mar 28 01:15:42 devil kernel: ACPI: Processor [CPU] (supports C1)
Mar 28 01:15:42 devil kernel: ACPI: Processor [CPU1] (supports C1)
Mar 28 01:15:42 devil kernel: acpi_thermal-0395 [-384] acpi_thermal_get_trip_: Invalid active threshold [0]
Mar 28 01:15:42 devil kernel: ACPI: Thermal Zone [THRM] (39 C)
Mar 28 01:15:42 devil kernel: isapnp: Scanning for PnP cards...
Mar 28 01:15:42 devil kernel: pnp: Calling quirk for 01:01.00
Mar 28 01:15:42 devil kernel: pnp: SB audio device quirk - increasing port range
Mar 28 01:15:42 devil kernel: pnp: Calling quirk for 01:01.02
Mar 28 01:15:42 devil kernel: pnp: AWE32 quirk - adding two ports
Mar 28 01:15:42 devil kernel: isapnp: Card 'Creative SB AWE64 PnP'
Mar 28 01:15:42 devil kernel: isapnp: 1 Plug & Play card detected total
Mar 28 01:15:42 devil kernel: pty: 256 Unix98 ptys configured
Mar 28 01:15:42 devil kernel: Real Time Clock Driver v1.11
Mar 28 01:15:42 devil kernel: Non-volatile memory driver v1.2
Mar 28 01:15:42 devil kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar 28 01:15:42 devil kernel: agpgart: Detected Intel 440BX chipset
Mar 28 01:15:42 devil kernel: agpgart: Maximum main memory to use for agp memory: 321M
Mar 28 01:15:42 devil kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Mar 28 01:15:42 devil kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Mar 28 01:15:42 devil kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Mar 28 01:15:42 devil kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 28 01:15:42 devil kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 28 01:15:42 devil kernel: pnp: the driver 'serial' has been registered
Mar 28 01:15:42 devil kernel: pnp: match found with the PnP device '00:0c' and the driver 'serial'
Mar 28 01:15:42 devil kernel: pnp: match found with the PnP device '00:0f' and the driver 'serial'
Mar 28 01:15:42 devil kernel: Floppy drive(s): fd0 is 1.44M
Mar 28 01:15:42 devil kernel: FDC 0 is a post-1991 82077
Mar 28 01:15:42 devil kernel: loop: loaded (max 8 devices)
Mar 28 01:15:42 devil kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
Mar 28 01:15:42 devil kernel:   http://www.scyld.com/network/ne2k-pci.html
Mar 28 01:15:42 devil kernel: eth0: RealTek RTL-8029 found at 0xe400, IRQ 18, 00:20:18:54:A2:4E.
Mar 28 01:15:42 devil kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar 28 01:15:42 devil kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar 28 01:15:42 devil kernel: PIIX4: IDE controller at PCI slot 00:07.1
Mar 28 01:15:42 devil kernel: PIIX4: chipset revision 1
Mar 28 01:15:42 devil kernel: PIIX4: not 100%% native mode: will probe irqs later
Mar 28 01:15:42 devil kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Mar 28 01:15:42 devil kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Mar 28 01:15:42 devil kernel: hda: ST38641A, ATA DISK drive
Mar 28 01:15:42 devil kernel: hdb: Hewlett-Packard CD-Writer Plus 8100, ATAPI CD/DVD-ROM drive
Mar 28 01:15:42 devil kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 28 01:15:42 devil kernel: hdc: IBM-DJNA-352030, ATA DISK drive
Mar 28 01:15:42 devil kernel: hdd: ASUS DVD-ROM E616, ATAPI CD/DVD-ROM drive
Mar 28 01:15:42 devil kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 28 01:15:42 devil kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Mar 28 01:15:42 devil kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
Mar 28 01:15:42 devil kernel: hda: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=16676/16/63, UDMA(33)
Mar 28 01:15:42 devil kernel:  hda: hda1 hda3 < hda5 hda6 hda7 hda8 > hda4
Mar 28 01:15:42 devil kernel: hdc: host protected area => 1
Mar 28 01:15:42 devil kernel: hdc: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63, UDMA(33)
Mar 28 01:15:42 devil kernel:  hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 >
Mar 28 01:15:42 devil kernel: ide-cd: passing drive hdb to ide-scsi emulation.
Mar 28 01:15:42 devil kernel: end_request: I/O error, dev hdd, sector 0
Mar 28 01:15:42 devil kernel: hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Mar 28 01:15:42 devil kernel: Uniform CD-ROM driver Revision: 3.12
Mar 28 01:15:42 devil kernel: end_request: I/O error, dev hdd, sector 0
Mar 28 01:15:42 devil kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Mar 28 01:15:42 devil kernel:   Vendor: HP        Model: CD-Writer+ 8100   Rev: 1.0n
Mar 28 01:15:42 devil kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Mar 28 01:15:42 devil kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Mar 28 01:15:42 devil kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Mar 28 01:15:42 devil kernel: mice: PS/2 mouse device common for all mice
Mar 28 01:15:42 devil kernel: input: PC Speaker
Mar 28 01:15:42 devil kernel: input: PS/2 Logitech Mouse on isa0060/serio1
Mar 28 01:15:42 devil kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 28 01:15:42 devil kernel: input: AT Set 2 keyboard on isa0060/serio0
Mar 28 01:15:42 devil kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 28 01:15:42 devil kernel: i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
Mar 28 01:15:42 devil kernel: i2c-proc.o version 2.7.0 (20021208)
Mar 28 01:15:42 devil kernel: i2c-piix4 version 2.7.0 (20021208)
Mar 28 01:15:42 devil kernel: piix4 smbus 00:07.3: Found Intel Corp. 82371AB/EB/MB PIIX4  device
Mar 28 01:15:42 devil kernel: i2c-dev.o: Registered 'SMBus PIIX4 adapter at 5000' as minor 0
Mar 28 01:15:42 devil kernel: sb: Init: Starting Probe...
Mar 28 01:15:42 devil kernel: pnp: the driver 'OSS SndBlstr' has been registered
Mar 28 01:15:42 devil kernel: pnp: match found with the PnP device '01:01.00' and the driver 'OSS SndBlstr'
Mar 28 01:15:42 devil kernel: pnp: res: the device '01:01.00' has been activated.
Mar 28 01:15:42 devil kernel: sb: PnP: Found Card Named = "Audio", Card PnP id = CTL00C5, Device PnP id = CTL0045
Mar 28 01:15:42 devil kernel: sb: PnP:      Detected at: io=0x220, irq=5, dma=1, dma16=5
Mar 28 01:15:42 devil kernel: sb: Turning on MPU
Mar 28 01:15:42 devil kernel: sb: Init: Done
Mar 28 01:15:42 devil kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar 28 01:15:42 devil kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Mar 28 01:15:42 devil kernel: TCP: Hash tables configured (established 32768 bind 32768)
Mar 28 01:15:42 devil kernel: IPv4 over IPv4 tunneling driver
Mar 28 01:15:42 devil kernel: GRE over IPv4 tunneling driver
Mar 28 01:15:42 devil kernel: ip_conntrack version 2.1 (3071 buckets, 24568 max) - 304 bytes per conntrack
Mar 28 01:15:42 devil kernel: ip_tables: (C) 2000-2002 Netfilter core team
Mar 28 01:15:42 devil kernel: arp_tables: (C) 2002 David S. Miller
Mar 28 01:15:42 devil kernel: Initializing IPsec netlink socket
Mar 28 01:15:42 devil kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Mar 28 01:15:42 devil kernel: IPv6 v0.8 for NET4.0
Mar 28 01:15:42 devil kernel: IPv6 over IPv4 tunneling driver
Mar 28 01:15:42 devil kernel: ip6_tables: (C) 2000-2002 Netfilter core team
Mar 28 01:15:42 devil kernel: registering ipv6 mark target
Mar 28 01:15:42 devil kernel: kjournald starting.  Commit interval 5 seconds
Mar 28 01:15:42 devil kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar 28 01:15:42 devil kernel: VFS: Mounted root (ext3 filesystem) readonly.
Mar 28 01:15:42 devil kernel: Freeing unused kernel memory: 340k freed


