Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUFUK42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUFUK42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 06:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUFUK42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 06:56:28 -0400
Received: from pop.gmx.de ([213.165.64.20]:1728 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266189AbUFUKsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 06:48:15 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm1
Date: Mon, 21 Jun 2004 12:48:06 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040620174632.74e08e09.akpm@osdl.org>
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nzr1AJG3iRsmzpp"
Message-Id: <200406211248.08190.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nzr1AJG3iRsmzpp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 21 June 2004 02:46, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-m
>m1/

My network does not work with this patch. I have a SiS900 onboard chip. It 
works with 2.6.7 and 2.6.7-bk3 too. All other -mm patches with 2.6.7-rcX 
kernel worked too.
I attached syslog and .config file. Here are the lines which are suspected:
...
Jun 21 12:07:51 debian kernel: NET: Registered protocol family 4
Jun 21 12:07:51 debian pptp[1933]: anon log[main:pptp.c:219]: The synchronous 
pptp option is NOT activated 
Jun 21 12:07:54 debian kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 21 12:07:54 debian kernel: eth0: Transmit timeout, status 00000004 
00000000 
Jun 21 12:07:54 debian kernel: eth0: Media Link On 100mbps full-duplex 
.....

The same .config file works with 2.6.7-bk3!

greets dominik

--Boundary-00=_nzr1AJG3iRsmzpp
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog.txt"

Jun 21 12:07:26 debian kernel: Linux version 2.6.7-mm1 (root@debian) (gcc-Version 3.4.0 20040403 (prerelease) (Debian)) #1 Mon Jun 21 09:57:37 CEST 2004
Jun 21 12:07:26 debian kernel: BIOS-provided physical RAM map:
Jun 21 12:07:26 debian kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jun 21 12:07:26 debian kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jun 21 12:07:26 debian kernel: 0MB HIGHMEM available.
Jun 21 12:07:26 debian kernel: 255MB LOWMEM available.
Jun 21 12:07:26 debian kernel: found SMP MP-table at 000f58e0
Jun 21 12:07:26 debian kernel: On node 0 totalpages: 65520
Jun 21 12:07:26 debian kernel:   DMA zone: 4096 pages, LIFO batch:1
Jun 21 12:07:26 debian kernel:   Normal zone: 61424 pages, LIFO batch:14
Jun 21 12:07:26 debian kernel:   HighMem zone: 0 pages, LIFO batch:1
Jun 21 12:07:26 debian kernel: DMI 2.3 present.
Jun 21 12:07:26 debian kernel: ACPI: RSDP (v000 AWARD                                     ) @ 0x000f72b0
Jun 21 12:07:26 debian kernel: ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
Jun 21 12:07:26 debian kernel: ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
Jun 21 12:07:26 debian kernel: ACPI: MADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff69c0
Jun 21 12:07:26 debian kernel: ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Jun 21 12:07:26 debian kernel: ACPI: PM-Timer IO Port: 0x1008
Jun 21 12:07:26 debian kernel: ACPI: Local APIC address 0xfee00000
Jun 21 12:07:26 debian kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jun 21 12:07:26 debian kernel: Processor #0 15:2 APIC version 20
Jun 21 12:07:26 debian kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jun 21 12:07:26 debian kernel: IOAPIC[0]: Assigned apic_id 2
Jun 21 12:07:26 debian kernel: IOAPIC[0]: apic_id 2, version 20, address 0xfec00000, GSI 0-23
Jun 21 12:07:26 debian kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 21 12:07:26 debian kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Jun 21 12:07:26 debian kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jun 21 12:07:26 debian kernel: Using ACPI (MADT) for SMP configuration information
Jun 21 12:07:26 debian kernel: Built 1 zonelists
Jun 21 12:07:26 debian kernel: Initializing CPU#0
Jun 21 12:07:26 debian kernel: Kernel command line: BOOT_IMAGE=2.6.7-mm1 ro root=30a hda=scsi hdb=scsi hdc=scsi hdd=scsi hde=scsi hdf=scsi hdg=scsi hdh=scsi apm=power-off nomce
Jun 21 12:07:26 debian kernel: ide_setup: hda=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hdb=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hdc=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hdd=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hde=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hdf=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hdg=scsi
Jun 21 12:07:26 debian kernel: ide_setup: hdh=scsi
Jun 21 12:07:26 debian kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jun 21 12:07:26 debian kernel: Detected 2672.867 MHz processor.
Jun 21 12:07:26 debian kernel: Using pmtmr for high-res timesource
Jun 21 12:07:26 debian kernel: Console: colour dummy device 80x25
Jun 21 12:07:26 debian kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jun 21 12:07:26 debian kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun 21 12:07:26 debian kernel: Memory: 255880k/262080k available (1841k kernel code, 5452k reserved, 778k data, 132k init, 0k highmem)
Jun 21 12:07:26 debian kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jun 21 12:07:26 debian kernel: Calibrating delay loop... 5308.41 BogoMIPS
Jun 21 12:07:26 debian kernel: Security Scaffold v1.0.0 initialized
Jun 21 12:07:26 debian kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jun 21 12:07:26 debian kernel: CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
Jun 21 12:07:26 debian kernel: CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
Jun 21 12:07:26 debian kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun 21 12:07:26 debian kernel: CPU: L2 cache: 512K
Jun 21 12:07:26 debian kernel: CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Jun 21 12:07:26 debian kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07
Jun 21 12:07:26 debian kernel: Enabling fast FPU save and restore... done.
Jun 21 12:07:26 debian kernel: Enabling unmasked SIMD FPU exception support... done.
Jun 21 12:07:26 debian kernel: Checking 'hlt' instruction... OK.
Jun 21 12:07:26 debian kernel: enabled ExtINT on CPU#0
Jun 21 12:07:26 debian kernel: ESR value before enabling vector: 00000000
Jun 21 12:07:26 debian kernel: ESR value after enabling vector: 00000000
Jun 21 12:07:26 debian kernel: ENABLING IO-APIC IRQs
Jun 21 12:07:26 debian kernel: init IO_APIC IRQs
Jun 21 12:07:26 debian kernel:  IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jun 21 12:07:26 debian kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jun 21 12:07:26 debian kernel: Using local APIC timer interrupts.
Jun 21 12:07:26 debian kernel: calibrating APIC timer ...
Jun 21 12:07:26 debian kernel: ..... CPU clock speed is 2672.0300 MHz.
Jun 21 12:07:26 debian kernel: ..... host bus clock speed is 133.0614 MHz.
Jun 21 12:07:26 debian kernel: NET: Registered protocol family 16
Jun 21 12:07:26 debian kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb400, last bus=1
Jun 21 12:07:26 debian kernel: PCI: Using configuration type 1
Jun 21 12:07:26 debian kernel: mtrr: v2.0 (20020519)
Jun 21 12:07:26 debian kernel: ACPI: Subsystem revision 20040326
Jun 21 12:07:26 debian kernel: ACPI: Interpreter enabled
Jun 21 12:07:26 debian kernel: ACPI: Using IOAPIC for interrupt routing
Jun 21 12:07:26 debian kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 21 12:07:26 debian kernel: PCI: Probing PCI hardware (bus 00)
Jun 21 12:07:26 debian kernel: Uncovering SIS963 that hid as a SIS503 (compatible=1)
Jun 21 12:07:26 debian kernel: Enabling SiS 96x SMBus.
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *13
Jun 21 12:07:26 debian kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Jun 21 12:07:26 debian kernel: PCI: Using ACPI for IRQ routing
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 17 (level, low) -> IRQ 17
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun 21 12:07:26 debian kernel: number of MP IRQ sources: 18.
Jun 21 12:07:26 debian kernel: number of IO-APIC #2 registers: 24.
Jun 21 12:07:26 debian kernel: testing the IO APIC.......................
Jun 21 12:07:26 debian kernel: IO APIC #2......
Jun 21 12:07:26 debian kernel: .... register #00: 02000000
Jun 21 12:07:26 debian kernel: .......    : physical APIC id: 02
Jun 21 12:07:26 debian kernel: .......    : Delivery Type: 0
Jun 21 12:07:26 debian kernel: .......    : LTS          : 0
Jun 21 12:07:26 debian kernel: .... register #01: 00178014
Jun 21 12:07:26 debian kernel: .......     : max redirection entries: 0017
Jun 21 12:07:26 debian kernel: .......     : PRQ implemented: 1
Jun 21 12:07:26 debian kernel: .......     : IO APIC version: 0014
Jun 21 12:07:26 debian kernel: .... register #02: 02000000
Jun 21 12:07:26 debian kernel: .......     : arbitration: 02
Jun 21 12:07:26 debian kernel: .... IRQ redirection table:
Jun 21 12:07:26 debian kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jun 21 12:07:26 debian kernel:  00 001 01  0    0    0   0   0    1    1    31
Jun 21 12:07:26 debian kernel:  01 001 01  0    0    0   0   0    1    1    39
Jun 21 12:07:26 debian kernel:  02 001 01  0    0    0   0   0    1    1    31
Jun 21 12:07:26 debian kernel:  03 001 01  0    0    0   0   0    1    1    41
Jun 21 12:07:26 debian kernel:  04 001 01  0    0    0   0   0    1    1    49
Jun 21 12:07:26 debian kernel:  05 001 01  0    0    0   0   0    1    1    51
Jun 21 12:07:26 debian kernel:  06 001 01  0    0    0   0   0    1    1    59
Jun 21 12:07:26 debian kernel:  07 001 01  0    0    0   0   0    1    1    61
Jun 21 12:07:26 debian kernel:  08 001 01  0    0    0   0   0    1    1    69
Jun 21 12:07:26 debian kernel:  09 001 01  0    1    0   1   0    1    1    71
Jun 21 12:07:26 debian kernel:  0a 001 01  0    0    0   0   0    1    1    79
Jun 21 12:07:26 debian kernel:  0b 001 01  0    0    0   0   0    1    1    81
Jun 21 12:07:26 debian kernel:  0c 001 01  0    0    0   0   0    1    1    89
Jun 21 12:07:26 debian kernel:  0d 001 01  0    0    0   0   0    1    1    91
Jun 21 12:07:26 debian kernel:  0e 001 01  0    0    0   0   0    1    1    99
Jun 21 12:07:26 debian kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Jun 21 12:07:26 debian kernel:  10 001 01  1    1    0   1   0    1    1    B1
Jun 21 12:07:26 debian kernel:  11 001 01  1    1    0   1   0    1    1    A9
Jun 21 12:07:26 debian kernel:  12 001 01  1    1    0   1   0    1    1    B9
Jun 21 12:07:26 debian kernel:  13 001 01  1    1    0   1   0    1    1    E1
Jun 21 12:07:26 debian kernel:  14 001 01  1    1    0   1   0    1    1    C1
Jun 21 12:07:26 debian kernel:  15 001 01  1    1    0   1   0    1    1    C9
Jun 21 12:07:26 debian kernel:  16 001 01  1    1    0   1   0    1    1    D1
Jun 21 12:07:26 debian kernel:  17 001 01  1    1    0   1   0    1    1    D9
Jun 21 12:07:26 debian kernel: IRQ to pin mappings:
Jun 21 12:07:26 debian kernel: IRQ0 -> 0:0-> 0:2
Jun 21 12:07:26 debian kernel: IRQ1 -> 0:1
Jun 21 12:07:26 debian kernel: IRQ3 -> 0:3
Jun 21 12:07:26 debian kernel: IRQ4 -> 0:4
Jun 21 12:07:26 debian kernel: IRQ5 -> 0:5
Jun 21 12:07:26 debian kernel: IRQ6 -> 0:6
Jun 21 12:07:26 debian kernel: IRQ7 -> 0:7
Jun 21 12:07:26 debian kernel: IRQ8 -> 0:8
Jun 21 12:07:26 debian kernel: IRQ9 -> 0:9
Jun 21 12:07:26 debian kernel: IRQ10 -> 0:10
Jun 21 12:07:26 debian kernel: IRQ11 -> 0:11
Jun 21 12:07:26 debian kernel: IRQ12 -> 0:12
Jun 21 12:07:26 debian kernel: IRQ13 -> 0:13
Jun 21 12:07:26 debian kernel: IRQ14 -> 0:14
Jun 21 12:07:26 debian kernel: IRQ15 -> 0:15
Jun 21 12:07:26 debian kernel: IRQ16 -> 0:16
Jun 21 12:07:26 debian kernel: IRQ17 -> 0:17
Jun 21 12:07:26 debian kernel: IRQ18 -> 0:18
Jun 21 12:07:26 debian kernel: IRQ19 -> 0:19
Jun 21 12:07:26 debian kernel: IRQ20 -> 0:20
Jun 21 12:07:26 debian kernel: IRQ21 -> 0:21
Jun 21 12:07:26 debian kernel: IRQ22 -> 0:22
Jun 21 12:07:26 debian kernel: IRQ23 -> 0:23
Jun 21 12:07:26 debian kernel: .................................... done.
Jun 21 12:07:26 debian kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xd0807000, size 10240k
Jun 21 12:07:26 debian kernel: vesafb: mode is 1280x1024x32, linelength=5120, pages=0
Jun 21 12:07:26 debian kernel: vesafb: protected mode interface info at c000:e2d0
Jun 21 12:07:26 debian kernel: vesafb: scrolling: redraw
Jun 21 12:07:26 debian kernel: vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Jun 21 12:07:26 debian kernel: fb0: VESA VGA frame buffer device
Jun 21 12:07:26 debian kernel: udf: registering filesystem
Jun 21 12:07:26 debian kernel: Initializing Cryptographic API
Jun 21 12:07:26 debian kernel: Console: switching to colour frame buffer device 160x64
Jun 21 12:07:26 debian kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jun 21 12:07:26 debian kernel: agpgart: Detected SiS 648 chipset
Jun 21 12:07:26 debian kernel: agpgart: Maximum main memory to use for agp memory: 203M
Jun 21 12:07:26 debian kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Jun 21 12:07:26 debian kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
Jun 21 12:07:26 debian kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 21 12:07:26 debian kernel: PPP generic driver version 2.4.2
Jun 21 12:07:26 debian kernel: PPP Deflate Compression module registered
Jun 21 12:07:26 debian kernel: PPP BSD Compression module registered
Jun 21 12:07:26 debian kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 21 12:07:26 debian kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 21 12:07:26 debian kernel: SIS5513: IDE controller at PCI slot 0000:00:02.5
Jun 21 12:07:26 debian kernel: ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
Jun 21 12:07:26 debian kernel: SIS5513: chipset revision 0
Jun 21 12:07:26 debian kernel: SIS5513: not 100%% native mode: will probe irqs later
Jun 21 12:07:26 debian kernel: SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
Jun 21 12:07:26 debian kernel:     ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
Jun 21 12:07:26 debian kernel:     ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio
Jun 21 12:07:26 debian kernel: hda: ST3120023A, ATA DISK drive
Jun 21 12:07:26 debian kernel: hdb: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
Jun 21 12:07:26 debian kernel: Using anticipatory io scheduler
Jun 21 12:07:26 debian kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 21 12:07:26 debian kernel: hdc: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
Jun 21 12:07:26 debian kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 21 12:07:26 debian kernel: hda: max request size: 128KiB
Jun 21 12:07:26 debian kernel: hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jun 21 12:07:26 debian kernel: hda: cache flushes supported
Jun 21 12:07:26 debian kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
Jun 21 12:07:26 debian kernel: ide-cd: passing drive hdb to ide-scsi emulation.
Jun 21 12:07:26 debian kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Jun 21 12:07:26 debian kernel: ide-floppy driver 0.99.newide
Jun 21 12:07:26 debian kernel: ide-cd: passing drive hdb to ide-scsi emulation.
Jun 21 12:07:26 debian kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Jun 21 12:07:26 debian kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 21 12:07:26 debian kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 21 12:07:26 debian kernel: mice: PS/2 mouse device common for all mice
Jun 21 12:07:26 debian kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jun 21 12:07:26 debian kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Jun 21 12:07:26 debian kernel: input: PC Speaker
Jun 21 12:07:26 debian kernel: NET: Registered protocol family 2
Jun 21 12:07:26 debian kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Jun 21 12:07:26 debian kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jun 21 12:07:26 debian kernel: IPv4 over IPv4 tunneling driver
Jun 21 12:07:26 debian kernel: GRE over IPv4 tunneling driver
Jun 21 12:07:26 debian kernel: Initializing IPsec netlink socket
Jun 21 12:07:26 debian kernel: NET: Registered protocol family 1
Jun 21 12:07:26 debian kernel: NET: Registered protocol family 17
Jun 21 12:07:26 debian kernel: ACPI: (supports S0 S3 S4 S5)
Jun 21 12:07:26 debian kernel: kjournald starting.  Commit interval 5 seconds
Jun 21 12:07:26 debian kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 21 12:07:26 debian kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jun 21 12:07:26 debian kernel: Freeing unused kernel memory: 132k freed
Jun 21 12:07:26 debian kernel: SCSI subsystem initialized
Jun 21 12:07:26 debian kernel: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Jun 21 12:07:26 debian kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Jun 21 12:07:26 debian kernel:   Vendor: IDE       Model: DVD-ROM 16X       Rev: 2.05
Jun 21 12:07:26 debian kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jun 21 12:07:26 debian kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Jun 21 12:07:26 debian kernel:   Vendor: SONY      Model: CD-RW  CRX210E1   Rev: 2YS2
Jun 21 12:07:26 debian kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jun 21 12:07:26 debian kernel: hdb: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
Jun 21 12:07:26 debian kernel: ide: failed opcode was 100
Jun 21 12:07:26 debian kernel: hda: dma_timer_expiry: dma status == 0x60
Jun 21 12:07:26 debian kernel: hda: DMA timeout retry
Jun 21 12:07:26 debian kernel: hda: timeout waiting for DMA
Jun 21 12:07:26 debian kernel: Adding 514040k swap on /dev/hda9.  Priority:-1 extents:1
Jun 21 12:07:26 debian kernel: EXT3 FS on hda10, internal journal
Jun 21 12:07:26 debian kernel: warning: process `update' used the obsolete bdflush system call
Jun 21 12:07:26 debian kernel: Fix your initscripts?
Jun 21 12:07:27 debian kernel: ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
Jun 21 12:07:27 debian kernel: ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
Jun 21 12:07:27 debian kernel: ohci1394: fw-host0: Unexpected PCI resource length of 1000!
Jun 21 12:07:27 debian kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[e2427000-e24277ff]  Max Packet=[2048]
Jun 21 12:07:27 debian pci.agent[816]:      ohci1394: loaded sucessfully
Jun 21 12:07:27 debian kernel: ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
Jun 21 12:07:28 debian kernel: intel8x0_measure_ac97_clock: measured 99886 usecs
Jun 21 12:07:28 debian kernel: intel8x0: measured clock 24027 rejected
Jun 21 12:07:28 debian kernel: intel8x0: clocking to 48000
Jun 21 12:07:28 debian pci.agent[886]:      snd-intel8x0: loaded sucessfully
Jun 21 12:07:28 debian kernel: usbcore: registered new driver usbfs
Jun 21 12:07:28 debian kernel: usbcore: registered new driver hub
Jun 21 12:07:28 debian kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jun 21 12:07:28 debian kernel: ohci_hcd: block sizes: ed 64 td 64
Jun 21 12:07:28 debian kernel: ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
Jun 21 12:07:28 debian kernel: ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
Jun 21 12:07:28 debian kernel: ohci_hcd 0000:00:03.0: irq 20, pci mem d12ba000
Jun 21 12:07:28 debian kernel: ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
Jun 21 12:07:28 debian kernel: hub 1-0:1.0: USB hub found
Jun 21 12:07:28 debian kernel: hub 1-0:1.0: 2 ports detected
Jun 21 12:07:28 debian kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000000000]
Jun 21 12:07:28 debian kernel: ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
Jun 21 12:07:28 debian kernel: ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
Jun 21 12:07:28 debian usb.agent[1002]:      usbcore: already loaded
Jun 21 12:07:28 debian kernel: ohci_hcd 0000:00:03.1: irq 21, pci mem d1353000
Jun 21 12:07:29 debian kernel: ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
Jun 21 12:07:29 debian kernel: hub 2-0:1.0: USB hub found
Jun 21 12:07:29 debian kernel: hub 2-0:1.0: 2 ports detected
Jun 21 12:07:29 debian usb.agent[1050]:      usbcore: already loaded
Jun 21 12:07:29 debian kernel: ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
Jun 21 12:07:29 debian kernel: ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
Jun 21 12:07:29 debian kernel: ohci_hcd 0000:00:03.2: irq 22, pci mem d1355000
Jun 21 12:07:29 debian kernel: ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
Jun 21 12:07:29 debian kernel: usb 2-1: new full speed USB device using address 2
Jun 21 12:07:29 debian kernel: hub 3-0:1.0: USB hub found
Jun 21 12:07:29 debian kernel: hub 3-0:1.0: 2 ports detected
Jun 21 12:07:29 debian usb.agent[1090]:      usbcore: already loaded
Jun 21 12:07:30 debian pci.agent[961]:      ohci-hcd: loaded sucessfully
Jun 21 12:07:30 debian kernel: Initializing USB Mass Storage driver...
Jun 21 12:07:30 debian kernel: usb 3-1: new full speed USB device using address 2
Jun 21 12:07:30 debian kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Jun 21 12:07:30 debian pci.agent[1153]:      ohci-hcd: already loaded
Jun 21 12:07:30 debian scsi.agent[1215]: disk at /devices/pci0000:00/0000:00:03.1/usb2/2-1/2-1:1.0/host2/2:0:0:0
Jun 21 12:07:30 debian kernel:   Vendor: Medion    Model: Flash XL      CF  Rev: 2.6D
Jun 21 12:07:30 debian kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 21 12:07:30 debian usb.agent[1125]:      usb-storage: loaded sucessfully
Jun 21 12:07:30 debian kernel: USB Mass Storage device found at 2
Jun 21 12:07:30 debian kernel: usbcore: registered new driver usb-storage
Jun 21 12:07:30 debian kernel: USB Mass Storage support registered.
Jun 21 12:07:30 debian pci.agent[1202]:      ohci-hcd: already loaded
Jun 21 12:07:31 debian usb.agent[1237]:      usblp: loaded sucessfully
Jun 21 12:07:31 debian kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7004
Jun 21 12:07:31 debian kernel: usbcore: registered new driver usblp
Jun 21 12:07:31 debian kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Jun 21 12:07:31 debian kernel: ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
Jun 21 12:07:31 debian kernel: ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
Jun 21 12:07:31 debian kernel: ehci_hcd 0000:00:03.3: irq 23, pci mem d1357000
Jun 21 12:07:31 debian kernel: ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
Jun 21 12:07:31 debian kernel: PCI: cache line size of 128 is not supported by device 0000:00:03.3
Jun 21 12:07:31 debian kernel: ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Jun 21 12:07:31 debian kernel: usb 2-1: USB disconnect, address 2
Jun 21 12:07:31 debian kernel: hub 4-0:1.0: USB hub found
Jun 21 12:07:31 debian kernel: hub 4-0:1.0: 6 ports detected
Jun 21 12:07:31 debian pci.agent[1302]:      ehci-hcd: loaded sucessfully
Jun 21 12:07:31 debian usb.agent[1370]:      usbcore: already loaded
Jun 21 12:07:31 debian kernel: usb 3-1: USB disconnect, address 2
Jun 21 12:07:31 debian kernel: drivers/usb/class/usblp.c: usblp0: removed
Jun 21 12:07:32 debian kernel: sis900.c: v1.08.07 11/02/2003
Jun 21 12:07:32 debian kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 0.
Jun 21 12:07:32 debian kernel: eth0: Realtek RTL8201 PHY transceiver found at address 1.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 2.
Jun 21 12:07:32 debian net.agent[1463]: Setting up IP spoofing protection: rp_filter.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 3.
Jun 21 12:07:32 debian kernel: ohci_hcd 0000:00:03.1: remote wakeup
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 4.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 5.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 6.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 7.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 8.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 9.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 10.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 11.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 12.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 13.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 14.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 15.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 16.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 17.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 18.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 19.
Jun 21 12:07:32 debian kernel: ohci_hcd 0000:00:03.2: remote wakeup
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 20.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 21.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 22.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 23.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 24.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 25.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 26.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 27.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 28.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 29.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 30.
Jun 21 12:07:32 debian kernel: eth0: Unknown PHY transceiver found at address 31.
Jun 21 12:07:32 debian kernel: usb 2-1: new full speed USB device using address 3
Jun 21 12:07:32 debian kernel: eth0: Using transceiver found at address 1 as default
Jun 21 12:07:32 debian kernel: eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:af:b9:cc.
Jun 21 12:07:32 debian pci.agent[1414]:      sis900: loaded sucessfully
Jun 21 12:07:33 debian kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Jun 21 12:07:33 debian kernel:   Vendor: Medion    Model: Flash XL      CF  Rev: 2.6D
Jun 21 12:07:33 debian usb.agent[1494]:      usb-storage: already loaded
Jun 21 12:07:33 debian kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 21 12:07:33 debian kernel: USB Mass Storage device found at 3
Jun 21 12:07:33 debian kernel: 8139too Fast Ethernet driver 0.9.27
Jun 21 12:07:33 debian kernel: ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
Jun 21 12:07:33 debian net.agent[1571]: Setting up IP spoofing protection: rp_filter.
Jun 21 12:07:33 debian kernel: eth1: RealTek RTL8139 at 0xd1359000, 00:50:fc:2d:9a:5c, IRQ 18
Jun 21 12:07:33 debian kernel: eth1:  Identified 8139 chip type 'RTL-8139C'
Jun 21 12:07:33 debian pci.agent[1523]:      8139too: loaded sucessfully
Jun 21 12:07:33 debian kernel: usb 3-1: new full speed USB device using address 3
Jun 21 12:07:33 debian usb.agent[1632]:      usblp: already loaded
Jun 21 12:07:33 debian kernel: Linux video capture interface: v1.00
Jun 21 12:07:34 debian kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7004
Jun 21 12:07:34 debian kernel: saa7130/34: v4l2 driver version 0.2.12 loaded
Jun 21 12:07:34 debian kernel: ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
Jun 21 12:07:34 debian kernel: saa7134[0]: found at 0000:00:08.0, rev: 1, irq: 19, latency: 32, mmio: 0xe2426000
Jun 21 12:07:34 debian kernel: saa7134[0]: subsystem: 16be:0003, board: Medion 7134 [card=12,autodetected]
Jun 21 12:07:34 debian kernel: saa7134[0]: board init: gpio is 0
Jun 21 12:07:34 debian kernel: saa7134[0]: i2c eeprom 00: be 16 03 00 08 20 1c 55 43 43 a9 1c 55 43 43 a9
Jun 21 12:07:34 debian kernel: saa7134[0]: i2c eeprom 10: ff ff ff ff 15 00 0e 01 0c c0 08 00 00 00 00 00
Jun 21 12:07:34 debian kernel: saa7134[0]: i2c eeprom 20: 00 00 00 e3 ff ff ff ff ff ff ff ff ff ff ff ff
Jun 21 12:07:34 debian kernel: saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jun 21 12:07:34 debian kernel: tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
Jun 21 12:07:34 debian kernel: tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
Jun 21 12:07:34 debian kernel: tda9885/6/7: chip found @ 0x86
Jun 21 12:07:34 debian kernel: saa7134[0]: registered device video0 [v4l2]
Jun 21 12:07:34 debian scsi.agent[1555]: disk at /devices/pci0000:00/0000:00:03.1/usb2/2-1/2-1:1.0/host3/3:0:0:0
Jun 21 12:07:34 debian kernel: saa7134[0]: registered device vbi0
Jun 21 12:07:34 debian kernel: saa7134[0]: registered device radio0
Jun 21 12:07:34 debian pci.agent[1601]:      saa7134: loaded sucessfully
Jun 21 12:07:34 debian pci.rc[720]:      ignore pci display device on 01:00.0
Jun 21 12:07:37 debian pumpd[458]: PUMP: sending discover 
Jun 21 12:07:42 debian kernel: eth0: Media Link On 100mbps full-duplex 
Jun 21 12:07:50 debian pumpd[458]: got dhcp offer 
Jun 21 12:07:50 debian pumpd[458]: PUMP: sending second discover
Jun 21 12:07:50 debian pumpd[458]: PUMP: got an offer
Jun 21 12:07:50 debian pumpd[458]: PUMP: got lease
Jun 21 12:07:50 debian pumpd[458]: intf: device: eth0
Jun 21 12:07:50 debian pumpd[458]: intf: set: 416
Jun 21 12:07:50 debian pumpd[458]: intf: bootServer: 193.170.62.146
Jun 21 12:07:50 debian pumpd[458]: intf: reqLease: 43200
Jun 21 12:07:50 debian pumpd[458]: intf: ip: 172.16.1.62
Jun 21 12:07:50 debian pumpd[458]: intf: next server: 193.170.62.146
Jun 21 12:07:50 debian pumpd[458]: intf: netmask: 255.255.0.0
Jun 21 12:07:50 debian pumpd[458]: intf: dnsServers[0]: 172.16.0.1
Jun 21 12:07:50 debian pumpd[458]: intf: numDns: 1
Jun 21 12:07:50 debian pumpd[458]: intf: domain: vpn.gateway.net.de
Jun 21 12:07:50 debian pumpd[458]: intf: broadcast: 172.16.255.255
Jun 21 12:07:50 debian pumpd[458]: intf: network: 172.16.0.0
Jun 21 12:07:50 debian pumpd[458]: configured interface eth0
Jun 21 12:07:50 debian kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Jun 21 12:07:50 debian kernel: apm: overridden by ACPI.
Jun 21 12:07:50 debian modprobe: FATAL: Error inserting apm (/lib/modules/2.6.7-mm1/kernel/arch/i386/kernel/apm.ko): No such device 
Jun 21 12:07:50 debian automount[1909]: starting automounter version 4.0.0, path = /mnt/auto, maptype = program, mapname = /etc/automount.sh
Jun 21 12:07:50 debian automount[1909]: Map argc = 1
Jun 21 12:07:50 debian automount[1909]: Map argv[0] = /etc/automount.sh
Jun 21 12:07:51 debian automount[1909]: mount(bind): bind_works = 1 
Jun 21 12:07:51 debian automount[1909]: using kernel protocol version 4
Jun 21 12:07:51 debian automount[1909]: using timeout 2 seconds; freq 1 secs
Jun 21 12:07:51 debian kernel: NET: Registered protocol family 4
Jun 21 12:07:51 debian pptp[1933]: anon log[main:pptp.c:219]: The synchronous pptp option is NOT activated 
Jun 21 12:07:54 debian kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 21 12:07:54 debian kernel: eth0: Transmit timeout, status 00000004 00000000 
Jun 21 12:07:54 debian kernel: eth0: Media Link On 100mbps full-duplex 
Jun 21 12:07:54 debian pptp[1935]: anon warn[open_inetsock:pptp_callmgr.c:312]: connect: No route to host
Jun 21 12:07:54 debian pptp[1935]: anon fatal[callmgr_main:pptp_callmgr.c:121]: Could not open control connection to 172.16.0.1
Jun 21 12:07:54 debian pptp[1934]: anon fatal[open_callmgr:pptp.c:379]: Call manager exited with error 256
Jun 21 12:09:47 debian init: Switching to runlevel: 6
Jun 21 12:09:50 debian kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Jun 21 12:09:50 debian kernel: apm: overridden by ACPI.

--Boundary-00=_nzr1AJG3iRsmzpp
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.7-mm1.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-mm1.config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_RAWIO is not set
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_IPRANGE is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
# CONFIG_IP_NF_MATCH_STATE is not set
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
# CONFIG_IP_NF_TARGET_REJECT is not set
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
CONFIG_IP_NF_ARPTABLES=m
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_ARP_MANGLE is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=m
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
CONFIG_ISDN_I4L=m
# CONFIG_ISDN_PPP is not set
# CONFIG_ISDN_AUDIO is not set

#
# ISDN feature submodules
#
# CONFIG_ISDN_DRV_LOOP is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set

#
# Active cards
#
# CONFIG_ISDN_DRV_TPAM is not set
# CONFIG_HYSDN is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
# CONFIG_ISDN_DRV_AVMB1_B1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_B1PCMCIA is not set
# CONFIG_ISDN_DRV_AVMB1_T1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_C4 is not set

#
# Active Eicon DIVA Server cards
#
# CONFIG_CAPI_EICON is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=10
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=y
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_NOMMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_I810=y
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
CONFIG_VIDEO_SAA7134=m
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_SQUASHFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso8859-15"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_POSIX=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-00=_nzr1AJG3iRsmzpp--
