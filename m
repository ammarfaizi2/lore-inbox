Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUAJUnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUAJUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:43:40 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:26618 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265365AbUAJUml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:42:41 -0500
Date: Sat, 10 Jan 2004 15:42:40 -0500
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
Message-ID: <20040110204240.GB1406@localhost>
References: <20040110042108.GB313@localhost> <1073712375.12069.1.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073712375.12069.1.camel@nosferatu.lan>
User-Agent: Mutt/1.5.4i
From: "Eric C. Cooper" <ecc@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 07:26:15AM +0200, Martin Schlemmer wrote:
> Looks like acpi failing - what about trying with latest acpi update:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/broken-out/acpi-20031203.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/broken-out/acpi-20031203-fix.patch

I tried with these two patches (but from the newer 2.6.1-mm2
directory).  I also enabled CONFIG_ACPI_DEBUG.  The problem is still
there:

Jan 10 15:25:09 jaguar kernel: Linux version 2.6.1 (root@jaguar.home) (gcc version 3.3.2 (Debian)) #1 Sat Jan 10 15:14:31 EST 2004
Jan 10 15:25:09 jaguar kernel: BIOS-provided physical RAM map:
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jan 10 15:25:09 jaguar kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan 10 15:25:09 jaguar kernel: 639MB HIGHMEM available.
Jan 10 15:25:09 jaguar kernel: 896MB LOWMEM available.
Jan 10 15:25:09 jaguar kernel: On node 0 totalpages: 393212
Jan 10 15:25:09 jaguar kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan 10 15:25:09 jaguar kernel:   Normal zone: 225280 pages, LIFO batch:16
Jan 10 15:25:09 jaguar kernel:   HighMem zone: 163836 pages, LIFO batch:16
Jan 10 15:25:09 jaguar kernel: DMI 2.3 present.
Jan 10 15:25:09 jaguar kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5810
Jan 10 15:25:09 jaguar kernel: ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc000
Jan 10 15:25:09 jaguar kernel: ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc0c0
Jan 10 15:25:09 jaguar kernel: ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc030
Jan 10 15:25:09 jaguar kernel: ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc058
Jan 10 15:25:09 jaguar kernel: ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
Jan 10 15:25:09 jaguar kernel: ACPI: Local APIC address 0xfee00000
Jan 10 15:25:09 jaguar kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan 10 15:25:09 jaguar kernel: Processor #0 15:2 APIC version 20
Jan 10 15:25:09 jaguar kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jan 10 15:25:09 jaguar kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Jan 10 15:25:09 jaguar kernel: IOAPIC[0]: Assigned apic_id 2
Jan 10 15:25:09 jaguar kernel: IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, IRQ 0-23
Jan 10 15:25:09 jaguar kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
Jan 10 15:25:09 jaguar kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
Jan 10 15:25:09 jaguar kernel: ACPI BALANCE SET
Jan 10 15:25:09 jaguar kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jan 10 15:25:09 jaguar kernel: Using ACPI (MADT) for SMP configuration information
Jan 10 15:25:09 jaguar kernel: Building zonelist for node : 0
Jan 10 15:25:09 jaguar kernel: Kernel command line: auto BOOT_IMAGE=linux ro root=301
Jan 10 15:25:09 jaguar kernel: Initializing CPU#0
Jan 10 15:25:09 jaguar kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Jan 10 15:25:09 jaguar kernel: Detected 2400.830 MHz processor.
Jan 10 15:25:09 jaguar kernel: Using tsc for high-res timesource
Jan 10 15:25:09 jaguar kernel: Console: colour VGA+ 80x25
Jan 10 15:25:09 jaguar kernel: Memory: 1553716k/1572848k available (1417k kernel code, 18028k reserved, 683k data, 160k init, 655344k highmem)
Jan 10 15:25:09 jaguar kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan 10 15:25:09 jaguar kernel: Calibrating delay loop... 4734.97 BogoMIPS
Jan 10 15:25:09 jaguar kernel: Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Jan 10 15:25:09 jaguar kernel: Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 10 15:25:09 jaguar kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jan 10 15:25:09 jaguar kernel: CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
Jan 10 15:25:09 jaguar kernel: CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
Jan 10 15:25:09 jaguar kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jan 10 15:25:09 jaguar kernel: CPU: L2 cache: 512K
Jan 10 15:25:09 jaguar kernel: CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Jan 10 15:25:09 jaguar kernel: Intel machine check architecture supported.
Jan 10 15:25:09 jaguar kernel: Intel machine check reporting enabled on CPU#0.
Jan 10 15:25:09 jaguar kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Jan 10 15:25:09 jaguar kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Jan 10 15:25:09 jaguar kernel: Enabling fast FPU save and restore... done.
Jan 10 15:25:09 jaguar kernel: Enabling unmasked SIMD FPU exception support... done.
Jan 10 15:25:09 jaguar kernel: Checking 'hlt' instruction... OK.
Jan 10 15:25:09 jaguar kernel: POSIX conformance testing by UNIFIX
Jan 10 15:25:09 jaguar kernel: enabled ExtINT on CPU#0
Jan 10 15:25:09 jaguar kernel: ESR value before enabling vector: 00000000
Jan 10 15:25:09 jaguar kernel: ESR value after enabling vector: 00000000
Jan 10 15:25:09 jaguar kernel: ENABLING IO-APIC IRQs
Jan 10 15:25:09 jaguar kernel: init IO_APIC IRQs
Jan 10 15:25:09 jaguar kernel:  IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
Jan 10 15:25:09 jaguar kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jan 10 15:25:09 jaguar kernel: Using local APIC timer interrupts.
Jan 10 15:25:09 jaguar kernel: calibrating APIC timer ...
Jan 10 15:25:09 jaguar kernel: ..... CPU clock speed is 2399.0797 MHz.
Jan 10 15:25:09 jaguar kernel: ..... host bus clock speed is 133.0321 MHz.
Jan 10 15:25:09 jaguar kernel: NET: Registered protocol family 16
Jan 10 15:25:09 jaguar kernel: PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
Jan 10 15:25:09 jaguar kernel: PCI: Using configuration type 1
Jan 10 15:25:09 jaguar kernel: mtrr: v2.0 (20020519)
Jan 10 15:25:09 jaguar kernel: ACPI: Subsystem revision 20031203
Jan 10 15:25:09 jaguar kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Jan 10 15:25:09 jaguar kernel: Parsing all Control Methods:....................................................................................................................................
Jan 10 15:25:09 jaguar kernel: Table [DSDT](id F004) - 326 Objects with 47 Devices 132 Methods 6 Regions
Jan 10 15:25:09 jaguar kernel: ACPI Namespace successfully loaded at root c034d9bc
Jan 10 15:25:09 jaguar kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
Jan 10 15:25:09 jaguar kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
Jan 10 15:25:09 jaguar kernel: evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
Jan 10 15:25:09 jaguar kernel: evgpeblk-0747 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Jan 10 15:25:09 jaguar kernel: ACPI: SCI (IRQ20) allocation failed
Jan 10 15:25:09 jaguar kernel:  evevent-0133: *** Error: Unable to install System Control Interrupt Handler, AE_NOT_ACQUIRED
Jan 10 15:25:09 jaguar kernel: ACPI: Unable to start the ACPI Interpreter
Jan 10 15:25:09 jaguar kernel: evxfevnt-0139 [06] acpi_disable          : ACPI mode disabled
Jan 10 15:25:09 jaguar kernel:  utalloc-0945 [05] ut_dump_allocations   : No outstanding allocations.
Jan 10 15:25:09 jaguar kernel: Trying to free free IRQ20
Jan 10 15:25:09 jaguar kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan 10 15:25:09 jaguar kernel: PnPBIOS: Scanning system for PnP BIOS support...
Jan 10 15:25:09 jaguar kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f9680
Jan 10 15:25:09 jaguar kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x96b0, dseg 0xf0000
Jan 10 15:25:09 jaguar kernel: pnp: 00:12: ioport range 0xe600-0xe61f has been reserved
Jan 10 15:25:09 jaguar kernel: pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
Jan 10 15:25:09 jaguar kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Jan 10 15:25:09 jaguar kernel: ACPI: ACPI tables contain no PCI IRQ routing entries
Jan 10 15:25:09 jaguar kernel: PCI: Invalid ACPI-PCI IRQ routing table
Jan 10 15:25:09 jaguar kernel: PCI: Probing PCI hardware
Jan 10 15:25:09 jaguar kernel: PCI: Probing PCI hardware (bus 00)
Jan 10 15:25:09 jaguar kernel: Enabling SiS 96x SMBus.
Jan 10 15:25:09 jaguar kernel: PCI: Using IRQ router default [1039/0963] at 0000:00:02.0
Jan 10 15:25:09 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!
Jan 10 15:25:09 jaguar last message repeated 9 times
Jan 10 15:25:09 jaguar kernel: PCI BIOS passed nonexistent PCI bus 1!
Jan 10 15:25:09 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!


For comparison, here is the same system booted with pci=noacpi:


Jan 10 15:27:37 jaguar kernel: Linux version 2.6.1 (root@jaguar.home) (gcc version 3.3.2 (Debian)) #1 Sat Jan 10 15:14:31 EST 2004
Jan 10 15:27:37 jaguar kernel: BIOS-provided physical RAM map:
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jan 10 15:27:37 jaguar kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan 10 15:27:37 jaguar kernel: 639MB HIGHMEM available.
Jan 10 15:27:37 jaguar kernel: 896MB LOWMEM available.
Jan 10 15:27:37 jaguar kernel: On node 0 totalpages: 393212
Jan 10 15:27:37 jaguar kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan 10 15:27:37 jaguar kernel:   Normal zone: 225280 pages, LIFO batch:16
Jan 10 15:27:37 jaguar kernel:   HighMem zone: 163836 pages, LIFO batch:16
Jan 10 15:27:37 jaguar kernel: DMI 2.3 present.
Jan 10 15:27:37 jaguar kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5810
Jan 10 15:27:37 jaguar kernel: ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc000
Jan 10 15:27:37 jaguar kernel: ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc0c0
Jan 10 15:27:37 jaguar kernel: ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc030
Jan 10 15:27:37 jaguar kernel: ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x5fffc058
Jan 10 15:27:37 jaguar kernel: ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
Jan 10 15:27:37 jaguar kernel: ACPI: Local APIC address 0xfee00000
Jan 10 15:27:37 jaguar kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan 10 15:27:37 jaguar kernel: Processor #0 15:2 APIC version 20
Jan 10 15:27:37 jaguar kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jan 10 15:27:37 jaguar kernel: Building zonelist for node : 0
Jan 10 15:27:37 jaguar kernel: Kernel command line: BOOT_IMAGE=linux ro root=301 pci=noacpi
Jan 10 15:27:37 jaguar kernel: Found and enabled local APIC!
Jan 10 15:27:37 jaguar kernel: Initializing CPU#0
Jan 10 15:27:37 jaguar kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Jan 10 15:27:37 jaguar kernel: Detected 2400.815 MHz processor.
Jan 10 15:27:37 jaguar kernel: Using tsc for high-res timesource
Jan 10 15:27:37 jaguar kernel: Console: colour VGA+ 80x25
Jan 10 15:27:37 jaguar kernel: Memory: 1553716k/1572848k available (1417k kernel code, 18028k reserved, 683k data, 160k init, 655344k highmem)
Jan 10 15:27:37 jaguar kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan 10 15:27:37 jaguar kernel: Calibrating delay loop... 4734.97 BogoMIPS
Jan 10 15:27:37 jaguar kernel: Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Jan 10 15:27:37 jaguar kernel: Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 10 15:27:37 jaguar kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jan 10 15:27:37 jaguar kernel: CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
Jan 10 15:27:37 jaguar kernel: CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
Jan 10 15:27:37 jaguar kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jan 10 15:27:37 jaguar kernel: CPU: L2 cache: 512K
Jan 10 15:27:37 jaguar kernel: CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Jan 10 15:27:37 jaguar kernel: Intel machine check architecture supported.
Jan 10 15:27:37 jaguar kernel: Intel machine check reporting enabled on CPU#0.
Jan 10 15:27:37 jaguar kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Jan 10 15:27:37 jaguar kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Jan 10 15:27:37 jaguar kernel: Enabling fast FPU save and restore... done.
Jan 10 15:27:37 jaguar kernel: Enabling unmasked SIMD FPU exception support... done.
Jan 10 15:27:37 jaguar kernel: Checking 'hlt' instruction... OK.
Jan 10 15:27:37 jaguar kernel: POSIX conformance testing by UNIFIX
Jan 10 15:27:37 jaguar kernel: enabled ExtINT on CPU#0
Jan 10 15:27:37 jaguar kernel: ESR value before enabling vector: 00000000
Jan 10 15:27:37 jaguar kernel: ESR value after enabling vector: 00000000
Jan 10 15:27:37 jaguar kernel: Using local APIC timer interrupts.
Jan 10 15:27:37 jaguar kernel: calibrating APIC timer ...
Jan 10 15:27:37 jaguar kernel: ..... CPU clock speed is 2399.0772 MHz.
Jan 10 15:27:37 jaguar kernel: ..... host bus clock speed is 133.0320 MHz.
Jan 10 15:27:37 jaguar kernel: NET: Registered protocol family 16
Jan 10 15:27:37 jaguar kernel: PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
Jan 10 15:27:37 jaguar kernel: PCI: Using configuration type 1
Jan 10 15:27:37 jaguar kernel: mtrr: v2.0 (20020519)
Jan 10 15:27:37 jaguar kernel: ACPI: Subsystem revision 20031203
Jan 10 15:27:37 jaguar kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Jan 10 15:27:37 jaguar kernel: Parsing all Control Methods:....................................................................................................................................
Jan 10 15:27:37 jaguar kernel: Table [DSDT](id F004) - 326 Objects with 47 Devices 132 Methods 6 Regions
Jan 10 15:27:37 jaguar kernel: ACPI Namespace successfully loaded at root c034d9bc
Jan 10 15:27:37 jaguar kernel: ACPI: IRQ9 SCI: Level Trigger.
Jan 10 15:27:37 jaguar kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
Jan 10 15:27:37 jaguar kernel: evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
Jan 10 15:27:37 jaguar kernel: evgpeblk-0747 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Jan 10 15:27:37 jaguar kernel: Completing Region/Field/Buffer/Package initialization:........................................
Jan 10 15:27:37 jaguar kernel: Initialized 6/6 Regions 0/0 Fields 23/23 Buffers 11/11 Packages (334 nodes)
Jan 10 15:27:37 jaguar kernel: Executing all Device _STA and_INI methods:..................................................
Jan 10 15:27:37 jaguar kernel: 50 Devices found containing: 50 _STA, 1 _INI methods
Jan 10 15:27:37 jaguar kernel: ACPI: Interpreter enabled
Jan 10 15:27:37 jaguar kernel: ACPI: Using PIC for interrupt routing
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15)
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan 10 15:27:37 jaguar kernel: PCI: Probing PCI hardware (bus 00)
Jan 10 15:27:37 jaguar kernel: Enabling SiS 96x SMBus.
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan 10 15:27:37 jaguar kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Jan 10 15:27:37 jaguar kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan 10 15:27:37 jaguar kernel: PnPBIOS: Scanning system for PnP BIOS support...
Jan 10 15:27:37 jaguar kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f9680
Jan 10 15:27:37 jaguar kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x96b0, dseg 0xf0000
Jan 10 15:27:37 jaguar kernel: pnp: 00:12: ioport range 0xe600-0xe61f has been reserved
Jan 10 15:27:37 jaguar kernel: pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
Jan 10 15:27:37 jaguar kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Jan 10 15:27:37 jaguar kernel: PCI: Probing PCI hardware
Jan 10 15:27:37 jaguar kernel: PCI: Using IRQ router default [1039/0963] at 0000:00:02.0
Jan 10 15:27:37 jaguar kernel: PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
Jan 10 15:27:37 jaguar kernel: PCI: Cannot allocate resource region 4 of device 0000:00:02.1


-- 
Eric C. Cooper          e c c @ c m u . e d u
