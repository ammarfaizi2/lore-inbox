Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUH0Opc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUH0Opc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUH0Opc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:45:32 -0400
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:60038 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id S264991AbUH0Oo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:44:56 -0400
Subject: Re: SMP kernel 2.6 does not work with my network cards. UP kernel
	works nice.
From: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CETUC/PUC-Rio
Message-Id: <1093617410.2633.12.camel@genipapo>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 27 Aug 2004 11:36:50 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois,

Thank you very much for replying so fast and for the patch.
Unfortunately, the problem remains. I can test anything you suggest. I
really don't understand how can this be happening here and nobody else
complains, maybe it's a problem with my hardware? Funny thing is that
all works well in UP. 

Here goes the new log with your patch:

Aug 26 14:44:20 genipapo kernel: Linux version 2.6.8.1 (mroberto@genipapo.ldhs.cetuc.puc-rio.br) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #2 SMP Thu Aug 26 11:15:11 BRT 2004
Aug 26 14:44:20 genipapo kernel: BIOS-provided physical RAM map:
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 26 14:44:20 genipapo kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 26 14:44:20 genipapo kernel: 127MB HIGHMEM available.
Aug 26 14:44:20 genipapo kernel: 896MB LOWMEM available.
Aug 26 14:44:20 genipapo kernel: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Aug 26 14:44:20 genipapo kernel: found SMP MP-table at 000f5610
Aug 26 14:44:20 genipapo syslog: klogd startup succeeded
Aug 26 14:44:20 genipapo kernel: DMI 2.3 present.
Aug 26 14:44:20 genipapo kernel: ACPI: RSDP (v000 VIA694                                    ) @ 0x000f6f60
Aug 26 14:44:20 genipapo kernel: ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
Aug 26 14:44:20 genipapo kernel: ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
Aug 26 14:44:20 genipapo kernel: ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x3fff56c0
Aug 26 14:44:20 genipapo kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Aug 26 14:44:20 genipapo kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 26 14:44:20 genipapo kernel: Processor #0 6:8 APIC version 17
Aug 26 14:44:20 genipapo kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Aug 26 14:44:20 genipapo kernel: Processor #1 6:8 APIC version 17
Aug 26 14:44:20 genipapo kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Aug 26 14:44:20 genipapo kernel: IOAPIC[0]: Assigned apic_id 2
Aug 26 14:44:20 genipapo kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Aug 26 14:44:20 genipapo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug 26 14:44:20 genipapo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Aug 26 14:44:20 genipapo kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug 26 14:44:20 genipapo kernel: Using ACPI (MADT) for SMP configuration information
Aug 26 14:44:20 genipapo kernel: Built 1 zonelists
Aug 26 14:44:20 genipapo kernel: Kernel command line: vga=ext
Aug 26 14:44:20 genipapo kernel: Initializing CPU#0
Aug 26 14:44:20 genipapo kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Aug 26 14:44:20 genipapo kernel: Detected 1134.610 MHz processor.
Aug 26 14:44:20 genipapo kernel: Using tsc for high-res timesource
Aug 26 14:44:20 genipapo kernel: Console: colour VGA+ 80x50
Aug 26 14:44:20 genipapo kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 26 14:44:20 genipapo kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 26 14:44:20 genipapo kernel: Memory: 1035088k/1048512k available (1779k kernel code, 12524k reserved, 848k data, 272k init, 131008k highmem)
Aug 26 14:44:20 genipapo kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug 26 14:44:20 genipapo kernel: Calibrating delay loop... 2228.22 BogoMIPS
Aug 26 14:44:20 genipapo kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 26 14:44:20 genipapo kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 26 14:44:20 genipapo kernel: CPU: L2 cache: 256K
Aug 26 14:44:20 genipapo kernel: CPU serial number disabled.
Aug 26 14:44:20 genipapo kernel: Intel machine check architecture supported.
Aug 26 14:44:20 genipapo kernel: Intel machine check reporting enabled on CPU#0.
Aug 26 14:44:20 genipapo kernel: Enabling fast FPU save and restore... done.
Aug 26 14:44:20 genipapo kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 26 14:44:20 genipapo kernel: Checking 'hlt' instruction... OK.
Aug 26 14:44:20 genipapo kernel: CPU0: Intel Pentium III (Coppermine) stepping 0a
Aug 26 14:44:20 genipapo kernel: per-CPU timeslice cutoff: 731.81 usecs.
Aug 26 14:44:20 genipapo kernel: task migration cache decay timeout: 1 msecs.
Aug 26 14:44:20 genipapo kernel: enabled ExtINT on CPU#0
Aug 26 14:44:20 genipapo kernel: ESR value before enabling vector: 00000000
Aug 26 14:44:20 genipapo kernel: ESR value after enabling vector: 00000000
Aug 26 14:44:20 genipapo kernel: Booting processor 1/1 eip 2000
Aug 26 14:44:20 genipapo kernel: Initializing CPU#1
Aug 26 14:44:20 genipapo kernel: masked ExtINT on CPU#1
Aug 26 14:44:20 genipapo kernel: ESR value before enabling vector: 00000000
Aug 26 14:44:20 genipapo kernel: ESR value after enabling vector: 00000000
Aug 26 14:44:20 genipapo kernel: Calibrating delay loop... 2260.99 BogoMIPS
Aug 26 14:44:20 genipapo kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 26 14:44:20 genipapo kernel: CPU: L2 cache: 256K
Aug 26 14:44:20 genipapo kernel: CPU serial number disabled.
Aug 26 14:44:20 genipapo kernel: Intel machine check architecture supported.
Aug 26 14:44:20 genipapo kernel: Intel machine check reporting enabled on CPU#1.
Aug 26 14:44:20 genipapo kernel: CPU1: Intel Pentium III (Coppermine) stepping 0a
Aug 26 14:44:20 genipapo kernel: Total of 2 processors activated (4489.21 BogoMIPS).
Aug 26 14:44:20 genipapo kernel: ENABLING IO-APIC IRQs
Aug 26 14:44:20 genipapo kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 26 14:44:20 genipapo kernel: Using local APIC timer interrupts.
Aug 26 14:44:20 genipapo kernel: calibrating APIC timer ...
Aug 26 14:44:20 genipapo kernel: ..... CPU clock speed is 1134.0360 MHz.
Aug 26 14:44:20 genipapo kernel: ..... host bus clock speed is 103.0123 MHz.
Aug 26 14:44:20 genipapo kernel: checking TSC synchronization across 2 CPUs: passed.
Aug 26 14:44:20 genipapo kernel: Brought up 2 CPUs
Aug 26 14:44:20 genipapo kernel: NET: Registered protocol family 16
Aug 26 14:44:20 genipapo kernel: EISA bus registered
Aug 26 14:44:20 genipapo kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
Aug 26 14:44:20 genipapo kernel: PCI: Using configuration type 1
Aug 26 14:44:20 genipapo kernel: mtrr: v2.0 (20020519)
Aug 26 14:44:20 genipapo kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Aug 26 14:44:20 genipapo kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Aug 26 14:44:20 genipapo kernel: mtrr: probably your BIOS does not setup all CPUs.
Aug 26 14:44:20 genipapo kernel: mtrr: corrected configuration.
Aug 26 14:44:20 genipapo kernel: ACPI: Subsystem revision 20040326
Aug 26 14:44:20 genipapo kernel: ACPI: Interpreter enabled
Aug 26 14:44:20 genipapo kernel: ACPI: Using IOAPIC for interrupt routing
Aug 26 14:44:20 genipapo kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 26 14:44:20 genipapo kernel: PCI: Probing PCI hardware (bus 00)
Aug 26 14:44:20 genipapo kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Aug 26 14:44:20 genipapo kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Aug 26 14:44:20 genipapo kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 26 14:44:20 genipapo kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 26 14:44:20 genipapo kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 26 14:44:20 genipapo kernel: PCI: Using ACPI for IRQ routing
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 (level, low) -> IRQ 11
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 5 (level, low) -> IRQ 5
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 26 14:44:20 genipapo kernel: testing the IO APIC.......................
Aug 26 14:44:20 genipapo kernel: .................................... done.
Aug 26 14:44:20 genipapo kernel: vesafb: probe of vesafb0 failed with error -6
Aug 26 14:44:20 genipapo kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Aug 26 14:44:20 genipapo kernel: apm: disabled - APM is not SMP safe.
Aug 26 14:44:20 genipapo kernel: Starting balanced_irq
Aug 26 14:44:20 genipapo kernel: highmem bounce pool size: 64 pages
Aug 26 14:44:20 genipapo kernel: VFS: Disk quotas dquot_6.5.1
Aug 26 14:44:20 genipapo kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 26 14:44:20 genipapo kernel: Initializing Cryptographic API
Aug 26 14:44:20 genipapo kernel: PCI: Enabling Via external APIC routing
Aug 26 14:44:20 genipapo kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Aug 26 14:44:20 genipapo kernel: isapnp: Scanning for PnP cards...
Aug 26 14:44:20 genipapo kernel: isapnp: No Plug & Play device found
Aug 26 14:44:20 genipapo kernel: Real Time Clock Driver v1.12
Aug 26 14:44:20 genipapo kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Aug 26 14:44:20 genipapo kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 26 14:44:20 genipapo kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 26 14:44:20 genipapo kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Aug 26 14:44:20 genipapo kernel: VP_IDE: chipset revision 6
Aug 26 14:44:20 genipapo kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 26 14:44:20 genipapo kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Aug 26 14:44:20 genipapo kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Aug 26 14:44:20 genipapo kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
Aug 26 14:44:20 genipapo kernel: hda: Maxtor 4D040H2, ATA DISK drive
Aug 26 14:44:20 genipapo kernel: hdb: ST310232A, ATA DISK drive
Aug 26 14:44:20 genipapo kernel: Using anticipatory io scheduler
Aug 26 14:44:20 genipapo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 26 14:44:20 genipapo kernel: hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
Aug 26 14:44:20 genipapo kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Aug 26 14:44:20 genipapo kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 26 14:44:20 genipapo kernel: hda: max request size: 128KiB
Aug 26 14:44:20 genipapo kernel: hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Aug 26 14:44:20 genipapo kernel:  hda: hda1 hda2 hda3
Aug 26 14:44:20 genipapo kernel: hdb: max request size: 128KiB
Aug 26 14:44:20 genipapo kernel: hdb: 20005650 sectors (10242 MB) w/512KiB Cache, CHS=19846/16/63, UDMA(66)
Aug 26 14:44:20 genipapo kernel:  hdb: hdb1
Aug 26 14:44:20 genipapo kernel: ide-floppy driver 0.99.newide
Aug 26 14:44:20 genipapo kernel: hdd: No disk in drive
Aug 26 14:44:20 genipapo kernel: hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
Aug 26 14:44:20 genipapo kernel: mice: PS/2 mouse device common for all mice
Aug 26 14:44:20 genipapo kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 26 14:44:20 genipapo kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug 26 14:44:20 genipapo kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 26 14:44:20 genipapo kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 26 14:44:20 genipapo kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 26 14:44:20 genipapo kernel: EISA: Probing bus 0 at eisa0
Aug 26 14:44:20 genipapo kernel: NET: Registered protocol family 2
Aug 26 14:44:20 genipapo kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Aug 26 14:44:20 genipapo kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 26 14:44:20 genipapo kernel: NET: Registered protocol family 1
Aug 26 14:44:20 genipapo kernel: NET: Registered protocol family 17
Aug 26 14:44:20 genipapo kernel: NET: Registered protocol family 8
Aug 26 14:44:20 genipapo kernel: NET: Registered protocol family 20
Aug 26 14:44:20 genipapo kernel: ACPI: (supports S0 S1 S4 S5)
Aug 26 14:44:20 genipapo kernel: md: Autodetecting RAID arrays.
Aug 26 14:44:20 genipapo kernel: md: autorun ...
Aug 26 14:44:20 genipapo kernel: md: ... autorun DONE.
Aug 26 14:44:20 genipapo kernel: EXT2-fs warning (device hda2): ext2_fill_super: mounting ext3 filesystem as ext2
Aug 26 14:44:20 genipapo kernel: 
Aug 26 14:44:20 genipapo kernel: VFS: Mounted root (ext2 filesystem) readonly.
Aug 26 14:44:20 genipapo kernel: Freeing unused kernel memory: 272k freed
Aug 26 14:44:20 genipapo kernel: ACPI: Power Button (FF) [PWRF]
Aug 26 14:44:20 genipapo kernel: ACPI: Processor [CPU] (supports C1)
Aug 26 14:44:20 genipapo kernel: ACPI: Processor [CPU1] (supports C1)
Aug 26 14:44:20 genipapo kernel: usbcore: registered new driver usbfs
Aug 26 14:44:20 genipapo kernel: usbcore: registered new driver hub
Aug 26 14:44:20 genipapo kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Aug 26 14:44:20 genipapo kernel: ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
Aug 26 14:44:20 genipapo kernel: ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
Aug 26 14:44:20 genipapo kernel: hdd: No disk in drive
Aug 26 14:44:20 genipapo kernel: Adding 2097136k swap on /dev/hda3.  Priority:-1 extents:1
Aug 26 14:44:20 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 26 14:44:20 genipapo kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Aug 26 14:44:20 genipapo kernel: EXT3 FS on hda1, internal journal
Aug 26 14:44:20 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 26 14:44:20 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 26 14:44:20 genipapo kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Aug 26 14:44:20 genipapo kernel: EXT3 FS on hdb1, internal journal
Aug 26 14:44:20 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 26 14:44:20 genipapo kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Aug 26 14:44:20 genipapo kernel: microcode: CPU0 updated from revision 0x0 to 0x1, date = 11022000 
Aug 26 14:44:20 genipapo kernel: microcode: CPU1 updated from revision 0x0 to 0x1, date = 11022000 
Aug 26 14:44:20 genipapo kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Aug 26 14:44:20 genipapo kernel: parport_pc: Via 686A parallel port: io=0x378
Aug 26 14:44:20 genipapo kernel: SCSI subsystem initialized
Aug 26 14:44:20 genipapo kernel: inserting floppy driver for 2.6.8.1
Aug 26 14:44:20 genipapo kernel: Floppy drive(s): fd0 is 1.44M
Aug 26 14:44:20 genipapo kernel: FDC 0 is a post-1991 82077
Aug 26 14:44:20 genipapo kernel: 8139too Fast Ethernet driver 0.9.27
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
Aug 26 14:44:20 genipapo kernel: eth0: RealTek RTL8139 at 0xe400, 00:00:1c:d9:a7:51, IRQ 11
Aug 26 14:44:20 genipapo kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
Aug 26 14:44:20 genipapo kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 26 14:44:20 genipapo kernel: eth1: VIA Rhine III at 0xdc00, 00:e0:7d:f7:d1:b1, IRQ 10.
Aug 26 14:44:20 genipapo kernel: eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Aug 26 14:44:20 genipapo kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug 26 14:44:20 genipapo kernel: Uniform CD-ROM driver Revision: 3.20
Aug 26 14:44:20 genipapo kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 26 14:44:20 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:44:20 genipapo irqbalance: irqbalance startup succeeded
Aug 26 14:44:21 genipapo rpcidmapd: rpc.idmapd startup succeeded
Aug 26 14:44:21 genipapo random: Initializing random number generator:  succeeded
Aug 26 14:44:17 genipapo sysctl: kernel.sysrq = 1 
Aug 26 14:44:17 genipapo network: Setting network parameters:  succeeded 
Aug 26 14:44:17 genipapo network: Bringing up loopback interface:  succeeded 
Aug 26 14:44:22 genipapo rc: Starting pcmcia:  succeeded
Aug 26 14:44:22 genipapo netfs: Mounting other filesystems:  succeeded
Aug 26 14:44:23 genipapo kernel: NET: Registered protocol family 10
Aug 26 14:44:23 genipapo kernel: IPv6 over IPv4 tunneling driver
Aug 26 14:44:23 genipapo sshd:  succeeded
Aug 26 14:44:23 genipapo xinetd: xinetd startup succeeded
Aug 26 14:44:23 genipapo xinetd[1112]: Server /usr/lib/ppr/lib/lprsrv is not executable [file=/etc/xinetd.d/ppr] [line=12]
Aug 26 14:44:23 genipapo xinetd[1112]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=12]
Aug 26 14:44:23 genipapo xinetd[1112]: bad service attribute: disabled [file=/etc/xinetd.d/ppr] [line=15]
Aug 26 14:44:23 genipapo xinetd[1112]: Unknown user: pprwww [file=/etc/xinetd.d/ppr] [line=24]
Aug 26 14:44:23 genipapo xinetd[1112]: Error parsing attribute user - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=24]
Aug 26 14:44:23 genipapo xinetd[1112]: Server /usr/lib/ppr/lib/ppr-httpd is not executable [file=/etc/xinetd.d/ppr] [line=25]
Aug 26 14:44:23 genipapo xinetd[1112]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=25]
Aug 26 14:44:23 genipapo xinetd[1112]: bad service attribute: disabled [file=/etc/xinetd.d/ppr] [line=27]
Aug 26 14:44:24 genipapo xinetd[1112]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Aug 26 14:44:24 genipapo xinetd[1112]: Started working: 1 available service
Aug 26 14:44:29 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:44:29 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:44:41 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:44:41 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:44:53 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:44:53 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:45:03 genipapo ntpdate[1123]: can't find host clock.redhat.com 
Aug 26 14:45:03 genipapo ntpdate[1123]: no servers can be used, exiting
Aug 26 14:45:03 genipapo ntpd:  failed
Aug 26 14:45:03 genipapo ntpd[1127]: ntpd 4.2.0@1.1161-r Thu Mar 11 11:46:39 EST 2004 (1)
Aug 26 14:45:03 genipapo ntpd: ntpd startup succeeded
Aug 26 14:45:04 genipapo ntpd[1127]: precision = 1.000 usec
Aug 26 14:45:04 genipapo ntpd[1127]: kernel time sync status 0040
Aug 26 14:45:04 genipapo ntpd[1127]: frequency initialized 137.662 PPM from /var/lib/ntp/drift
Aug 26 14:45:04 genipapo ntpd[1127]: configure: keyword "authenticate" unknown, line ignored
Aug 26 14:45:05 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:45:05 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:45:17 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:45:17 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:45:29 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:45:29 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:45:41 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:45:41 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:45:53 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:45:53 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:46:05 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:46:05 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:46:17 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:46:17 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:46:29 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:46:29 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:46:41 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:46:41 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:46:53 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:46:53 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:47:05 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:47:05 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:47:17 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:47:17 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:47:29 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 26 14:47:29 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 26 14:47:30 genipapo shutdown: shutting down for system reboot
Aug 26 14:47:30 genipapo init: Switching to runlevel: 6
Aug 26 14:47:31 genipapo sshd: sshd -TERM succeeded
Aug 26 14:47:31 genipapo xinetd[1112]: Exiting...
Aug 26 14:47:31 genipapo xinetd: xinetd shutdown succeeded
Aug 26 14:47:32 genipapo ntpd[1127]: ntpd exiting on signal 15
Aug 26 14:47:32 genipapo ntpd: ntpd shutdown succeeded
Aug 26 14:47:32 genipapo dd: 1+0 records in
Aug 26 14:47:32 genipapo dd: 1+0 records out
Aug 26 14:47:32 genipapo random: Saving random seed:  succeeded
Aug 26 14:47:32 genipapo kernel: Kernel logging (proc) stopped.
Aug 26 14:47:32 genipapo kernel: Kernel log daemon terminating.
Aug 26 14:47:33 genipapo syslog: klogd shutdown succeeded
Aug 26 14:47:33 genipapo exiting on signal 15


On Wed, 2004-08-25 at 18:13, Francois Romieu wrote:
> Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br> :
> [...]
> > I am currently not able to use the 2.6 SMP kernel, because the network
> > card drivers seem not to be working. UP kernel works fine. I have tried
> > the latest www.kernel.org kernel, and is has the same problem as the
> > latest Fedora Core 2.
> 
> Can you try 2.6.8.1 with the hideous hack below ?
> 
> --- linux-2.6.8.1-mm4.orig/drivers/acpi/pci_irq.c     2004-08-25 23:05:18.000000000 +0200
> +++ linux-2.6.8.1-mm4/drivers/acpi/pci_irq.c  2004-08-25 23:08:03.000000000 +0200
> @@ -360,6 +360,10 @@ acpi_pci_irq_enable (
>        */
>       if (!irq)
>               irq = acpi_pci_irq_derive(dev, pin, &edge_level, &active_high_low);
> +
> +     edge_level = ACPI_LEVEL_SENSITIVE;
> +     active_high_low = ACPI_ACTIVE_LOW;
> +     irq = dev->irq; 
>   
>       /*
>        * No IRQ known to the ACPI subsystem - maybe the BIOS / 

