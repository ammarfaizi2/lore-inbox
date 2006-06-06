Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWFFWQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWFFWQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFFWQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:16:19 -0400
Received: from tus-mailout1.raytheon.com ([199.46.245.198]:13969 "EHLO
	tus-mailout1.ext.ray.com") by vger.kernel.org with ESMTP
	id S1751187AbWFFWQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:16:18 -0400
Message-ID: <4485FE8F.3090404@raytheon.com>
Date: Tue, 06 Jun 2006 15:15:43 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
Organization: Raytheon Missile Systems -- Tucson, AZ, U.S.
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rostedt@goodmis.org, mingo@elte.hu
Subject: 2.6.16-rt28 success on 4x Opteron
Content-Type: multipart/mixed;
 boundary="------------090409080206020005000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------090409080206020005000003
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Haven't run any tests of any sort, but this is a big step forward.  The 
machine is based around an IWill H8502, and previously could not boot -rt20.

The config is a straight transfer of a working 2.6.16.14 with all the 
defaults chosen on a make oldconfig.  Config attached.

Bootdata ok (command line is ro root=/dev/md0 console=ttyS0,115200n8 
console=tty0)
Linux version 2.6.16-rt28_local_01 (rcrocomb@spanky) (gcc version 4.1.0 
20060304 (Red Hat 4.1.0-3)) #5 SMP PREEMPT Tue Jun 6 11:15:19 MST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 0000000000099400 (usable)
  BIOS-e820: 0000000000099400 - 0000000000099c00 (reserved)
  BIOS-e820: 00000000000eadc0 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000cbfd0000 (usable)
  BIOS-e820: 00000000cbfd0000 - 00000000cbfde000 (ACPI data)
  BIOS-e820: 00000000cbfde000 - 00000000cc000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000280000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 
0x00000000000f8ab0
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000627 MSFT 0x00000097) @ 
0x00000000cbfd0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000627 MSFT 0x00000097) @ 
0x00000000cbfd0290
ACPI: MADT (v001 A M I  OEMAPIC  0x02000627 MSFT 0x00000097) @ 
0x00000000cbfd0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000627 MSFT 0x00000097) @ 
0x00000000cbfde040
ACPI: SRAT (v001 A M I  OEMSRAT  0x02000627 MSFT 0x00000097) @ 
0x00000000cbfd6990
ACPI: DSDT (v001  8502V 8502V097 0x00000097 INTL 0x02002026) @ 
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
ACPI: [SRAT:0x00] ignored 12 entries of 16 found
SRAT: Node 0 PXM 0 100000-80000000
SRAT: Node 1 PXM 1 80000000-cc000000
SRAT: Node 2 PXM 2 100000000-200000000
SRAT: Node 3 PXM 3 200000000-280000000
SRAT: Node 0 PXM 0 0-80000000
NUMA: Using 31 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000080000000
Bootmem setup node 1 0000000080000000-00000000cc000000
Bootmem setup node 2 0000000100000000-0000000200000000
Bootmem setup node 3 0000000200000000-0000000280000000
On node 0 totalpages: 501370
   DMA zone: 2514 pages, LIFO batch:0
   DMA32 zone: 498856 pages, LIFO batch:31
   Normal zone: 0 pages, LIFO batch:0
   HighMem zone: 0 pages, LIFO batch:0
On node 1 totalpages: 298480
   DMA zone: 0 pages, LIFO batch:0
   DMA32 zone: 298480 pages, LIFO batch:31
   Normal zone: 0 pages, LIFO batch:0
   HighMem zone: 0 pages, LIFO batch:0
On node 2 totalpages: 1005568
   DMA zone: 0 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 1005568 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
On node 3 totalpages: 502784
   DMA zone: 0 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 502784 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x84] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x85] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x86] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x87] disabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
ACPI: IOAPIC (id[0x03] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 3, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x04] address[0xcfdf7000] gsi_base[24])
IOAPIC[1]: apic_id 4, version 17, address 0xcfdf7000, GSI 24-47
ACPI: IOAPIC (id[0x05] address[0xfbefe000] gsi_base[72])
IOAPIC[2]: apic_id 5, version 17, address 0xfbefe000, GSI 72-78
ACPI: IOAPIC (id[0x06] address[0xfbeff000] gsi_base[79])
IOAPIC[3]: apic_id 6, version 17, address 0xfbeff000, GSI 79-85
ACPI: IOAPIC (id[0x07] address[0xcfdfe000] gsi_base[86])
IOAPIC[4]: apic_id 7, version 17, address 0xcfdfe000, GSI 86-92
ACPI: IOAPIC (id[0x08] address[0xcfdff000] gsi_base[93])
IOAPIC[5]: apic_id 8, version 17, address 0xcfdff000, GSI 93-99
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq -4096 dfl dfl)
ERROR: Unable to locate IOAPIC for GSI -4096
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d0000000 (gap: cc000000:32c00000)
Checking aperture...
CPU 0: aperture @ ce000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 4 zonelists
Kernel command line: ro root=/dev/md0 console=ttyS0,115200n8 console=tty0
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz WALL PIT GTOD PIT timer.
time.c: Detected 2800.032 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 9138136k/10485760k available (2545k kernel code, 495052k 
reserved, 1685k data, 228k init)
Calibrating delay using timer specific routine.. 5602.18 BogoMIPS 
(lpj=2801094)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
Using local APIC timer interrupts.
result 12500151
Detected 12.500 MHz APIC timer.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5599.26 BogoMIPS 
(lpj=2799634)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 854 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -145 cycles, maxerr 1042 
cycles)
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 5599.24 BogoMIPS 
(lpj=2799620)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
AMD Opteron(tm) Processor 854 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -145 cycles, maxerr 1046 
cycles)
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 5599.28 BogoMIPS 
(lpj=2799641)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
AMD Opteron(tm) Processor 854 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -183 cycles, maxerr 1812 
cycles)
Brought up 4 CPUs
testing NMI watchdog ... OK.
checking if image is initramfs... it is
Freeing initrd memory: 858k freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:03:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POGA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POGB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *7
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *5
ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *11
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LK2N] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [LT3D] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [LT2E] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Root Bridge [PCIB] (0000:80)
PCI: Probing PCI hardware (bus 80)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.POGC._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.POGD._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:09.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
   IO window: disabled.
   MEM window: feb00000-febfffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
   IO window: disabled.
   MEM window: fea00000-feafffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
   IO window: a000-afff
   MEM window: fc000000-fe9fffff
   PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:10.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:11.0
   IO window: disabled.
   MEM window: fbf00000-fbffffff
   PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Bridge: 0000:80:0d.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:80:0e.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:80:10.0
   IO window: e000-efff
   MEM window: cfe00000-cfffffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:80:11.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:80:0d.0 to 64
PCI: Setting latency timer of device 0000:80:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered (default)
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PCI: Setting latency timer of device 0000:80:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:80:0d.0:pcie00]
PCI: Setting latency timer of device 0000:80:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:80:0e.0:pcie00]
Real Time Clock Driver v1.12ac
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 
sec (nowayout= 0)
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 162
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0x3008-0x300f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: SONY DVD RW DW-Q58A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
GSI 16 sharing vector 0xE9 and IRQ 16
ACPI: PCI Interrupt 0000:82:06.0[A] -> GSI 88 (level, low) -> IRQ 233
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
         <Adaptec AIC7902 Ultra320 SCSI adapter>
         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 
512 SCBs

GSI 17 sharing vector 0x32 and IRQ 17
ACPI: PCI Interrupt 0000:82:06.1[B] -> GSI 89 (level, low) -> IRQ 50
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
         <Adaptec AIC7902 Ultra320 SCSI adapter>
         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 
512 SCBs

   Vendor: SEAGATE   Model: ST3300007LC       Rev: 0003
   Type:   Direct-Access                      ANSI SCSI revision: 03
  target1:0:0: asynchronous
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
  target1:0:0: Beginning Domain Validation
  target1:0:0: wide asynchronous
  target1:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW 
PCOMP (6.25 ns, offset 63)
  target1:0:0: Ending Domain Validation
   Vendor: SEAGATE   Model: ST3300007LC       Rev: 0003
   Type:   Direct-Access                      ANSI SCSI revision: 03
  target1:0:1: asynchronous
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
  target1:0:1: Beginning Domain Validation
  target1:0:1: wide asynchronous
  target1:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW 
PCOMP (6.25 ns, offset 63)
  target1:0:1: Ending Domain Validation
libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
GSI 18 sharing vector 0x3A and IRQ 18
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level, 
low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x8800 ctl 0x8402 bmdma 0x7800 irq 58
ata2: SATA max UDMA/133 cmd 0x8000 ctl 0x7C02 bmdma 0x7808 irq 58
ata1: SATA link down (SStatus 0)
scsi2 : sata_nv
ata2: SATA link down (SStatus 0)
scsi3 : sata_nv
ACPI: PCI Interrupt Link [LTIE] enabled at IRQ 21
GSI 19 sharing vector 0x42 and IRQ 19
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LTIE] -> GSI 21 (level, 
low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9C00 ctl 0x9802 bmdma 0x8C00 irq 66
ata4: SATA max UDMA/133 cmd 0x9400 ctl 0x9002 bmdma 0x8C08 irq 66
ata3: SATA link down (SStatus 0)
scsi4 : sata_nv
ata4: SATA link down (SStatus 0)
scsi5 : sata_nv
ACPI: PCI Interrupt Link [LT3D] enabled at IRQ 47
GSI 20 sharing vector 0x4A and IRQ 20
ACPI: PCI Interrupt 0000:80:07.0[A] -> Link [LT3D] -> GSI 47 (level, 
low) -> IRQ 74
PCI: Setting latency timer of device 0000:80:07.0 to 64
ata5: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xB800 irq 74
ata6: SATA max UDMA/133 cmd 0xC000 ctl 0xBC02 bmdma 0xB808 irq 74
ata5: SATA link down (SStatus 0)
scsi6 : sata_nv
ata6: SATA link down (SStatus 0)
scsi7 : sata_nv
ACPI: PCI Interrupt Link [LT2E] enabled at IRQ 46
GSI 21 sharing vector 0x52 and IRQ 21
ACPI: PCI Interrupt 0000:80:08.0[A] -> Link [LT2E] -> GSI 46 (level, 
low) -> IRQ 82
PCI: Setting latency timer of device 0000:80:08.0 to 64
ata7: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xCC00 irq 82
ata8: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xCC08 irq 82
ata7: SATA link down (SStatus 0)
scsi8 : sata_nv
ata8: SATA link down (SStatus 0)
scsi9 : sata_nv
SCSI device sda: 585937500 512-byte hdwr sectors (300000 MB)
sda: Write Protect is off
sda: Mode Sense: ab 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 585937500 512-byte hdwr sectors (300000 MB)
sda: Write Protect is off
sda: Mode Sense: ab 00 10 08
SCSI device sda: drive cache: write back w/ FUA
  sda: sda1 sda2
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 585937500 512-byte hdwr sectors (300000 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
SCSI device sdb: 585937500 512-byte hdwr sectors (300000 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: drive cache: write back w/ FUA
  sdb: sdb1 sdb2
sd 1:0:1:0: Attached scsi disk sdb
Fusion MPT base driver 3.03.07
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.07
ieee1394: Initialized config rom entry `ip1394'
GSI 22 sharing vector 0x5A and IRQ 22
ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 79 (level, low) -> IRQ 90
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[90] 
MMIO=[fbfff800-fbffffff]  Max Packet=[4096]  IR/IT contexts=[4/8]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
eth1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
GSI 23 sharing vector 0x62 and IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 20 (level, 
low) -> IRQ 98
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 98, io mem 0xfbef7c00
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 22 (level, 
low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 58, io mem 0xfbef6000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v2.3
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
input: AT Translated Set 2 keyboard as /class/input/input0
    generic_sse:  8444.000 MB/sec
raid5: using function: generic_sse (8444.000 MB/sec)
raid6: int64x1   1921 MB/s
raid6: int64x2   2613 MB/s
raid6: int64x4   2976 MB/s
raid6: int64x8   2238 MB/s
raid6: sse2x1    2789 MB/s
raid6: sse2x2    4207 MB/s
raid6: sse2x4    4816 MB/s
raid6: using algorithm sse2x4 (4816 MB/s)
md: raid6 personality registered for level 6
md: multipath personality registered for level -4
md: faulty personality registered for level -5
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 16384 (order: 9, 2359296 bytes)
TCP bind hash table entries: 16384 (order: 9, 2228224 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
*****************************************************************************
* 
     *
*  REMINDER, the following debugging options are turned on in your 
.config: *
* 
     *
Time: tsc clocksource has been installed.
*        CONFIG_DEBUG_RT_MUTEXES 
      *
*        CONFIG_DEBUG_PREEMPT 
     *
* 
     *
*  they may increase runtime overhead and latencies. 
     *
* 
     *
*****************************************************************************
Freeing unused kernel memory: 228k freed
Time: acpi_pm clocksource has been installed.
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[081443620000099d]
ieee1394: Node added: ID:BUS[0-08:1023]  GUID[081443620000099e]
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
tg3.c:v3.49 (Feb 2, 2006)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 19
GSI 24 sharing vector 0x6A and IRQ 24
ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [LNKA] -> GSI 19 (level, 
low) -> IRQ 106
PCI: Setting latency timer of device 0000:05:00.0 to 64
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 
10/100/1000BaseT Ethernet 00:d0:68:0d:ab:a3
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
eth1: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 18
GSI 25 sharing vector 0x72 and IRQ 25
ACPI: PCI Interrupt 0000:04:00.0[A] -> Link [LNKD] -> GSI 18 (level, 
low) -> IRQ 114
PCI: Setting latency timer of device 0000:04:00.0 to 64
eth2: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 
10/100/1000BaseT Ethernet 00:d0:68:0d:ab:a2
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] 
TSOcap[1]
eth2: dma_rwctrl[76180000] dma_mask[64-bit]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on md0, internal journal
Adding 5116692k swap on /dev/sdb2.  Priority:-1 extents:1 across:5116692k
Adding 5116692k swap on /dev/sda2.  Priority:-2 extents:1 across:5116692k
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
tg3: eth1: Link is up at 100 Mbps, full duplex.
tg3: eth1: Flow control is off for TX and off for RX.
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present


-- 
Robert Crocombe
rwcrocombe@raytheon.com

--------------090409080206020005000003
Content-Type: application/octet-stream;
 name=".config.bz2"
Content-Disposition: attachment;
 filename=".config.bz2"
Content-Transfer-Encoding: base64

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
cDA/+LuSKcKEgBt9PeA=


--------------090409080206020005000003--

