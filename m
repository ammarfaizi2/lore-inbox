Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752118AbWCJU3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWCJU3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWCJU3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:29:46 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:24582 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP
	id S1752109AbWCJU3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:29:46 -0500
Date: Fri, 10 Mar 2006 21:29:29 +0100
From: jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: shemminger@osdl.org
Subject: skge/sk98lin slowdown with 4 Gb memory compared to 2 Gb memory
Message-ID: <20060310202929.GA7308@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just increased the memory on my A8N-SLI Deluxe from 2 Gb to 4 Gb.

Since then, network connections on my second network card have gone so
slow as to be almost unusable.

Two pc's, each connected over a gigabit switch, each get pings at 2 ms
each packet, where booting with mem=2G immediately fixes that to pings
at 0.2 or 0.1 second each.

This happens in kernel 2.6.16-rc5-mm2, with both the sk98lin and the
skge driver.

Is this a known phenomenon? I can't be the first A8N-SLI user that
increases memory to 4 Gb I hope!

Below is the dmesg output when booting with mem=2G.

I'd love to know how I can fix this, or how I can help others debug
this.

thanks,
Jurriaan

Bootdata ok (command line is root=/dev/md2 mem=2G video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1)
Linux version 2.6.16-rc5-mm2 (jurriaan@middle) (gcc version 4.0.3 20060304 (prerelease) (Debian 4.0.2-10)) #3 Fri Mar 10 20:55:28 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
 BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9900
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9a00
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 515247
  DMA zone: 2167 pages, LIFO batch:0
  DMA32 zone: 513080 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:7 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/md2 mem=2G video=nvidiafb:1600x1200-32@85 atkbd.softrepeat=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2750.021 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2057664k/2097152k available (3808k kernel code, 39012k reserved, 2307k data, 224k init)
Calibrating delay using timer specific routine.. 5503.34 BogoMIPS (lpj=11006697)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3700+ stepping 01
Using local APIC timer interrupts.
result 15625121
Detected 15.625 MHz APIC timer.
testing NMI watchdog ... OK.
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20060210
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
initcall at 0xffffffff807b1d10: late_hpet_init+0x0/0xe0(): returned with error code -1
PCI-DMA: Disabling IOMMU.
initcall at 0xffffffff807baaf0: pci_iommu_init+0x0/0x5a0(): returned with error code -1
PCI: Bridge: 0000:00:09.0
  IO window: 6000-afff
  MEM window: d8000000-d9ffffff
  PREFETCH window: da100000-da1fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: d0000000-d7ffffff
  PREFETCH window: c0000000-cfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
ACPI (acpi_bus-0216): Device 'XVR3' is not power manageable [20060210]
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ACPI (acpi_bus-0216): Device 'XVR2' is not power manageable [20060210]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
ACPI (acpi_bus-0216): Device 'XVR1' is not power manageable [20060210]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ACPI (acpi_bus-0216): Device 'XVR0' is not power manageable [20060210]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.26 [Flags: R/O].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
GSI 16 sharing vector 0xD9 and IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 217
nvidiafb: PCI id - 10de0141
nvidiafb: Actual id - 10de0141
nvidiafb: nVidia device/chipset 10DE0141
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog found
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 160x66
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0xC0000000)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
initcall at 0xffffffff807c4735: hotkey_init+0x0/0x21d(): returned with error code -19
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
initcall at 0xffffffff807c6390: rng_init+0x0/0xc0(): returned with error code -19
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 17 sharing vector 0xE1 and IRQ 17
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 225
skge 1.3 addr 0xd9008000 irq 225 chip Yukon-Lite rev 9
skge eth0: addr 00:15:f2:20:e6:69
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.52.
ACPI (acpi_bus-0216): Device 'MMAC' is not power manageable [20060210]
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
GSI 18 sharing vector 0xE9 and IRQ 18
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
ACPI (acpi_bus-0216): Device 'IDE0' is not power manageable [20060210]
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD2000JB-32EVA0, ATA DISK drive
hdb: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD2000JB-00FUA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: max request size: 512KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >
hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_sil 0000:05:0a.0: version 0.9
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 19 sharing vector 0x32 and IRQ 19
ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 50
sata_sil 0000:05:0a.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 50
ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 50
ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 50
ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 50
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata3: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata4: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_sil
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_nv 0000:00:07.0: version 0.8
ACPI (acpi_bus-0216): Device 'SAT1' is not power manageable [20060210]
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
GSI 20 sharing vector 0x3A and IRQ 20
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 58
ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 58
ata5: SATA link up 3.0 Gbps (SStatus 123)
ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata5: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata5: dev 0 configured for UDMA/133
scsi4 : sata_nv
ata6: SATA link up 1.5 Gbps (SStatus 113)
ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata6: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata6: dev 0 configured for UDMA/133
scsi5 : sata_nv
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI (acpi_bus-0216): Device 'SAT2' is not power manageable [20060210]
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 21 sharing vector 0x42 and IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 66
ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 66
ata7: SATA link up 3.0 Gbps (SStatus 123)
ata7: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata7: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata7: dev 0 configured for UDMA/133
scsi6 : sata_nv
ata8: SATA link up 1.5 Gbps (SStatus 113)
ata8: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata8: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata8: dev 0 configured for UDMA/133
scsi7 : sata_nv
  Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 586072368 512-byte hdwr sectors (300069 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1 sde2
sd 4:0:0:0: Attached scsi disk sde
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 586072368 512-byte hdwr sectors (300069 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: sdg1 sdg2
sd 6:0:0:0: Attached scsi disk sdg
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
 sdh: sdh1
sd 7:0:0:0: Attached scsi disk sdh
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
sd 4:0:0:0: Attached scsi generic sg4 type 0
sd 5:0:0:0: Attached scsi generic sg5 type 0
sd 6:0:0:0: Attached scsi generic sg6 type 0
sd 7:0:0:0: Attached scsi generic sg7 type 0
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:05:08.2[B] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 50
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[50]  MMIO=[d900d000-d900d7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 22 sharing vector 0x4A and IRQ 22
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 74
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[74]  MMIO=[d900c000-d900c7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
usbmon: debugfs is not available
initcall at 0xffffffff807caf70: mon_init+0x0/0x20(): returned with error code -19
ACPI (acpi_bus-0216): Device 'USB2' is not power manageable [20060210]
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
GSI 23 sharing vector 0x52 and IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 82
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 82, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc5-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI (acpi_bus-0216): Device 'USB0' is not power manageable [20060210]
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 233, io mem 0xda004000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc5-mm2 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
i2c /dev entries driver
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  8828.000 MB/sec
raid5: using function: generic_sse (8828.000 MB/sec)
raid6: int64x1   2174 MB/s
raid6: int64x2   2911 MB/s
raid6: int64x4   3188 MB/s
raid6: int64x8   2314 MB/s
raid6: sse2x1    2712 MB/s
raid6: sse2x2    4141 MB/s
raid6: sse2x4    4496 MB/s
raid6: using algorithm sse2x4 (4496 MB/s)
md: raid6 personality registered for level 6
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
initcall at 0xffffffff807ba030: powernowk8_init+0x0/0x40(): returned with error code -19
ACPI: wakeup devices: HUB0 XVR0 XVR1 XVR2 XVR3 USB0 USB2 MMAC MMCI UAR1 
ACPI: (supports S0 S1 S3 S4 S5)
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
initcall at 0xffffffff807cb470: rtc_hctosys+0x0/0x180(): returned with error code -19
md: Autodetecting RAID arrays.
logips2pp: Detected unknown logitech mouse model 1
md: autorun ...
md: considering sdh1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: hdc9 has different UUID to sdh1
md: hdc8 has different UUID to sdh1
md: hdc7 has different UUID to sdh1
md: hdc6 has different UUID to sdh1
md: hdc5 has different UUID to sdh1
md: hda9 has different UUID to sdh1
md: hda8 has different UUID to sdh1
md: hda7 has different UUID to sdh1
md: hda6 has different UUID to sdh1
md: hda5 has different UUID to sdh1
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: running: <sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1><sda1>
raid6: device sdh1 operational as raid disk 1
raid6: device sdg1 operational as raid disk 4
raid6: device sdf1 operational as raid disk 5
raid6: device sde1 operational as raid disk 6
raid6: device sdd1 operational as raid disk 2
raid6: device sdc1 operational as raid disk 0
raid6: device sdb1 operational as raid disk 7
raid6: device sda1 operational as raid disk 3
raid6: allocated 8460kB for md0
raid6: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
RAID6 conf printout:
 --- rd:8 wd:8 fd:0
 disk 0, o:1, dev:sdc1
 disk 1, o:1, dev:sdh1
 disk 2, o:1, dev:sdd1
 disk 3, o:1, dev:sda1
 disk 4, o:1, dev:sdg1
 disk 5, o:1, dev:sdf1
 disk 6, o:1, dev:sde1
 disk 7, o:1, dev:sdb1
md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
created bitmap (233 pages) for device md0
md: considering hdc9 ...
md:  adding hdc9 ...
md: hdc8 has different UUID to hdc9
md: hdc7 has different UUID to hdc9
md: hdc6 has different UUID to hdc9
md: hdc5 has different UUID to hdc9
md:  adding hda9 ...
md: hda8 has different UUID to hdc9
md: hda7 has different UUID to hdc9
md: hda6 has different UUID to hdc9
md: hda5 has different UUID to hdc9
md: created md4
md: bind<hda9>
md: bind<hdc9>
md: running: <hdc9><hda9>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 10/10 pages, set 5 bits, status: 0
created bitmap (156 pages) for device md4
md: considering hdc8 ...
md:  adding hdc8 ...
md: hdc7 has different UUID to hdc8
md: hdc6 has different UUID to hdc8
md: hdc5 has different UUID to hdc8
md:  adding hda8 ...
md: hda7 has different UUID to hdc8
md: hda6 has different UUID to hdc8
md: hda5 has different UUID to hdc8
md: created md3
md: bind<hda8>
md: bind<hdc8>
md: running: <hdc8><hda8>
raid1: raid set md3 active with 2 out of 2 mirrors
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d80000738f5d]
md3: bitmap initialized from disk: read 8/8 pages, set 4 bits, status: 0
created bitmap (123 pages) for device md3
md: considering hdc7 ...
md:  adding hdc7 ...
md: hdc6 has different UUID to hdc7
md: hdc5 has different UUID to hdc7
md:  adding hda7 ...
md: hda6 has different UUID to hdc7
md: hda5 has different UUID to hdc7
md: created md2
md: bind<hda7>
md: bind<hdc7>
md: running: <hdc7><hda7>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 8/8 pages, set 88 bits, status: 0
created bitmap (123 pages) for device md2
md: considering hdc6 ...
md:  adding hdc6 ...
md: hdc5 has different UUID to hdc6
md:  adding hda6 ...
md: hda5 has different UUID to hdc6
md: created md1
md: bind<hda6>
md: bind<hdc6>
md: running: <hdc6><hda6>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 12/12 pages, set 66 bits, status: 0
created bitmap (184 pages) for device md1
md: considering hdc5 ...
md:  adding hdc5 ...
md:  adding hda5 ...
md: created md5
md: bind<hda5>
md: bind<hdc5>
md: running: <hdc5><hda5>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 9/9 pages, set 0 bits, status: 0
created bitmap (129 pages) for device md5
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00023c014100f4bf]
i2c_adapter i2c-3: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-4: nForce2 SMBus adapter at 0x4c40
HPT374: IDE controller at PCI slot 0000:05:06.0
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 74
HPT374: chipset revision 7
HPT374: 100% native mode on irq 74
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0x7000-0x7007, BIOS settings: hde:DMA, hdf:pio
HPT37X: using 33MHz PCI clock
    ide3: BM-DMA at 0x7008-0x700f, BIOS settings: hdg:pio, hdh:pio
ACPI: PCI Interrupt 0000:05:06.1[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 74
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:DMA, hdj:pio
HPT37X: using 33MHz PCI clock
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide2...
hde: WDC WD2500JB-00FUA0, ATA DISK drive
ide2 at 0x6000-0x6007,0x6402 on irq 74
hde: max request size: 512KiB
hde: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1
Probing IDE interface ide3...
Probing IDE interface ide4...
hdi: ST3300831A, ATA DISK drive
ide4 at 0x7400-0x7407,0x7802 on irq 74
hdi: max request size: 512KiB
hdi: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63, UDMA(100)
hdi: cache flushes supported
 hdi: hdi1
Probing IDE interface ide5...
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 217
Installing spdif_bug patch: Audigy 2 ZS [2001]
hdb: Speed warnings UDMA 3/4/5 is not functional.
Adding 4200888k swap on /dev/md5.  Priority:-1 extents:1 across:4200888k
EXT3 FS on md2, internal journal
it87: Found IT8712F chip at 0x290, revision 7
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md4: found reiserfs format "3.6" with standard journal
ReiserFS: md4: using ordered data mode
ReiserFS: md4: journal params: device md4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md4: checking transaction log (md4)
ReiserFS: md4: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hde1: found reiserfs format "3.6" with standard journal
ReiserFS: hde1: using ordered data mode
ReiserFS: hde1: journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde1: checking transaction log (hde1)
ReiserFS: hde1: Using r5 hash to sort names
ReiserFS: sde2: found reiserfs format "3.6" with standard journal
ReiserFS: sde2: using ordered data mode
ReiserFS: sde2: journal params: device sde2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sde2: checking transaction log (sde2)
ReiserFS: sde2: Using r5 hash to sort names
ReiserFS: sdg2: found reiserfs format "3.6" with standard journal
ReiserFS: sdg2: using ordered data mode
ReiserFS: sdg2: journal params: device sdg2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdg2: checking transaction log (sdg2)
ReiserFS: sdg2: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdi1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
skge switch: enabling interface
ADDRCONF(NETDEV_UP): switch: link is not ready
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 304 bytes per conntrack
skge switch: Link is up at 1000 Mbps, full duplex, flow control tx and rx
ADDRCONF(NETDEV_CHANGE): switch: link becomes ready
adsl: no IPv6 routers present
switch: no IPv6 routers present
-- 
I've seen those who try to make a life without kin for ever
So I've taken my place uncertain at your shoulder
The last few prayers, the whistle blow,
And into the fray once more we go
My people right or wrong
	New Model Army - My People
Debian (Unstable) GNU/Linux 2.6.16-rc5-mm2 5503 bogomips load 4.52
