Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274980AbTHPX63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274983AbTHPX63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:58:29 -0400
Received: from GEWI.kfunigraz.ac.at ([143.50.30.10]:61705 "EHLO
	gewi.kfunigraz.ac.at") by vger.kernel.org with ESMTP
	id S274980AbTHPX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:58:15 -0400
Date: Sun, 17 Aug 2003 01:57:28 +0200 (CEST)
From: Erich Stamberger <eberger@gewi.kfunigraz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: ASUS PR-DLSW: ACPI Bugs
Message-ID: <Pine.LNX.4.53.0308170151230.5593@gewi.kfunigraz.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.6.0-test3 with ACPI enabled fails to boot on ASUS PR-DLSW: Cannot
open root device .. Obviously the SCSI controllers (LSI 1010-66)
are not detected (complete dmesg from serial console below).

When setting pci=noacpi the machine hangs in an endless loop
trying to initialise the SCSI bus.

With acpi=off or CONFIG_ACPI_HT_ONLY the machine
boots (lspci -vvx below).

Any information / pointers will be appreciated.

Best regards
Erich


=====================================================
Boot messages taken from serial console, ACPI enabled
=====================================================

 Linux version 2.6.0-test3 (root@xmlns) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 SMP Sat Aug 16 23:44:24 CEST 2003
 Video mode to be used for restore is ffff
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fffb000 (usable)
  BIOS-e820: 000000003fffb000 - 000000003ffff000 (ACPI data)
  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 127MB HIGHMEM available.
 896MB LOWMEM available.
 found SMP MP-table at 000f0490
 hm, page 000f0000 reserved twice.
 hm, page 000f1000 reserved twice.
 hm, page 000f0000 reserved twice.
 hm, page 000f1000 reserved twice.
 On node 0 totalpages: 262139
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32763 pages, LIFO batch:7
 ACPI: RSDP (v000 ASUS                       ) @ 0x000f5040
 ACPI: RSDT (v001 ASUS   PR-DLSW  16944.11825) @ 0x3fffb000
 ACPI: FADT (v001 ASUS   PR-DLSW  16944.11825) @ 0x3fffb145
 ACPI: BOOT (v001 ASUS   PR-DLSW  16944.11825) @ 0x3fffb034
 ACPI: SPCR (v001 ASUS   PR-DLSW  16944.11825) @ 0x3fffb05c
 ACPI: MADT (v001 ASUS   PR-DLSW  16944.11825) @ 0x3fffb0a9
 ACPI: DSDT (v001   ASUS PR-DLSW  00000.04096) @ 0x00000000
 ACPI: BIOS passes blacklist
 ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
 Processor #0 15:2 APIC version 20
 ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
 Processor #1 15:2 APIC version 20
 ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
 Processor #6 15:2 APIC version 20
 ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
 Processor #7 15:2 APIC version 20
 ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
 ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
 ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
 ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x1] trigger[0x1] lint[0x1])
 ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
 IOAPIC[0]: Assigned apic_id 2
 IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-15
 ACPI: IOAPIC (id[0x03] address[0xfec01000] global_irq_base[0x10])
 IOAPIC[1]: Assigned apic_id 3
 IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, IRQ 16-31
 ACPI: IOAPIC (id[0x04] address[0xfec02000] global_irq_base[0x20])
 IOAPIC[2]: Assigned apic_id 4
 IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, IRQ 32-47
 ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
 ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
 Enabling APIC mode:  Flat.  Using 3 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Building zonelist for node : 0
 Kernel command line: BOOT_IMAGE=PRODUCTION-TEST ro root=801 console=ttyS0 console=tty0
 Initializing CPU#0
 PID hash table entries: 4096 (order 12: 32768 bytes)
 Detected 2393.442 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 4718.59 BogoMIPS
 Memory: 1034196k/1048556k available (1580k kernel code, 13440k reserved, 904k data, 144k init, 131052k highmem)
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 -> /dev
 -> /dev/console
 -> /root
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
 CPU#0: Thermal monitoring enabled
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 per-CPU timeslice cutoff: 1462.91 usecs.
 task migration cache decay timeout: 2 msecs.
 enabled ExtINT on CPU#0
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Booting processor 1/1 eip 2000
 Initializing CPU#1
 masked ExtINT on CPU#1
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 4767.74 BogoMIPS
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#1.
 CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
 CPU#1: Thermal monitoring enabled
 CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 Booting processor 2/6 eip 2000
 Initializing CPU#2
 masked ExtINT on CPU#2
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 4767.74 BogoMIPS
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 3
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#2.
 CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
 CPU#2: Thermal monitoring enabled
 CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 Booting processor 3/7 eip 2000
 Initializing CPU#3
 masked ExtINT on CPU#3
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 Calibrating delay loop... 4767.74 BogoMIPS
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 3
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#3.
 CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
 CPU#3: Thermal monitoring enabled
 CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
 Total of 4 processors activated (19021.82 BogoMIPS).
 cpu_sibling_map[0] = 1
 cpu_sibling_map[1] = 0
 cpu_sibling_map[2] = 3
 cpu_sibling_map[3] = 2
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 pin1=2 pin2=-1
 ..MP-BIOS bug: 8254 timer not connected to IO-APIC
 ...trying to set up timer (IRQ0) through the 8259A ...  failed.
 ...trying to set up timer as Virtual Wire IRQ... works.
 testing the IO APIC.......................
 .................................... done.
 Using local APIC timer interrupts.
 calibrating APIC timer ...
 ..... CPU clock speed is 2391.0950 MHz.
 ..... host bus clock speed is 99.0664 MHz.
 checking TSC synchronization across 4 CPUs: passed.
 Starting migration thread for cpu 0
 Bringing up 1
 CPU 1 IS NOW UP!
 Starting migration thread for cpu 1
 Bringing up 2
 CPU 2 IS NOW UP!
 Starting migration thread for cpu 2
 Bringing up 3
 CPU 3 IS NOW UP!
 Starting migration thread for cpu 3
 CPUS done 4
 Initializing RT netlink socket
 PCI: PCI BIOS revision 2.10 entry at 0xf1530, last bus=21
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 BIO: pool of 256 setup, 14Kb (56 bytes/bio)
 biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
 biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
 biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
 biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
 biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
 biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
 ACPI: Subsystem revision 20030714
  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
 Parsing all Control Methods:.................................................................................................................................................................................................
 Table [DSDT](id F004) - 568 Objects with 59 Devices 193 Methods 10 Regions
 ACPI Namespace successfully loaded at root c03b2e5c
 evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
 evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 000000000000EB08 on int 9
 evgpeblk-0748 [06] ev_create_gpe_block   : GPE 32 to 63 [_GPE] 4 regs at 000000000000E410 on int 9
 Completing Region/Field/Buffer/Package initialization:.....................................................................
 Initialized 10/10 Regions 0/0 Fields 47/47 Buffers 12/12 Packages (576 nodes)
 Executing all Device _STA and_INI methods:............................................................
 60 Devices found containing: 60 _STA, 2 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
 ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 pci_link-0256 [16] acpi_pci_link_get_curr: No IRQ resource found
 ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 pci_link-0256 [18] acpi_pci_link_get_curr: No IRQ resource found
 ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 pci_link-0256 [23] acpi_pci_link_get_curr: No IRQ resource found
 ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
 pci_link-0256 [44] acpi_pci_link_get_curr: No IRQ resource found
 ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15, disabled)
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
 ACPI: PCI Root Bridge [PCI1] (00:00)
 ACPI: PCI Root Bridge [PCI2] (00:00)
 Linux Plug and Play Support v0.97 (c) Adam Belay
 PnPBIOS: Scanning system for PnP BIOS support...
 PnPBIOS: Found PnP BIOS installation structure at 0xc00f9130
 PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9160, dseg 0xf0000
 PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
 SCSI subsystem initialized
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
 pci_link-0361 [42] acpi_pci_link_set     : Attempt to enable at IRQ 11 resulted in IRQ 9
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
 ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
 pci_link-0361 [47] acpi_pci_link_set     : Attempt to enable at IRQ 11 resulted in IRQ 9
 ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 0
 ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKJ] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNKK] enabled at IRQ 5
 ACPI: PCI Interrupt Link [LNKL] enabled at IRQ 9
 ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKN] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNKO] enabled at IRQ 5
 ACPI: PCI Interrupt Link [LNKP] enabled at IRQ 9
 ACPI: PCI Interrupt Link [LNKQ] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKR] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNKS] enabled at IRQ 5
 ACPI: PCI Interrupt Link [LNKT] enabled at IRQ 9
 ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKV] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNKW] enabled at IRQ 5
 ACPI: PCI Interrupt Link [LNKX] enabled at IRQ 9
 ACPI: PCI Interrupt Link [LNKY] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKZ] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 5
 ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
 ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
 ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
 pci_link-0361 [71] acpi_pci_link_set     : Attempt to enable at IRQ 5 resulted in IRQ 10
 ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 0
 pci_link-0502 [70] acpi_pci_link_get_irq : Link disabled
 pci_link-0502 [72] acpi_pci_link_get_irq : Link disabled
  pci_irq-0254 [71] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
  pci_irq-0294 [71] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:0f.2
 ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.2
 PCI: Using ACPI for IRQ routing
 PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
 pty: 256 Unix98 ptys configured
 SBF: Simple Boot Flag extension found and enabled.
 SBF: Setting boot flags 0x80
 Machine check exception polling timer started.
 Starting balanced_irq
 highmem bounce pool size: 64 pages
 ACPI: Processor [CPU0] (supports C1)
 ACPI: Processor [CPU1] (supports C1)
 ACPI: Processor [CPU2] (supports C1)
 ACPI: Processor [CPU3] (supports C1)
 lp: driver loaded but no devices found
 Real Time Clock Driver v1.11
 Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
 parport0: irq 7 detected
 lp0: using parport0 (polling).
 Using anticipatory scheduling elevator
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a National Semiconductor PC87306
 eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
 eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
 eth0: 0000:00:02.0, 00:E0:18:BD:DB:D4, IRQ 18.
   Board assembly 506470-151, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0xd0a6c714).
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
 SvrWks CSB5: chipset revision 147
 SvrWks CSB5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:pio, hdd:pio
 mice: PS/2 mouse device common for all mice
 input: PC Speaker
 serio: i8042 AUX port at 0x60,0x64 irq 12
 input: AT Set 2 keyboard on isa0060/serio0
 serio: i8042 KBD port at 0x60,0x64 irq 1
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP: routing cache hash table of 8192 buckets, 64Kbytes
 TCP: Hash tables configured (established 262144 bind 65536)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 BIOS EDD facility v0.09 2003-Jan-22, 3 devices found
 VFS: Cannot open root device "801" or unknown-block(8,1)
 Please append a correct "root=" boot option
 Kernel panic: VFS: Unable to mount root fs on unknown-block(8,1)


===================================================
Boot messages taken from serial console: pci=noacpi
===================================================


sym0: <1010-66> rev 0x1 on pci bus 18 device 3 function 0 irq 5
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-66> rev 0x1 on pci bus 18 device 3 function 1 irq 9
sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: DEVICE RESET operation started.
sym0:0:0: DEVICE RESET operation timed-out.
sym0:0:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:0:0: BUS RESET operation complete.
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: HOST RESET operation started.
sym0: SCSI BUS has been reset.


=================================
lspci -vvx: Boot option: acpi=off
=================================


 00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
	 Subsystem: ServerWorks: Unknown device 0015
	 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	 Region 1: Memory at f3000000 (32-bit, non-prefetchable) [size=4K]
 00: 66 11 08 00 02 00 00 00 21 00 00 06 10 00 80 00
 10: 08 00 00 f8 00 00 00 f3 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 15 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 00:00.1 PCI bridge: ServerWorks CNB20LE Host Bridge (rev a2) (prog-if 00 [Normal decode])
	 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	 Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	 Memory behind bridge: f2000000-f2ffffff
	 Prefetchable memory behind bridge: 00000000f3f00000-00000000f7f00000
	 BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
	 Capabilities: [80] AGP version 0.0
		 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		 Command: RQ=1 ArqSz=1 Cal=7 SBA- AGP+ GART64- 64bit- FW- Rate=x1
 00: 66 11 09 00 02 01 b0 32 a2 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 01 01 40 e1 d1 a0 32
 20: 00 f2 f0 f2 f1 f3 f1 f7 00 00 00 00 00 00 00 00
 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 88 00

 00:00.2 Host bridge: ServerWorks CMIC-GC Host Bridge
	 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 00: 66 11 15 00 00 00 00 00 00 00 00 06 10 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
	 Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 32 (2000ns min, 14000ns max), cache line size 08
	 Interrupt: pin A routed to IRQ 18
	 Region 0: Memory at f1800000 (32-bit, non-prefetchable) [size=4K]
	 Region 1: I/O ports at d800 [size=64]
	 Region 2: Memory at f1000000 (32-bit, non-prefetchable) [size=128K]
	 Expansion ROM at f3ef0000 [disabled] [size=64K]
	 Capabilities: [dc] Power Management version 2
		 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 00: 86 80 29 12 17 00 90 02 10 00 00 02 08 20 00 00
 10: 00 00 80 f1 01 d8 00 00 00 00 00 f1 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 40 10
 30: 00 00 ef f3 dc 00 00 00 00 00 00 00 0c 01 08 38

 00:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	 Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	 Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 32 (500ns min, 6000ns max)
	 Interrupt: pin A routed to IRQ 0
	 Region 0: I/O ports at d400 [disabled] [size=256]
	 Capabilities: [c0] Power Management version 2
		 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: f6 13 11 01 84 00 10 02 10 00 01 04 00 20 00 00
 10: 01 d4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e2 80
 30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 02 18

 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
	 Subsystem: ServerWorks CSB5 South Bridge
	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	 Latency: 32
 00: 66 11 01 02 07 00 00 22 93 00 01 06 00 20 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
	 Subsystem: ServerWorks CSB5 IDE Controller
	 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 64, cache line size 08
	 Region 0: I/O ports at <ignored>
	 Region 1: I/O ports at <ignored>
	 Region 2: I/O ports at <ignored>
	 Region 3: I/O ports at <ignored>
	 Region 4: I/O ports at a800 [size=16]
 00: 66 11 12 02 15 00 00 02 93 8a 01 01 08 40 80 00
 10: 01 d0 00 00 01 b8 00 00 01 b4 00 00 01 b0 00 00
 20: 01 a8 00 00 00 00 00 00 00 00 00 00 66 11 12 02
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
	 Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 32 (20000ns max), cache line size 08
	 Interrupt: pin A routed to IRQ 27
	 Region 0: Memory at f0800000 (32-bit, non-prefetchable) [size=4K]
 00: 66 11 20 02 17 00 80 02 05 10 03 0c 08 20 80 00
 10: 00 00 80 f0 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

 00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
	 Subsystem: ServerWorks: Unknown device 0230
	 Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 0
 00: 66 11 25 02 04 00 00 02 00 00 00 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 30 02
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
	 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	 Capabilities: [60] 00: 66 11 01 01 02 00 30 23 03 00 00 06 00 40 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

 00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
	 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	 Capabilities: [60] 00: 66 11 01 01 02 00 b0 23 03 00 00 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00

 01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440SE AGP 8x] (rev a2) (prog-if 00 [VGA])
	 Subsystem: Asustek Computer, Inc.: Unknown device 806f
	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 64 (1250ns min, 250ns max)
	 Interrupt: pin A routed to IRQ 27
	 Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=16M]
	 Region 1: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	 Expansion ROM at f3fe0000 [disabled] [size=128K]
	 Capabilities: [60] Power Management version 2
		 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	 Capabilities: [44] AGP version 3.0
		 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 00: de 10 82 01 07 00 b0 0a a2 00 00 03 00 40 00 00
 10: 00 00 00 f2 08 00 00 f4 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 6f 80
 30: 00 00 fe f3 60 00 00 00 00 00 00 00 09 01 05 01

 12:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	 Subsystem: LSI Logic / Symbios Logic: Unknown device 1010
	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 72 (4250ns min, 4500ns max), cache line size 08
	 Interrupt: pin A routed to IRQ 22
	 Region 0: I/O ports at a000 [size=256]
	 Region 1: Memory at ef800000 (64-bit, non-prefetchable) [size=1K]
	 Region 3: Memory at ef000000 (64-bit, non-prefetchable) [size=8K]
	 Expansion ROM at f3cf0000 [disabled] [size=16K]
	 Capabilities: [40] Power Management version 2
		 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 00 10 21 00 17 00 30 02 01 00 00 01 08 48 80 00
 10: 01 a0 00 00 04 00 80 ef 00 00 00 00 04 00 00 ef
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 10 10
 30: 00 00 cf f3 40 00 00 00 00 00 00 00 05 01 11 12

 12:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	 Subsystem: LSI Logic / Symbios Logic: Unknown device 1010
	 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	 Latency: 72 (4250ns min, 4500ns max), cache line size 08
	 Interrupt: pin B routed to IRQ 23
	 Region 0: I/O ports at 9800 [size=256]
	 Region 1: Memory at ee800000 (64-bit, non-prefetchable) [size=1K]
	 Region 3: Memory at ee000000 (64-bit, non-prefetchable) [size=8K]
	 Expansion ROM at f3ce0000 [disabled] [size=16K]
	 Capabilities: [40] Power Management version 2
		 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 00 10 21 00 17 00 30 02 01 00 00 01 08 48 80 00
 10: 01 98 00 00 04 00 80 ee 00 00 00 00 04 00 00 ee
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 10 10
 30: 00 00 ce f3 40 00 00 00 00 00 00 00 09 02 11 12

