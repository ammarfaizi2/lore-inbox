Return-Path: <linux-kernel-owner+w=401wt.eu-S1754852AbWL1NmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbWL1NmJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbWL1NmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:42:09 -0500
Received: from lucidpixels.com ([66.45.37.187]:54860 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852AbWL1NmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:42:05 -0500
Date: Thu, 28 Dec 2006 08:41:55 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: xfs@oss.sgi.com
Subject: Re: Kernel 2.6.19: Kernel Panic! XFS / UDEV Issue?
In-Reply-To: <Pine.LNX.4.64.0612261622360.1627@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0612280841410.28993@p34.internal.lan>
References: <Pine.LNX.4.64.0612261622360.1627@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any idea what happened here?

On Tue, 26 Dec 2006, Justin Piszcz wrote:

> I use netconsole on all my machines and it caught the crash, I was not 
> doing anything special, just rebooted my machine and when it was booting, 
> this happened:
> 
> Looks like an XFS problem?
> 
> System Events
> =-=-=-=-=-=-=
> Dec 26 15:59:37 box [    0.000000] BIOS-provided physical RAM map:
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
> Dec 26 15:59:37 box [    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> Dec 26 15:59:37 box [    0.000000] 1151MB HIGHMEM available.
> Dec 26 15:59:37 box [    0.000000] 896MB LOWMEM available.
> Dec 26 15:59:37 box [    0.000000] found SMP MP-table at 000f5d10
> Dec 26 15:59:37 box [    0.000000] Zone PFN ranges:
> Dec 26 15:59:37 box [    0.000000]   DMA             0 ->     4096
> Dec 26 15:59:37 box [    0.000000]   Normal       4096 ->   229376
> Dec 26 15:59:37 box [    0.000000]   HighMem    229376 ->   524272
> Dec 26 15:59:37 box [    0.000000] early_node_map[1] active PFN ranges
> Dec 26 15:59:37 box [    0.000000]     0:        0 ->   524272
> Dec 26 15:59:37 box [    0.000000] DMI 2.2 present.
> Dec 26 15:59:37 box [    0.000000] ACPI: PM-Timer IO Port: 0x408
> Dec 26 15:59:37 box [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Dec 26 15:59:37 box [    0.000000] Processor #0 15:2 APIC version 20
> Dec 26 15:59:37 box [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Dec 26 15:59:37 box [    0.000000] Processor #1 15:2 APIC version 20
> Dec 26 15:59:37 box [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> Dec 26 15:59:37 box [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> Dec 26 15:59:37 box [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> Dec 26 15:59:37 box [    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> Dec 26 15:59:37 box [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Dec 26 15:59:37 box [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Dec 26 15:59:37 box [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Dec 26 15:59:37 box [    0.000000] Using ACPI (MADT) for SMP configuration information
> Dec 26 15:59:37 box [    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
> Dec 26 15:59:37 box [    0.000000] Detected 2606.071 MHz processor.
> Dec 26 15:59:37 box [   22.359952] Built 1 zonelists.  Total pages: 520177
> Dec 26 15:59:37 box [   22.359955] Kernel command line: auto BOOT_IMAGE=2.6.19-2 ro root=802 netconsole=4444@192.168.168.1/eth0,514@192.168.0.254/00:07:C9:55:47:AB nmi_watchdog=1
> Dec 26 15:59:37 box [   22.359995] netconsole: local port 4444
> Dec 26 15:59:37 box [   22.359998] netconsole: local IP 192.168.168.1
> Dec 26 15:59:37 box [   22.360000] netconsole: interface eth0
> Dec 26 15:59:37 box [   22.360002] netconsole: remote port 514
> Dec 26 15:59:37 box [   22.360004] netconsole: remote IP 192.168.0.254
> Dec 26 15:59:37 box [   22.360008] netconsole: remote ethernet address 00:07:e9:29:37:db
> Dec 26 15:59:37 box [   22.360179] Enabling fast FPU save and restore... done.
> Dec 26 15:59:37 box [   22.360182] Enabling unmasked SIMD FPU exception support... done.
> Dec 26 15:59:37 box [   22.360186] Initializing CPU#0
> Dec 26 15:59:37 box [   22.360251] PID hash table entries: 4096 (order: 12, 16384 bytes)
> Dec 26 15:59:37 box [   22.361425] Console: colour VGA+ 80x25
> Dec 26 15:59:37 box [   22.364157] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Dec 26 15:59:37 box [   22.364658] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Dec 26 15:59:37 box [   22.463391] Memory: 2074188k/2097088k available (3017k kernel code, 21684k reserved, 872k data, 216k init, 1179584k highmem)
> Dec 26 15:59:37 box [   22.463467] virtual kernel memory layout:
> Dec 26 15:59:37 box [   22.463468]     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
> Dec 26 15:59:37 box [   22.463469]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> Dec 26 15:59:37 box [   22.463470]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
> Dec 26 15:59:37 box [   22.463471]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
> Dec 26 15:59:37 box [   22.463472]       .init : 0xc04d3000 - 0xc0509000   ( 216 kB)
> Dec 26 15:59:37 box [   22.463473]       .data : 0xc03f2412 - 0xc04cc424   ( 872 kB)
> Dec 26 15:59:37 box [   22.463475]       .text : 0xc0100000 - 0xc03f2412   (3017 kB)
> Dec 26 15:59:37 box [   22.463860] Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Dec 26 15:59:37 box [   22.523834] Calibrating delay using timer specific routine.. 5213.93 BogoMIPS (lpj=2606966)
> Dec 26 15:59:37 box [   22.523973] Mount-cache hash table entries: 512
> Dec 26 15:59:37 box [   22.524142] CPU: Trace cache: 12K uops, L1 D cache: 8K
> Dec 26 15:59:37 box [   22.524226] CPU: L2 cache: 512K
> Dec 26 15:59:37 box [   22.524274] CPU: Physical Processor ID: 0
> Dec 26 15:59:37 box [   22.524343] Checking 'hlt' instruction... OK.
> Dec 26 15:59:37 box [   22.528015] Freeing SMP alternatives: 12k freed
> Dec 26 15:59:37 box [   22.528065] ACPI: Core revision 20060707
> Dec 26 15:59:37 box [   22.547938] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
> Dec 26 15:59:37 box [   22.548078] Booting processor 1/1 eip 2000
> Dec 26 15:59:37 box [   22.558416] Initializing CPU#1
> Dec 26 15:59:37 box [   22.618587] Calibrating delay using timer specific routine.. 5211.07 BogoMIPS (lpj=2605538)
> Dec 26 15:59:37 box [   22.618607] CPU: Trace cache: 12K uops, L1 D cache: 8K
> Dec 26 15:59:37 box [   22.618610] CPU: L2 cache: 512K
> Dec 26 15:59:37 box [   22.618612] CPU: Physical Processor ID: 0
> Dec 26 15:59:37 box [   22.618778] CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
> Dec 26 15:59:37 box [   22.619156] Total of 2 processors activated (10425.00 BogoMIPS).
> Dec 26 15:59:37 box [   22.619333] ENABLING IO-APIC IRQs
> Dec 26 15:59:37 box [   22.619553] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> Dec 26 15:59:37 box [   22.731308] checking TSC synchronization across 2 CPUs: passed.
> Dec 26 15:59:37 box [    0.000955] Brought up 2 CPUs
> Dec 26 15:59:37 box [    0.054654] migration_cost=44
> Dec 26 15:59:37 box [    0.055223] NET: Registered protocol family 16
> Dec 26 15:59:37 box [    0.055360] ACPI: bus type pci registered
> Dec 26 15:59:37 box [    0.067272] PCI: PCI BIOS revision 2.10 entry at 0xfb720, last bus=3
> Dec 26 15:59:37 box [    0.067324] PCI: Using configuration type 1
> Dec 26 15:59:37 box [    0.067372] Setting up standard PCI resources
> Dec 26 15:59:37 box [    0.078356] ACPI: Interpreter enabled
> Dec 26 15:59:37 box [    0.078409] ACPI: Using IOAPIC for interrupt routing
> Dec 26 15:59:37 box [    0.079073] ACPI: PCI Root Bridge [PCI0] (0000:00)
> Dec 26 15:59:37 box [    0.081912] PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
> Dec 26 15:59:37 box [    0.081966] PCI quirk: region 0480-04bf claimed by ICH4 GPIO
> Dec 26 15:59:37 box [    0.082062] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> Dec 26 15:59:37 box [    0.082778] PCI: Transparent bridge - 0000:00:1e.0
> Dec 26 15:59:37 box [    0.096418] ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 7 9 10 11 12 14 15)
> Dec 26 15:59:37 box [    0.097163] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
> Dec 26 15:59:37 box [    0.097907] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> Dec 26 15:59:37 box [    0.098638] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
> Dec 26 15:59:37 box [    0.099377] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
> Dec 26 15:59:37 box [    0.100194] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 *9 10 11 12 14 15)
> Dec 26 15:59:37 box [    0.100934] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
> Dec 26 15:59:37 box [    0.101665] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> Dec 26 15:59:37 box [    0.202525] ACPI: Power Resource [PFAN] (off)
> Dec 26 15:59:37 box [    0.202881] SCSI subsystem initialized
> Dec 26 15:59:37 box [    0.203088] PCI: Using ACPI for IRQ routing
> Dec 26 15:59:37 box [    0.203139] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> Dec 26 15:59:37 box [    0.228483] PCI: Bridge: 0000:00:01.0
> Dec 26 15:59:37 box [    0.228533]   IO window: disabled.
> Dec 26 15:59:37 box [    0.228583]   MEM window: f8000000-f9ffffff
> Dec 26 15:59:37 box [    0.228634]   PREFETCH window: f0000000-f7ffffff
> Dec 26 15:59:37 box [    0.228685] PCI: Bridge: 0000:00:03.0
> Dec 26 15:59:37 box [    0.228734]   IO window: a000-afff
> Dec 26 15:59:37 box [    0.228784]   MEM window: fc000000-fc0fffff
> Dec 26 15:59:37 box [    0.228834]   PREFETCH window: disabled.
> Dec 26 15:59:37 box [    0.228886] PCI: Bridge: 0000:00:1e.0
> Dec 26 15:59:37 box [    0.228935]   IO window: 8000-9fff
> Dec 26 15:59:37 box [    0.228985]   MEM window: fa000000-fbffffff
> Dec 26 15:59:37 box [    0.229036]   PREFETCH window: 88000000-880fffff
> Dec 26 15:59:37 box [    0.229138] NET: Registered protocol family 2
> Dec 26 15:59:37 box [    0.240374] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> Dec 26 15:59:37 box [    0.240578] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
> Dec 26 15:59:37 box [    0.241573] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
> Dec 26 15:59:37 box [    0.242257] TCP: Hash tables configured (established 131072 bind 65536)
> Dec 26 15:59:37 box [    0.242312] TCP reno registered
> Dec 26 15:59:37 box [    0.242860] highmem bounce pool size: 64 pages
> Dec 26 15:59:37 box [    0.243086] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Dec 26 15:59:37 box [    0.243489] io scheduler noop registered
> Dec 26 15:59:37 box [    0.243573] io scheduler anticipatory registered (default)
> Dec 26 15:59:37 box [    0.246317] Real Time Clock Driver v1.12ac
> Dec 26 15:59:37 box [    0.246370] Linux agpgart interface v0.101 (c) Dave Jones
> Dec 26 15:59:37 box [    0.246462] agpgart: Detected an Intel i875 Chipset.
> Dec 26 15:59:37 box [    0.250882] agpgart: AGP aperture is 128M @ 0xe8000000
> Dec 26 15:59:37 box [    0.250958] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
> Dec 26 15:59:37 box [    0.251133] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Dec 26 15:59:37 box [    0.251356] Floppy drive(s): fd0 is 1.44M
> Dec 26 15:59:37 box [    0.267012] FDC 0 is a post-1991 82077
> Dec 26 15:59:37 box [    0.268351] loop: loaded (max 8 devices)
> Dec 26 15:59:37 box [    0.268442] Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
> Dec 26 15:59:37 box [    0.268493] Copyright (c) 1999-2006 Intel Corporation.
> Dec 26 15:59:37 box [    0.268600] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
> Dec 26 15:59:37 box [    0.604067] e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:50:8d:f1:07:38
> Dec 26 15:59:37 box [    0.834733] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> Dec 26 15:59:37 box [    0.834892] netconsole: device eth0 not up yet, forcing it
> Dec 26 15:59:37 box [    3.322054] e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
> Dec 26 15:59:37 box [    3.332192] netconsole: network logging started
> Dec 26 15:59:37 box [    3.332249] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Dec 26 15:59:37 box [    3.332302] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Dec 26 15:59:37 box [    3.332399] ICH5: IDE controller at PCI slot 0000:00:1f.1
> Dec 26 15:59:37 box [    3.332458] ACPI: PCI Interrupt 0000:00:1f.1[A] ->
> Dec 26 15:59:37 box GSI 18 (level, low) -> IRQ 16
> Dec 26 15:59:37 box [    3.332563] ICH5: chipset revision 2
> Dec 26 15:59:37 box [    3.332613] ICH5: not 100% native mode: will probe irqs later
> Dec 26 15:59:37 box [    3.332671]     ide0: BM-DMA at 0xf000-0xf007
> Dec 26 15:59:37 box , BIOS settings: hda:DMA, hdb:pio
> Dec 26 15:59:37 box
> Dec 26 15:59:37 box [    3.332815]     ide1: BM-DMA at 0xf008-0xf00f
> Dec 26 15:59:37 box , BIOS settings: hdc:DMA, hdd:pio
> Dec 26 15:59:37 box
> Dec 26 15:59:38 box [    4.003579] hda: _NEC DVD_RW ND-3550A,
> Dec 26 15:59:38 box ATAPI
> Dec 26 15:59:38 box CD/DVD-ROM
> Dec 26 15:59:38 box  drive
> Dec 26 15:59:39 box [    4.615066] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Dec 26 15:59:39 box
> Dec 26 15:59:39 box [    5.286214] hdc: LITE-ON LTR-52246S,
> Dec 26 15:59:39 box ATAPI
> Dec 26 15:59:39 box CD/DVD-ROM
> Dec 26 15:59:39 box  drive
> Dec 26 15:59:40 box [    5.594037] ide1 at 0x170-0x177,0x376 on irq 15
> Dec 26 15:59:40 box
> Dec 26 15:59:40 box [    5.594975] hda: ATAPI
> Dec 26 15:59:40 box  48X
> Dec 26 15:59:40 box  DVD-ROM
> Dec 26 15:59:40 box  DVD-R
> Dec 26 15:59:40 box  CD-R/RW
> Dec 26 15:59:40 box  drive
> Dec 26 15:59:40 box , 2048kB Cache
> Dec 26 15:59:40 box , UDMA(33)
> Dec 26 15:59:40 box
> Dec 26 15:59:40 box [    5.595335] Uniform CD-ROM driver Revision: 3.20
> Dec 26 15:59:40 box [    5.605270] hdc: ATAPI
> Dec 26 15:59:40 box  52X
> Dec 26 15:59:40 box  CD-ROM
> Dec 26 15:59:40 box  CD-R/RW
> Dec 26 15:59:40 box  drive
> Dec 26 15:59:40 box , 2048kB Cache
> Dec 26 15:59:40 box , UDMA(33)
> Dec 26 15:59:40 box
> Dec 26 15:59:40 box [    5.644915] ACPI: PCI Interrupt 0000:03:06.0[A] ->
> Dec 26 15:59:40 box GSI 22 (level, low) -> IRQ 17
> Dec 26 15:59:43 box [    8.646272] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
> Dec 26 15:59:43 box [    8.646274]         <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
> Dec 26 15:59:43 box [    8.646275]         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
> Dec 26 15:59:43 box [    8.646277]
> Dec 26 15:59:44 box [   10.481100] ata_piix 0000:00:1f.2: MAP [
> Dec 26 15:59:44 box  P0
> Dec 26 15:59:44 box  --
> Dec 26 15:59:44 box  P1
> Dec 26 15:59:44 box  --
> Dec 26 15:59:44 box  ]
> Dec 26 15:59:44 box [   10.481347] ACPI: PCI Interrupt 0000:00:1f.2[A] ->
> Dec 26 15:59:44 box GSI 18 (level, low) -> IRQ 16
> Dec 26 15:59:44 box [   10.481502] ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> Dec 26 15:59:44 box [   10.481591] ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> Dec 26 15:59:44 box [   10.481651] scsi1 : ata_piix
> Dec 26 15:59:45 box [   10.635214] ata1.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
> Dec 26 15:59:45 box [   10.635279] ata1.00: ata1: dev 0 multi count 16
> Dec 26 15:59:45 box [   10.665619] ata1.00: configured for UDMA/133
> Dec 26 15:59:45 box [   10.665674] scsi2 : ata_piix
> Dec 26 15:59:45 box [   10.827315] ATA: abnormal status 0x7F on port 0xC807
> Dec 26 15:59:45 box [   10.827469] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
> Dec 26 15:59:45 box [   10.827651] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> Dec 26 15:59:45 box [   10.828414] sda: Write Protect is off
> Dec 26 15:59:45 box [   10.828492] SCSI device sda: drive cache: write back
> Dec 26 15:59:45 box [   10.828601] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> Dec 26 15:59:45 box [   10.828667] sda: Write Protect is off
> Dec 26 15:59:45 box [   10.828746] SCSI device sda: drive cache: write back
> Dec 26 15:59:45 box [   10.828798]  sda:
> Dec 26 15:59:45 box  sda1
> Dec 26 15:59:45 box  sda2
> Dec 26 15:59:45 box
> Dec 26 15:59:45 box [   10.838140] sd 1:0:0:0: Attached scsi disk sda
> Dec 26 15:59:45 box [   10.838277] sd 1:0:0:0: Attached scsi generic sg0 type 0
> Dec 26 15:59:45 box [   10.840768] serio: i8042 KBD port at 0x60,0x64 irq 1
> Dec 26 15:59:45 box [   10.840824] serio: i8042 AUX port at 0x60,0x64 irq 12
> Dec 26 15:59:45 box [   10.840947] mice: PS/2 mouse device common for all mice
> Dec 26 15:59:45 box [   10.841165] input: PC Speaker as /class/input/input0
> Dec 26 15:59:45 box [   10.870150] input: AT Translated Set 2 keyboard as /class/input/input1
> Dec 26 15:59:45 box [   10.874664] i2c /dev entries driver
> Dec 26 15:59:45 box [   10.875229] Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28 14:07:24 2006 UTC).
> Dec 26 15:59:45 box [   10.875551] ACPI: PCI Interrupt 0000:03:05.0[A] ->
> Dec 26 15:59:45 box GSI 21 (level, low) -> IRQ 18
> Dec 26 15:59:45 box [   10.899119] ALSA device list:
> Dec 26 15:59:45 box [   10.899176]   #0: SBLive! Value [CT4832] (rev.7, serial:0x80271102) at 0x9400, irq 18
> Dec 26 15:59:45 box [   10.899241] TCP cubic registered
> Dec 26 15:59:45 box [   10.899313] NET: Registered protocol family 1
> Dec 26 15:59:45 box [   10.899373] NET: Registered protocol family 17
> Dec 26 15:59:45 box [   10.899465] Testing NMI watchdog ...
> Dec 26 15:59:45 box OK.
> Dec 26 15:59:45 box [   10.909531] Starting balanced_irq
> Dec 26 15:59:45 box [   10.909586] Using IPI Shortcut mode
> Dec 26 15:59:45 box [   10.909755] Time: tsc clocksource has been installed.
> Dec 26 15:59:46 box [   11.582043] input: ImPS/2 Generic Wheel Mouse as /class/input/input2
> Dec 26 15:59:46 box [   11.638471] UDF-fs: No VRS found
> Dec 26 15:59:46 box [   11.670420] XFS mounting filesystem sda2
> Dec 26 15:59:46 box [   11.748382] VFS: Mounted root (xfs filesystem) readonly.
> Dec 26 15:59:46 box [   11.748601] Freeing unused kernel memory: 216k freed
> Dec 26 15:59:48 box [   13.956518] BUG: unable to handle kernel paging request
> Dec 26 15:59:48 box  at virtual address fffb9600
> Dec 26 15:59:48 box [   13.956649]  printing eip:
> Dec 26 15:59:48 box [   13.956703] c0149018
> Dec 26 15:59:48 box [   13.956754] *pde = 00003067
> Dec 26 15:59:48 box [   13.956811] *pte = 00000000
> Dec 26 15:59:48 box [   13.956880] Oops: 0000 [#1]
> Dec 26 15:59:48 box [   13.956944] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.957101] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.957206] CPU:    0
> Dec 26 15:59:48 box [   13.957207] EIP:    0060:[<c0149018>]    Not tainted VLI
> Dec 26 15:59:48 box [   13.957209] EFLAGS: 00010286   (2.6.19 #2)
> Dec 26 15:59:48 box [   13.957381] EIP is at do_wp_page+0xec/0x431
> Dec 26 15:59:48 box [   13.957438] eax: fffb8000   ebx: fffb8000   ecx: 00000280   edx: c0003ee0
> Dec 26 15:59:48 box [   13.957505] esi: fffb9600   edi: fffb8600   ebp: c1ff06a0   esp: f7b8bed4
> Dec 26 15:59:48 box [   13.957574] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   13.957638] Process udevd (pid: 560, ti=f7b8a000 task=c2157a90 task.ti=f7b8a000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.957695] Stack:
> Dec 26 15:59:48 box c1ff3ce0
> Dec 26 15:59:48 box 00000004
> Dec 26 15:59:48 box 7f835065
> Dec 26 15:59:48 box fffb9000
> Dec 26 15:59:48 box b7e4502c
> Dec 26 15:59:48 box f7be11d0
> Dec 26 15:59:48 box f7b84040
> Dec 26 15:59:48 box c1ff3ce0
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.958140]
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box f7410914
> Dec 26 15:59:48 box f741bb7c
> Dec 26 15:59:48 box f7b84088
> Dec 26 15:59:48 box 00000007
> Dec 26 15:59:48 box c014a740
> Dec 26 15:59:48 box f7410914
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.958579]
> Dec 26 15:59:48 box f741bb7c
> Dec 26 15:59:48 box f7b84088
> Dec 26 15:59:48 box 7f835065
> Dec 26 15:59:48 box c016c06c
> Dec 26 15:59:48 box c21334ac
> Dec 26 15:59:48 box c21334ac
> Dec 26 15:59:48 box f7b75954
> Dec 26 15:59:48 box f7b84088
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.959044] Call Trace:
> Dec 26 15:59:48 box [   13.959146]  [<c014a740>]
> Dec 26 15:59:48 box __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box [   13.959246]  [<c016c06c>]
> Dec 26 15:59:48 box dentry_iput+0x6b/0xba
> Dec 26 15:59:48 box [   13.959345]  [<c0171023>]
> Dec 26 15:59:48 box mntput_no_expire+0x1c/0x7d
> Dec 26 15:59:48 box [   13.959458]  [<c015ca17>]
> Dec 26 15:59:48 box __fput+0x174/0x1c2
> Dec 26 15:59:48 box [   13.959568]  [<c0112ffa>]
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   13.959678]  [<c0112b5f>]
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   13.959772]  [<c03f1699>]
> Dec 26 15:59:48 box error_code+0x39/0x40
> Dec 26 15:59:48 box [   13.959878]  [<c03f007b>]
> Dec 26 15:59:48 box schedule_timeout+0xa5/0xb0
> Dec 26 15:59:48 box [   13.959987]  =======================
> Dec 26 15:59:48 box [   13.960049] Code:
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box e8
> Dec 26 15:59:48 box d1
> Dec 26 15:59:48 box a9
> Dec 26 15:59:48 box fc
> Dec 26 15:59:48 box ff
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 44
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box c7
> Dec 26 15:59:48 box 44
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 04
> Dec 26 15:59:48 box 04
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 54
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 1c
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 14
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box e8
> Dec 26 15:59:48 box b9
> Dec 26 15:59:48 box a9
> Dec 26 15:59:48 box fc
> Dec 26 15:59:48 box ff
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box b9
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 04
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box c7
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 74
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box f3>
> Dec 26 15:59:48 box a5
> Dec 26 15:59:48 box c7
> Dec 26 15:59:48 box 44
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 04
> Dec 26 15:59:48 box 03
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 44
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 04
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box e8
> Dec 26 15:59:48 box 2a
> Dec 26 15:59:48 box aa
> Dec 26 15:59:48 box fc
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.962884] EIP: [<c0149018>]
> Dec 26 15:59:48 box do_wp_page+0xec/0x431
> Dec 26 15:59:48 box  SS:ESP 0068:f7b8bed4
> Dec 26 15:59:48 box [   13.963041]
> Dec 26 15:59:48 box note: udevd[560] exited with preempt_count 2
> Dec 26 15:59:48 box [   13.963925] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   13.963997] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   13.964061] invalid opcode: 0000 [#2]
> Dec 26 15:59:48 box [   13.964114] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.964254] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.964367] CPU:    0
> Dec 26 15:59:48 box [   13.964368] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   13.964372] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   13.964534] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   13.964596] eax: 7f9e7163   ebx: fffff000   ecx: c1ff7400   edx: c0003ee0
> Dec 26 15:59:48 box [   13.964664] esi: 00000004   edi: 00000000   ebp: c1ff2860   esp: f7457ec8
> Dec 26 15:59:48 box [   13.964731] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   13.964789] Process udevd (pid: 555, ti=f7456000 task=c21b4a90 task.ti=f7456000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.964850] Stack:
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box f7bc2918
> Dec 26 15:59:48 box c014900b
> Dec 26 15:59:48 box c1ff7400
> Dec 26 15:59:48 box 00000004
> Dec 26 15:59:48 box 7f943065
> Dec 26 15:59:48 box fffb9000
> Dec 26 15:59:48 box b7e4617c
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.965343]
> Dec 26 15:59:48 box f7bc3da0
> Dec 26 15:59:48 box f7b84ac0
> Dec 26 15:59:48 box c1ff7400
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box f7bc2918
> Dec 26 15:59:48 box f7beab7c
> Dec 26 15:59:48 box f7b84b08
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.965790]
> Dec 26 15:59:48 box 00000007
> Dec 26 15:59:48 box c014a740
> Dec 26 15:59:48 box f7bc2918
> Dec 26 15:59:48 box f7beab7c
> Dec 26 15:59:48 box f7b84b08
> Dec 26 15:59:48 box 7f943065
> Dec 26 15:59:48 box c016c06c
> Dec 26 15:59:48 box c21334ac
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.966286] Call Trace:
> Dec 26 15:59:48 box [   13.966401]  [<c014900b>]
> Dec 26 15:59:48 box do_wp_page+0xdf/0x431
> Dec 26 15:59:48 box [   13.966513]  [<c014a740>]
> Dec 26 15:59:48 box __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box [   13.966617]  [<c016c06c>]
> Dec 26 15:59:48 box dentry_iput+0x6b/0xba
> Dec 26 15:59:48 box [   13.966720]  [<c0171023>]
> Dec 26 15:59:48 box mntput_no_expire+0x1c/0x7d
> Dec 26 15:59:48 box [   13.966836]  [<c015ca17>]
> Dec 26 15:59:48 box __fput+0x174/0x1c2
> Dec 26 15:59:48 box [   13.966938]  [<c0112ffa>]
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   13.967038]  [<c0112b5f>]
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   13.967152]  [<c03f1699>]
> Dec 26 15:59:48 box error_code+0x39/0x40
> Dec 26 15:59:48 box [   13.967265]  [<c03f007b>]
> Dec 26 15:59:48 box schedule_timeout+0xa5/0xb0
> Dec 26 15:59:48 box [   13.967383]  =======================
> Dec 26 15:59:48 box [   13.967450] Code:
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c2
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 02
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box 2b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 80
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e1
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 8d
> Dec 26 15:59:48 box 46
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e0
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box d8
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 2a
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 49
> Dec 26 15:59:48 box 22
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box d5
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 4c
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box e9
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box 03
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.970382] EIP: [<c0113a43>]
> Dec 26 15:59:48 box kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box  SS:ESP 0068:f7457ec8
> Dec 26 15:59:48 box [   13.970545]
> Dec 26 15:59:48 box note: udevd[555] exited with preempt_count 2
> Dec 26 15:59:48 box [   13.971027] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   13.971089] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   13.971148] invalid opcode: 0000 [#3]
> Dec 26 15:59:48 box [   13.971208] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.971356] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.971447] CPU:    0
> Dec 26 15:59:48 box [   13.971449] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   13.971452] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   13.971634] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   13.971696] eax: 7f943163   ebx: fffff000   ecx: c1ff4760   edx: c0003ee4
> Dec 26 15:59:48 box [   13.971756] esi: 00000003   edi: 00000080   ebp: f7e37db8   esp: f7e37ce0
> Dec 26 15:59:48 box [   13.971824] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   13.971895] Process udevd (pid: 522, ti=f7e36000 task=c2155a90 task.ti=f7e36000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.971968] Stack:
> Dec 26 15:59:48 box f7f1d280
> Dec 26 15:59:48 box 00000080
> Dec 26 15:59:48 box c013d03c
> Dec 26 15:59:48 box c1ff4760
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box f7aa42d0
> Dec 26 15:59:48 box 00000202
> Dec 26 15:59:48 box 00000080
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.972437]
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c1ff4760
> Dec 26 15:59:48 box f7aa42d0
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c013dac4
> Dec 26 15:59:48 box f7e37db8
> Dec 26 15:59:48 box c1ff4760
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.972894]
> Dec 26 15:59:48 box 00000891
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box f7e37d54
> Dec 26 15:59:48 box f7aa4220
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.973381] Call Trace:
> Dec 26 15:59:48 box [   13.973481]  [<c013d03c>]
> Dec 26 15:59:48 box file_read_actor+0xbb/0xf6
> Dec 26 15:59:48 box [   13.973581]  [<c013dac4>]
> Dec 26 15:59:48 box do_generic_mapping_read+0x2c5/0x52c
> Dec 26 15:59:48 box [   13.973679]  [<c013fe6b>]
> Dec 26 15:59:48 box generic_file_aio_read+0xfb/0x270
> Dec 26 15:59:48 box [   13.973774]  [<c013cf81>]
> Dec 26 15:59:48 box file_read_actor+0x0/0xf6
> Dec 26 15:59:48 box [   13.973871]  [<c024e29e>]
> Dec 26 15:59:48 box xfs_read+0x180/0x3c1
> Dec 26 15:59:48 box [   13.973971]  [<c0164a5d>]
> Dec 26 15:59:48 box __link_path_walk+0x82c/0xda7
> Dec 26 15:59:48 box [   13.974080]  [<c024a738>]
> Dec 26 15:59:48 box xfs_file_aio_read+0x70/0x84
> Dec 26 15:59:48 box [   13.974192]  [<c015b752>]
> Dec 26 15:59:48 box do_sync_read+0xf0/0x126
> Dec 26 15:59:48 box [   13.974302]  [<c012e21e>]
> Dec 26 15:59:48 box autoremove_wake_function+0x0/0x4b
> Dec 26 15:59:48 box [   13.974404]  [<c0115035>]
> Dec 26 15:59:48 box try_to_wake_up+0x40/0x402
> Dec 26 15:59:48 box [   13.974500]  [<c0260652>]
> Dec 26 15:59:48 box __next_cpu+0x22/0x33
> Dec 26 15:59:48 box [   13.974601]  [<c015c031>]
> Dec 26 15:59:48 box vfs_read+0x9d/0x17b
> Dec 26 15:59:48 box [   13.974714]  [<c015f8de>]
> Dec 26 15:59:48 box kernel_read+0x49/0x59
> Dec 26 15:59:48 box [   13.974820]  [<c015f9ad>]
> Dec 26 15:59:48 box prepare_binprm+0xbf/0xf0
> Dec 26 15:59:48 box [   13.974923]  [<c016107b>]
> Dec 26 15:59:48 box do_execve+0xec/0x1dc
> Dec 26 15:59:48 box [   13.975019]  [<c010135b>]
> Dec 26 15:59:48 box sys_execve+0x3c/0x97
> Dec 26 15:59:48 box [   13.975117]  [<c0103003>]
> Dec 26 15:59:48 box syscall_call+0x7/0xb
> Dec 26 15:59:48 box [   13.975234]  [<c03f007b>]
> Dec 26 15:59:48 box schedule_timeout+0xa5/0xb0
> Dec 26 15:59:48 box [   13.975345]  =======================
> Dec 26 15:59:48 box [   13.975401] Code:
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c2
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 02
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box 2b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 80
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e1
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 8d
> Dec 26 15:59:48 box 46
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e0
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box d8
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 2a
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 49
> Dec 26 15:59:48 box 22
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box d5
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 4c
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box e9
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box 03
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.978193] EIP: [<c0113a43>]
> Dec 26 15:59:48 box kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box note: udevd[522] exited with preempt_count 1
> Dec 26 15:59:48 box [   13.978847] ------------[ cut here ]------------
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.979481] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box c0141f9a
> Dec 26 15:59:48 box c046bd80
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   13.981214] Call Trace:
> Dec 26 15:59:48 box [   13.982205]  [<c0141f9a>]
> Dec 26 15:59:48 box __alloc_pages+0x4f/0x2db
> Dec 26 15:59:48 box [   13.982756]  [<c0112b5f>]
> Dec 26 15:59:48 box [   13.982985]  =======================
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box 80
> Dec 26 15:59:48 box e1
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 4c
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box [   13.986129]
> Dec 26 15:59:48 box note: scsi_id[503] exited with preempt_count 1
> Dec 26 15:59:48 box [   13.986580] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   13.986947] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   13.987317] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box c013d03c
> Dec 26 15:59:48 box 00000080
> Dec 26 15:59:48 box c1ff37c0
> Dec 26 15:59:48 box f740bd54
> Dec 26 15:59:48 box [   13.988878]  [<c013d03c>]
> Dec 26 15:59:48 box do_generic_mapping_read+0x2c5/0x52c
> Dec 26 15:59:48 box xfs_read+0x180/0x3c1
> Dec 26 15:59:48 box [   13.989838]  [<c012e21e>]
> Dec 26 15:59:48 box sched_balance_self+0x13b/0x2e3
> Dec 26 15:59:48 box [   13.990457]  [<c016107b>]
> Dec 26 15:59:48 box syscall_call+0x7/0xb
> Dec 26 15:59:48 box c2
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box note: udevd[534] exited with preempt_count 1
> Dec 26 15:59:48 box [   13.994411] ------------[ cut here ]------------
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box [   14.035590]
> Dec 26 15:59:48 box [   14.036042] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.036206] PREEMPT
> Dec 26 15:59:48 box [   14.036449] CPU:    0
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box c0148ff3
> Dec 26 15:59:48 box 0805f794
> Dec 26 15:59:48 box f7417080
> Dec 26 15:59:48 box f7b84248
> Dec 26 15:59:48 box [   14.038497]  [<c014a740>]
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box e1
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box [   14.042223]
> Dec 26 15:59:48 box [   14.042667] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.042856] PREEMPT
> Dec 26 15:59:48 box [   14.043120] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.043476] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box c1ff1d80
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box f7b08080
> Dec 26 15:59:48 box c014a740
> Dec 26 15:59:48 box [   14.045003] Call Trace:
> Dec 26 15:59:48 box [   14.045341]  [<c0106aa9>]
> Dec 26 15:59:48 box error_code+0x39/0x40
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 8d
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box note: udevd[474] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.049495] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.049551] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.050516] invalid opcode: 0000 [#13]
> Dec 26 15:59:48 box [   14.050573] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box [   14.050833] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.051183] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box c046bd80
> Dec 26 15:59:48 box [   14.052157]
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box [   14.052822]  [<c01420fb>]
> Dec 26 15:59:48 box [   14.053047]  [<c03ef1ec>]
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.053672]  [<c012e269>]
> Dec 26 15:59:48 box file_read_actor+0x0/0xf6
> Dec 26 15:59:48 box [   14.054299]  [<c024a738>]
> Dec 26 15:59:48 box vfs_read+0x9d/0x17b
> Dec 26 15:59:48 box [   14.054931]  [<c03f007b>]
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box note: udevd[518] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.058569] ------------[ cut here ]------------
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.059035] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box [   14.059997]
> Dec 26 15:59:48 box [   14.060465]
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.061279]  [<c02652f8>]
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.061926]  [<c03ef9c0>]
> Dec 26 15:59:48 box [   14.062146]  [<c013dac4>]
> Dec 26 15:59:48 box get_unused_fd+0xbe/0xcf
> Dec 26 15:59:48 box [   14.063032]  [<c015c031>]
> Dec 26 15:59:48 box syscall_call+0x7/0xb
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 2b
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 49
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box note: udevd[488] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.068364] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.068432] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.068492] invalid opcode: 0000 [#15]
> Dec 26 15:59:48 box [   14.068555] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.068808] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.069161] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box fffb9000
> Dec 26 15:59:48 box c1ff5ca0
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box 00000db2
> Dec 26 15:59:48 box __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.071491]  [<c0117c25>]
> Dec 26 15:59:48 box [   14.071767] Code:
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box d8
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box [   14.074634] EIP: [<c0113a43>]
> Dec 26 15:59:48 box note: S03udev[632] exited with preempt_count 2
> Dec 26 15:59:48 box [   14.076251] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.076333] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.076399] invalid opcode: 0000 [#16]
> Dec 26 15:59:48 box [   14.076465] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box [   14.076615] Modules linked in:
> Dec 26 15:59:48 box [   14.077088] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.077205] Stack:
> Dec 26 15:59:48 box f7a3f160
> Dec 26 15:59:48 box f7e83dd0
> Dec 26 15:59:48 box [   14.078163]
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.078858]  [<c013dac4>]
> Dec 26 15:59:48 box [   14.079088]  [<c013cf81>]
> Dec 26 15:59:48 box [   14.079511]  [<c015b752>]
> Dec 26 15:59:48 box autoremove_wake_function+0x0/0x4b
> Dec 26 15:59:48 box sys_read+0x4b/0x74
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box 00000080
> Dec 26 15:59:48 box f7b7eed0
> Dec 26 15:59:48 box 00001000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box do_generic_mapping_read+0x2c5/0x52c
> Dec 26 15:59:48 box xfs_read+0x180/0x3c1
> Dec 26 15:59:48 box do_sync_read+0xf0/0x126
> Dec 26 15:59:48 box [   14.097192]  [<c015c031>]
> Dec 26 15:59:48 box prepare_binprm+0xbf/0xf0
> Dec 26 15:59:48 box [   14.097817]  [<c03f007b>]
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box 2b
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box note: udevd[497] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.101348] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.101407] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.101781] CPU:    0
> Dec 26 15:59:48 box [   14.102144] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box f7b77174
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box c014a740
> Dec 26 15:59:48 box c224fa90
> Dec 26 15:59:48 box [   14.104054]  [<c011d94e>]
> Dec 26 15:59:48 box [   14.104285]  [<c0112b5f>]
> Dec 26 15:59:48 box [   14.104689] Code:
> Dec 26 15:59:48 box 02
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box e9
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box note: udevd[494] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.108249] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.108721] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.109013] esi: 00000003   edi: 00000080   ebp: f7b8fdb8   esp: f7b8fce0
> Dec 26 15:59:48 box c013d03c
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box f7b8fdb8
> Dec 26 15:59:48 box 00000006
> Dec 26 15:59:48 box [   14.110608] Call Trace:
> Dec 26 15:59:48 box generic_file_aio_read+0xfb/0x270
> Dec 26 15:59:48 box [   14.111271]  [<c0164a5d>]
> Dec 26 15:59:48 box autoremove_wake_function+0x0/0x4b
> Dec 26 15:59:48 box [   14.111881]  [<c015c031>]
> Dec 26 15:59:48 box prepare_binprm+0xbf/0xf0
> Dec 26 15:59:48 box schedule_timeout+0xa5/0xb0
> Dec 26 15:59:48 box c2
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box d5
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.115962] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.116030] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.116373] CPU:    0
> Dec 26 15:59:48 box [   14.116744] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.116857] Stack:
> Dec 26 15:59:48 box 0805b2d0
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c014a740
> Dec 26 15:59:48 box c046a6a0
> Dec 26 15:59:48 box [   14.118469]  [<c02652f8>]
> Dec 26 15:59:48 box memmove+0x3f/0x48
> Dec 26 15:59:48 box [   14.119445]  [<c014a740>]
> Dec 26 15:59:48 box __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box file_free_rcu+0x18/0x1c
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box note: udevd[496] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.123658] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.123994] Modules linked in:
> Dec 26 15:59:48 box [   14.124267] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.124463] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box c1ff47c0
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box [   14.126032] Call Trace:
> Dec 26 15:59:48 box [   14.126356]  [<c013fe6b>]
> Dec 26 15:59:48 box __link_path_walk+0x82c/0xda7
> Dec 26 15:59:48 box [   14.126999]  [<c012e21e>]
> Dec 26 15:59:48 box [   14.127331]  [<c015c031>]
> Dec 26 15:59:48 box prepare_binprm+0xbf/0xf0
> Dec 26 15:59:48 box [   14.127996]  [<c03f007b>]
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box  SS:ESP 0068:f7b97ce0
> Dec 26 15:59:48 box [   14.131704] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.131830] invalid opcode: 0000 [#23]
> Dec 26 15:59:48 box [   14.132078] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.132134] Call Trace:
> Dec 26 15:59:48 box [   14.132145]  [<c012e269>] wake_bit_function+0x0/0x34
> Dec 26 15:59:48 box [   14.132196]  [<c015b752>] do_sync_read+0xf0/0x126
> Dec 26 15:59:48 box [   14.132227]  [<c015f8de>] kernel_read+0x49/0x59
> Dec 26 15:59:48 box [   14.132325]  <6>note: udevd[535] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.132544] PREEMPT SMP
> Dec 26 15:59:48 box [   14.132570] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.132620]  [<c0148ff3>] do_wp_page+0xc7/0x431
> Dec 26 15:59:48 box [   14.132662]  [<c03f1699>] error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.132890] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.132926] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.132962]  [<c013d03c>] file_read_actor+0xbb/0xf6
> Dec 26 15:59:48 box [   14.132996]  [<c0164a5d>] __link_path_walk+0x82c/0xda7
> Dec 26 15:59:48 box [   14.133040]  [<c015f9ad>] prepare_binprm+0xbf/0xf0
> Dec 26 15:59:48 box [   14.133066]  =======================
> Dec 26 15:59:48 box [   14.133124] EIP: [<c0113a43>] kmap_atomic+0x7f/0x94 SS:ESP 0068:f74b1ce0
> Dec 26 15:59:48 box [   14.133276] PREEMPT SMP
> Dec 26 15:59:48 box [   14.133291] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.133327]        00000000 c1ff47c0 f7453d7c 00000000 c013dac4 f7453db8 c1ff47c0 00000000
> Dec 26 15:59:48 box [   14.139180] Call Trace:
> Dec 26 15:59:48 box [   14.139198]  [<c01492b2>] do_wp_page+0x386/0x431
> Dec 26 15:59:48 box [   14.139223]  =======================
> Dec 26 15:59:48 box [   14.139472]  [<c03904dc>] skb_queue_purge+0x1a/0x23
> Dec 26 15:59:48 box [   14.139508]  [<c0161a4b>] pipe_read_release+0x24/0x36
> Dec 26 15:59:48 box [   14.139557]  [<c0104efb>] do_invalid_op+0xab/0xb4
> Dec 26 15:59:48 box [   14.139584]  [<c026007b>] bitmap_parse_user+0x37/0x57
> Dec 26 15:59:48 box [   14.139628]  [<c0103003>] syscall_call+0x7/0xb
> Dec 26 15:59:48 box [   14.139730] PREEMPT SMP
> Dec 26 15:59:48 box [   14.139761] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.135224] Call Trace:
> Dec 26 15:59:48 box [   14.135248]  [<c024e29e>] xfs_read+0x180/0x3c1
> Dec 26 15:59:48 box [   14.135279]  [<c0115035>] try_to_wake_up+0x40/0x402
> Dec 26 15:59:48 box [   14.135405]  <6>note: udevd[639] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.135599] invalid opcode: 0000 [#32]
> Dec 26 15:59:48 box [   14.135675] Call Trace:
> Dec 26 15:59:48 box [   14.135688]  [<c011d94e>] do_wait+0x55a/0xb55
> Dec 26 15:59:48 box [   14.135719]  =======================
> Dec 26 15:59:48 box [   14.135980] PREEMPT SMP
> Dec 26 15:59:48 box [   14.135993] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.136044] Call Trace:
> Dec 26 15:59:48 box [   14.136070]  [<c0112ffa>] do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.136075]  [<c0112b5f>] do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.136080]  [<c03f1699>] error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.136089]  =======================
> Dec 26 15:59:48 box [   14.136289] invalid opcode: 0000 [#34]
> Dec 26 15:59:48 box [   14.136309] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.136366] Call Trace:
> Dec 26 15:59:48 box [   14.136382]  [<c0112b5f>] do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.136432]  [<c014864b>] kmap_high+0x60/0x1f7
> Dec 26 15:59:48 box [   14.136462]  [<c015f60a>] search_binary_handler+0xab/0x266
> Dec 26 15:59:48 box [   14.136550]  <6>note: modprobe[665] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.136648] PREEMPT SMP
> Dec 26 15:59:48 box [   14.136683] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.136730] Call Trace:
> Dec 26 15:59:48 box [   14.136767]  [<c03f1699>] error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.136839]  <6>note: udevd[657] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.136994] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.137051] Call Trace:
> Dec 26 15:59:48 box [   14.137077]  [<c013fe6b>] generic_file_aio_read+0xfb/0x270
> Dec 26 15:59:48 box [   14.137117]  [<c0115035>] try_to_wake_up+0x40/0x402
> Dec 26 15:59:48 box [   14.137145]  [<c010135b>] sys_execve+0x3c/0x97
> Dec 26 15:59:48 box [   14.137396] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.137473] Call Trace:
> Dec 26 15:59:48 box [   14.137475]  [<c0148ff3>] do_wp_page+0xc7/0x431
> Dec 26 15:59:48 box [   14.137504]  [<c03f007b>] schedule_timeout+0xa5/0xb0
> Dec 26 15:59:48 box [   14.137820] invalid opcode: 0000 [#38]
> Dec 26 15:59:48 box [   14.137837] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.137841] eax: 7fe86163   ebx: fffff000   ecx: c1fff060   edx: c0003ee4
> Dec 26 15:59:48 box [   14.137847] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.137870]        00000007 c014a740 f74c0180 f744f080 f741f088 7ff83045 00000280 c2248030
> Dec 26 15:59:48 box [   14.137909]  [<c03f1699>] error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.137965] EIP: [<c0113a43>] kmap_atomic+0x7f/0x94 SS:ESP 0068:f74dbec8
> Dec 26 15:59:48 box [   14.138258] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.138275] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.138321]  [<c014a740>] __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box [   14.138353]  [<c0112b5f>] do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.138622] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.138644] CPU:    0
> Dec 26 15:59:48 box [   14.138710] Call Trace:
> Dec 26 15:59:48 box [   14.138713]  [<c0148ff3>] do_wp_page+0xc7/0x431
> Dec 26 15:59:48 box [   14.138754]  =======================
> Dec 26 15:59:48 box [   14.139107] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.139127] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.139180] Call Trace:
> Dec 26 15:59:48 box [   14.139204]  [<c012e21e>] autoremove_wake_function+0x0/0x4b
> Dec 26 15:59:48 box [   14.139288]  <6>note: udevd[465] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.139489]  [<c03f03d5>] __mutex_lock_slowpath+0x50/0x89
> Dec 26 15:59:48 box [   14.139553]  [<c0104e50>] do_invalid_op+0x0/0xb4
> Dec 26 15:59:48 box [   14.139578]  [<c03f1699>] error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.139624]  [<c015c5a8>] sys_write+0x4b/0x74
> Dec 26 15:59:48 box [   14.139737] CPU:    0
> Dec 26 15:59:48 box [   14.139761] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.139804] Call Trace:
> Dec 26 15:59:48 box [   14.139807]  [<c0148ff3>] do_wp_page+0xc7/0x431
> Dec 26 15:59:48 box [   14.139812]  [<c014a740>] __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box [   14.139823]  [<c015ca17>] __fput+0x174/0x1c2
> Dec 26 15:59:48 box [   14.139852]  =======================
> Dec 26 15:59:48 box [   14.140230] PREEMPT SMP
> Dec 26 15:59:48 box [   14.140261] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.140303] Call Trace:
> Dec 26 15:59:48 box [   14.140325]  [<c0112ffa>] do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.140412]  <6>note: udevd[656] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.140621] Modules linked in:
> Dec 26 15:59:48 box [   14.140644] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.140684] Call Trace:
> Dec 26 15:59:48 box [   14.140713]  [<c0112b5f>] do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.140978] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.140994] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.141051] Call Trace:
> Dec 26 15:59:48 box [   14.141076]  [<c0112ffa>] do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.141158]  <6>note: udevd[654] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.141911] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.141967] Call Trace:
> Dec 26 15:59:48 box [   14.142009]  [<c0112b5f>] do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.170666] ------------[ cut here ]------------
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box [   14.171329] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.171432] Stack:
> Dec 26 15:59:48 box [   14.171816]
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box get_page_from_freelist+0x299/0x3ab
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.174004]  =======================
> Dec 26 15:59:48 box [   14.174052] Code:
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box note: udevd[495] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.183278] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.183348] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.183407] invalid opcode: 0000 [#48]
> Dec 26 15:59:48 box [   14.183465] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.183605] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.183702] CPU:    0
> Dec 26 15:59:48 box [   14.183703] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.183704] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.183854] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.183905] eax: 7fe86163   ebx: fffff000   ecx: c1ff3fe0   edx: c0003ee4
> Dec 26 15:59:48 box [   14.183958] esi: 00000003   edi: 00000001   ebp: 00000000   esp: f7539e64
> Dec 26 15:59:48 box [   14.184010] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.184060] Process modprobe (pid: 681, ti=f7538000 task=c224ea90 task.ti=f7538000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.184114] Stack:
> Dec 26 15:59:48 box c1ff3fe0
> Dec 26 15:59:48 box c1ff3fe0
> Dec 26 15:59:48 box c0141f9a
> Dec 26 15:59:48 box c1ff3fe0
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box 000001b2
> Dec 26 15:59:48 box c046bc00
> Dec 26 15:59:48 box 000280d2
> Dec 26 15:59:48 box [   14.185342]  [<c0141f9a>]
> Dec 26 15:59:48 box [   14.185695]  [<c0112b5f>]
> Dec 26 15:59:48 box [   14.185955]  =======================
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box  SS:ESP 0068:f7539e64
> Dec 26 15:59:48 box [   14.192143] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.192211] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.192264] invalid opcode: 0000 [#49]
> Dec 26 15:59:48 box [   14.192318] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.192440] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.192529] CPU:    0
> Dec 26 15:59:48 box [   14.192531] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.192533] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.192695] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.192754] eax: 7fe86163   ebx: fffff000   ecx: c1ffbba0   edx: c0003ee4
> Dec 26 15:59:48 box [   14.192871] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box c1ffbba0
> Dec 26 15:59:48 box [   14.193385]
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box get_page_from_freelist+0x299/0x3ab
> Dec 26 15:59:48 box [   14.194689]  [<c0112b5f>]
> Dec 26 15:59:48 box file_read_actor+0x22/0xf6
> Dec 26 15:59:48 box [   14.195304]  [<c0159fff>]
> Dec 26 15:59:48 box [   14.195566]  [<c012e21e>]
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 80
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box  SS:ESP 0068:f7533bb4
> Dec 26 15:59:48 box [   14.211977] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.212045] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.212103] invalid opcode: 0000 [#50]
> Dec 26 15:59:48 box [   14.212159] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.212290] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.212376] CPU:    0
> Dec 26 15:59:48 box [   14.212377] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.212378] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.212527] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.212577] eax: 7fe86163   ebx: fffff000   ecx: c1ff61e0   edx: c0003ee4
> Dec 26 15:59:48 box [   14.212630] esi: 00000003   edi: 00000001   ebp: 00000000   esp: f7535bb4
> Dec 26 15:59:48 box [   14.212683] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.212733] Process modprobe (pid: 679, ti=f7534000 task=c21d6030 task.ti=f7534000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.212786] Stack:
> Dec 26 15:59:48 box c1ff61e0
> Dec 26 15:59:48 box c1ff61e0
> Dec 26 15:59:48 box c0141f9a
> Dec 26 15:59:48 box c1ff61e0
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box 000001b2
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000044
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.213165]
> Dec 26 15:59:48 box c046bd80
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c046bc00
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.213544]
> Dec 26 15:59:48 box 000280d2
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box 00000282
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box f7535c50
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.213923] Call Trace:
> Dec 26 15:59:48 box [   14.214014]  [<c0141f9a>]
> Dec 26 15:59:48 box get_page_from_freelist+0x299/0x3ab
> Dec 26 15:59:48 box __handle_mm_fault+0x83a/0x997
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box do_generic_mapping_read+0x2c5/0x52c
> Dec 26 15:59:48 box get_unused_fd+0xbe/0xcf
> Dec 26 15:59:48 box [   14.215500]  [<c015c534>]
> Dec 26 15:59:48 box [   14.215759]  =======================
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box d8
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box  SS:ESP 0068:f7535bb4
> Dec 26 15:59:48 box [   14.218603] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.218708] invalid opcode: 0000 [#51]
> Dec 26 15:59:48 box [   14.219105] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box f74fe168
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box f74fbcc8
> Dec 26 15:59:48 box __handle_mm_fault+0x6fa/0x997
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 8d
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box [   14.223732]
> Dec 26 15:59:48 box [   14.233317] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.233377] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.233433] invalid opcode: 0000 [#52]
> Dec 26 15:59:48 box [   14.233486] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.233610] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.233696] CPU:    0
> Dec 26 15:59:48 box [   14.233697] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.233698] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.233844] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.233895] eax: 7fe86163   ebx: fffff000   ecx: c1ff5680   edx: c0003ee4
> Dec 26 15:59:48 box [   14.233948] esi: 00000003   edi: 00000001   ebp: 00000000   esp: f7537bb4
> Dec 26 15:59:48 box [   14.234692] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.234742] Process modprobe (pid: 680, ti=f7536000 task=f7476560 task.ti=f7536000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.234796] Stack:
> Dec 26 15:59:48 box c1ff5680
> Dec 26 15:59:48 box c1ff5680
> Dec 26 15:59:48 box c0141f9a
> Dec 26 15:59:48 box c1ff5680
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box 000001b2
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000044
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.235175]
> Dec 26 15:59:48 box c046bd80
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c046bc00
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.235552]
> Dec 26 15:59:48 box 000280d2
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box [   14.236198]  [<c014a880>]
> Dec 26 15:59:48 box __sched_text_start+0x40c/0xaf3
> Dec 26 15:59:48 box file_read_actor+0x22/0xf6
> Dec 26 15:59:48 box [   14.237192]  [<c0159fff>]
> Dec 26 15:59:48 box [   14.237540]  [<c015c031>]
> Dec 26 15:59:48 box [   14.237798]  [<c03f007b>]
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box e0
> Dec 26 15:59:48 box 2a
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 03
> Dec 26 15:59:48 box note: modprobe[680] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.240812] invalid opcode: 0000 [#53]
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.241410] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box c0148ff3
> Dec 26 15:59:48 box c1ff7b60
> Dec 26 15:59:48 box f7b90168
> Dec 26 15:59:48 box do_wp_page+0xc7/0x431
> Dec 26 15:59:48 box [   14.243180]  [<c03f1699>]
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 22
> Dec 26 15:59:48 box e9
> Dec 26 15:59:48 box note: udevd[671] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.265589] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.265643] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.265693] invalid opcode: 0000 [#54]
> Dec 26 15:59:48 box [   14.265742] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.265858] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.265942] CPU:    0
> Dec 26 15:59:48 box [   14.265943] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.265944] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.266092] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.266142] eax: 7fe86163   ebx: fffff000   ecx: c1ff7740   edx: c0003ee4
> Dec 26 15:59:48 box [   14.266195] esi: 00000003   edi: 00000001   ebp: 00000000   esp: f753bbb4
> Dec 26 15:59:48 box [   14.266247] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.266297] Process modprobe (pid: 682, ti=f753a000 task=f7476a90 task.ti=f753a000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.266350] Stack:
> Dec 26 15:59:48 box c1ff7740
> Dec 26 15:59:48 box c1ff7740
> Dec 26 15:59:48 box c0141f9a
> Dec 26 15:59:48 box c1ff7740
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box 000001b2
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000044
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.266728]
> Dec 26 15:59:48 box c046bd80
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c046bc00
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.267106]
> Dec 26 15:59:48 box 000280d2
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box 00000282
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c0515324
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.267483] Call Trace:
> Dec 26 15:59:48 box [   14.267574]  [<c0141f9a>]
> Dec 26 15:59:48 box get_page_from_freelist+0x299/0x3ab
> Dec 26 15:59:48 box [   14.267663]  [<c01420fb>]
> Dec 26 15:59:48 box __alloc_pages+0x4f/0x2db
> Dec 26 15:59:48 box [   14.267750]  [<c014a880>]
> Dec 26 15:59:48 box __handle_mm_fault+0x83a/0x997
> Dec 26 15:59:48 box [   14.267839]  [<c03ef1ec>]
> Dec 26 15:59:48 box __sched_text_start+0x40c/0xaf3
> Dec 26 15:59:48 box [   14.267927]  [<c03ef21c>]
> Dec 26 15:59:48 box __sched_text_start+0x43c/0xaf3
> Dec 26 15:59:48 box [   14.268014]  [<c0112ffa>]
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.268102]  [<c0112b5f>]
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.268188]  [<c03f1699>]
> Dec 26 15:59:48 box error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.268274]  [<c013cfa3>]
> Dec 26 15:59:48 box file_read_actor+0x22/0xf6
> Dec 26 15:59:48 box [   14.268362]  [<c012e269>]
> Dec 26 15:59:48 box wake_bit_function+0x0/0x34
> Dec 26 15:59:48 box [   14.268449]  [<c013dac4>]
> Dec 26 15:59:48 box do_generic_mapping_read+0x2c5/0x52c
> Dec 26 15:59:48 box [   14.268538]  [<c013fe6b>]
> Dec 26 15:59:48 box generic_file_aio_read+0xfb/0x270
> Dec 26 15:59:48 box [   14.268625]  [<c013cf81>]
> Dec 26 15:59:48 box file_read_actor+0x0/0xf6
> Dec 26 15:59:48 box [   14.268711]  [<c024e29e>]
> Dec 26 15:59:48 box xfs_read+0x180/0x3c1
> Dec 26 15:59:48 box get_unused_fd+0xbe/0xcf
> Dec 26 15:59:48 box sys_read+0x4b/0x74
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box [   14.442714] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.442774] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.442825] invalid opcode: 0000 [#55]
> Dec 26 15:59:48 box [   14.442874] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.442991] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.443077] CPU:    0
> Dec 26 15:59:48 box [   14.443078] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.443079] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.443228] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.443278] eax: 7fe86163   ebx: fffff000   ecx: c1ff5040   edx: c0003ee4
> Dec 26 15:59:48 box [   14.443332] esi: 00000003   edi: 00000001   ebp: 00000000   esp: f78b3e64
> Dec 26 15:59:48 box [   14.443384] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.443434] Process rc (pid: 377, ti=f78b2000 task=c2155030 task.ti=f78b2000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.443478] Stack:
> Dec 26 15:59:48 box c1ff5040
> Dec 26 15:59:48 box c1ff5040
> Dec 26 15:59:48 box c0141f9a
> Dec 26 15:59:48 box c1ff5040
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box 000001b2
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000044
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.443858]
> Dec 26 15:59:48 box c046bd80
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c046bc00
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000002
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.444236]
> Dec 26 15:59:48 box 000280d2
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box 00000282
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box c046bfa0
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.444616] Call Trace:
> Dec 26 15:59:48 box [   14.444707]  [<c0141f9a>]
> Dec 26 15:59:48 box get_page_from_freelist+0x299/0x3ab
> Dec 26 15:59:48 box [   14.444797]  [<c01420fb>]
> Dec 26 15:59:48 box __alloc_pages+0x4f/0x2db
> Dec 26 15:59:48 box [   14.444883]  [<c015eb7a>]
> Dec 26 15:59:48 box cp_new_stat64+0x103/0x115
> Dec 26 15:59:48 box [   14.444971]  [<c014a880>]
> Dec 26 15:59:48 box __handle_mm_fault+0x83a/0x997
> Dec 26 15:59:48 box [   14.445059]  [<c014d543>]
> Dec 26 15:59:48 box vma_merge+0x136/0x1c5
> Dec 26 15:59:48 box [   14.445146]  [<c014da18>]
> Dec 26 15:59:48 box do_brk+0x17b/0x219
> Dec 26 15:59:48 box [   14.445232]  [<c0112ffa>]
> Dec 26 15:59:48 box do_page_fault+0x49b/0x651
> Dec 26 15:59:48 box [   14.445319]  [<c0112b5f>]
> Dec 26 15:59:48 box do_page_fault+0x0/0x651
> Dec 26 15:59:48 box [   14.445405]  [<c03f1699>]
> Dec 26 15:59:48 box error_code+0x39/0x40
> Dec 26 15:59:48 box [   14.445492]  =======================
> Dec 26 15:59:48 box [   14.445541] Code:
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c2
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 02
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box 2b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 80
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e1
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 8d
> Dec 26 15:59:48 box 46
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e0
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box d8
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 2a
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 49
> Dec 26 15:59:48 box 22
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box d5
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 4c
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box e9
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box 03
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.447903] EIP: [<c0113a43>]
> Dec 26 15:59:48 box kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box  SS:ESP 0068:f78b3e64
> Dec 26 15:59:48 box [   14.448028]
> Dec 26 15:59:48 box note: rc[377] exited with preempt_count 1
> Dec 26 15:59:48 box [   14.448896] ------------[ cut here ]------------
> Dec 26 15:59:48 box [   14.448953] kernel BUG at arch/i386/mm/highmem.c:42!
> Dec 26 15:59:48 box [   14.449004] invalid opcode: 0000 [#56]
> Dec 26 15:59:48 box [   14.449053] PREEMPT
> Dec 26 15:59:48 box SMP
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.449170] Modules linked in:
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.449255] CPU:    0
> Dec 26 15:59:48 box [   14.449256] EIP:    0060:[<c0113a43>]    Not tainted VLI
> Dec 26 15:59:48 box [   14.449257] EFLAGS: 00010206   (2.6.19 #2)
> Dec 26 15:59:48 box [   14.449406] EIP is at kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box [   14.449456] eax: 7fe86163   ebx: fffff000   ecx: c1fff360   edx: c0003ee4
> Dec 26 15:59:48 box [   14.449509] esi: 00000003   edi: 00000180   ebp: c2121e0c   esp: c2121d34
> Dec 26 15:59:48 box [   14.449562] ds: 007b   es: 007b   ss: 0068
> Dec 26 15:59:48 box [   14.449614] Process init (pid: 1, ti=c2120000 task=c211ca90 task.ti=c2120000)
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.449658] Stack:
> Dec 26 15:59:48 box b7f68460
> Dec 26 15:59:48 box 00000180
> Dec 26 15:59:48 box c013d03c
> Dec 26 15:59:48 box c1fff360
> Dec 26 15:59:48 box 00000003
> Dec 26 15:59:48 box c1fff360
> Dec 26 15:59:48 box c01443c5
> Dec 26 15:59:48 box 00000180
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.450036]
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c1fff360
> Dec 26 15:59:48 box c2121dd0
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box c013dac4
> Dec 26 15:59:48 box c2121e0c
> Dec 26 15:59:48 box c1fff360
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.450413]
> Dec 26 15:59:48 box 00001000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box c2121da8
> Dec 26 15:59:48 box f796f820
> Dec 26 15:59:48 box 00000005
> Dec 26 15:59:48 box 00000000
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box 00000001
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.450793] Call Trace:
> Dec 26 15:59:48 box [   14.450884]  [<c013d03c>]
> Dec 26 15:59:48 box file_read_actor+0xbb/0xf6
> Dec 26 15:59:48 box [   14.450973]  [<c01443c5>]
> Dec 26 15:59:48 box activate_page+0x1e/0x99
> Dec 26 15:59:48 box [   14.451060]  [<c013dac4>]
> Dec 26 15:59:48 box do_generic_mapping_read+0x2c5/0x52c
> Dec 26 15:59:48 box [   14.451149]  [<c013fe6b>]
> Dec 26 15:59:48 box generic_file_aio_read+0xfb/0x270
> Dec 26 15:59:48 box [   14.451237]  [<c013cf81>]
> Dec 26 15:59:48 box file_read_actor+0x0/0xf6
> Dec 26 15:59:48 box [   14.452013]  [<c024e29e>]
> Dec 26 15:59:48 box xfs_read+0x180/0x3c1
> Dec 26 15:59:48 box [   14.452100]  [<c0159fff>]
> Dec 26 15:59:48 box get_unused_fd+0xbe/0xcf
> Dec 26 15:59:48 box [   14.452189]  [<c024a738>]
> Dec 26 15:59:48 box xfs_file_aio_read+0x70/0x84
> Dec 26 15:59:48 box [   14.452276]  [<c015b752>]
> Dec 26 15:59:48 box do_sync_read+0xf0/0x126
> Dec 26 15:59:48 box [   14.452362]  [<c0130d01>]
> Dec 26 15:59:48 box enqueue_hrtimer+0x52/0x83
> Dec 26 15:59:48 box [   14.452449]  [<c012e21e>]
> Dec 26 15:59:48 box autoremove_wake_function+0x0/0x4b
> Dec 26 15:59:48 box [   14.452537]  [<c016bc73>]
> Dec 26 15:59:48 box fcntl_setlk+0x44/0x231
> Dec 26 15:59:48 box [   14.452626]  [<c015c031>]
> Dec 26 15:59:48 box vfs_read+0x9d/0x17b
> Dec 26 15:59:48 box [   14.452711]  [<c015c534>]
> Dec 26 15:59:48 box sys_read+0x4b/0x74
> Dec 26 15:59:48 box [   14.452796]  [<c0103003>]
> Dec 26 15:59:48 box syscall_call+0x7/0xb
> Dec 26 15:59:48 box [   14.452882]  =======================
> Dec 26 15:59:48 box [   14.452930] Code:
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c2
> Dec 26 15:59:48 box 8b
> Dec 26 15:59:48 box 02
> Dec 26 15:59:48 box 85
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 75
> Dec 26 15:59:48 box 21
> Dec 26 15:59:48 box 2b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 80
> Dec 26 15:59:48 box 9d
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box f9
> Dec 26 15:59:48 box 05
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e1
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 0d
> Dec 26 15:59:48 box 38
> Dec 26 15:59:48 box 52
> Dec 26 15:59:48 box 51
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 0a
> Dec 26 15:59:48 box 8d
> Dec 26 15:59:48 box 46
> Dec 26 15:59:48 box 43
> Dec 26 15:59:48 box c1
> Dec 26 15:59:48 box e0
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 29
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box d8
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box c3
> Dec 26 15:59:48 box f>
> Dec 26 15:59:48 box 0b
> Dec 26 15:59:48 box 2a
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box 49
> Dec 26 15:59:48 box 22
> Dec 26 15:59:48 box 41
> Dec 26 15:59:48 box c0
> Dec 26 15:59:48 box eb
> Dec 26 15:59:48 box d5
> Dec 26 15:59:48 box 89
> Dec 26 15:59:48 box 4c
> Dec 26 15:59:48 box 24
> Dec 26 15:59:48 box 0c
> Dec 26 15:59:48 box 5b
> Dec 26 15:59:48 box 5e
> Dec 26 15:59:48 box e9
> Dec 26 15:59:48 box 5c
> Dec 26 15:59:48 box 4a
> Dec 26 15:59:48 box 03
> Dec 26 15:59:48 box 00
> Dec 26 15:59:48 box
> Dec 26 15:59:48 box [   14.455288] EIP: [<c0113a43>]
> Dec 26 15:59:48 box kmap_atomic+0x7f/0x94
> Dec 26 15:59:48 box  SS:ESP 0068:c2121d34
> Dec 26 15:59:48 box [   14.455412]
> Dec 26 15:59:48 box Kernel panic - not syncing: Attempted to kill init!
> Dec 26 15:59:49 box [   14.455556]
> 
