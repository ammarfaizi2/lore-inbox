Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWGLH64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWGLH64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWGLH64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:58:56 -0400
Received: from mailgate.terastack.com ([195.173.195.66]:23821 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1750779AbWGLH6z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:58:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Wed, 12 Jul 2006 08:58:52 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C27043F5D1C@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Thread-Index: AcaliQQ5xX4XXwBJRe2OX1eDqpWMEA==
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to install the linux-image-2.6.17-1-amd64-k8-smp debian package
on a ASUS M2NPV-VM motherboard based system and it hung during boot. The
last message on the console was:

io scheduler cfq registered

Anyone got any suggestions? Unfortunately, this is a production server
so I'm going to get very little time on it to try things out. For the
moment, I've reverted to 2.6.16 where it seems basically stable (there
are occasional hangs with the hard disk light hard on which is why I
tried out 2.6.17).

FWIW here's the output of dmesg from 2.6.16 just in case something leaps
out at someone:

# dmesg
Bootdata ok (command line is root=/dev/sda1 ro )
Linux version 2.6.16-2-amd64-k8-smp (Debian 2.6.16-16)
(waldi@debian.org) (gcc version 4.0.4 20060630 (prerelease) (Debian
4.0.3-4)) #1 SMP Sat Jul 8 20:05:55 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dbef0000 (usable)
 BIOS-e820: 00000000dbef0000 - 00000000dbef3000 (ACPI NVS)
 BIOS-e820: 00000000dbef3000 - 00000000dbf00000 (ACPI data)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
 BIOS-e820: 00000001dc000000 - 00000001e0000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @
0x00000000000f74f0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000dbef3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000dbef30c0
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000dbefb240
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x00000000dbefb180
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 0000000120000000
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-0000000120000000
On node 0 totalpages: 1014861
  DMA zone: 3109 pages, LIFO batch:0
  DMA32 zone: 882472 pages, LIFO batch:31
  Normal zone: 129280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
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
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at dc000000 (gap: dbf00000:14100000)
Checking aperture...
CPU 0: aperture @ 4000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
SMP: Allowing 2 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2204.628 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3982644k/4718592k available (1852k kernel code, 144648k
reserved, 812k data, 168k init)
Calibrating delay using timer specific routine.. 4419.38 BogoMIPS
(lpj=8838766)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
 failed.
Using local APIC timer interrupts.
result 12526298
Detected 12.526 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4413.06 BogoMIPS
(lpj=8826120)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 547
cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=204
checking if image is initramfs... it is
Freeing initrd memory: 4785k freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at f0000000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:05.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0A08
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0400
pnp: ACPI device : hid PNP0F13
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNPB006
pnp: ACPI device : hid PNPB02F
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C01
pnp: PnP ACPI: found 17 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
pnp: 00:01: ioport range 0x2000-0x207f has been reserved
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
pnp: match found with the PnP device '00:02' and the driver 'system'
pnp: match found with the PnP device '00:0f' and the driver 'system'
pnp: match found with the PnP device '00:10' and the driver 'system'
PCI: Bridge: 0000:00:02.0
  IO window: a000-afff
  MEM window: fd800000-fd8fffff
  PREFETCH window: fd700000-fd7fffff
PCI: Bridge: 0000:00:03.0
  IO window: 8000-8fff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:04.0
  IO window: b000-bfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: fd900000-fd9fffff
PCI: Bridge: 0000:00:10.0
  IO window: 9000-9fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fda00000-fdafffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1152689010.136:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[02fc:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0c' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:09' and the driver 'serial'
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
HUB0 XVRA XVRB XVRC USB0 USB2 AZAD MMAC MMCI UAR1 UAR2 PS2M PS2K 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 168k freed
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
ieee1394: Initialized config rom entry `ip1394'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf408-0xf40f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.49.
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
hda: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
GSI 16 sharing vector 0xD1 and IRQ 16
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 23 (level,
low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:14.0 to 64
eth0: forcedeth.c: subsystem: 01043:816a bound to 0000:00:14.0
SCSI subsystem initialized
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
GSI 17 sharing vector 0xD9 and IRQ 17
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 22 (level,
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.1: irq 217, io mem 0xfe02e000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
libata version 1.20 loaded.
sata_nv 0000:00:0e.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
GSI 18 sharing vector 0xE1 and IRQ 18
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 21 (level,
low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 225
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 225
ata1: SATA link up 3.0 Gbps (SStatus 123)
usb 1-6: new high speed USB device using ehci_hcd and address 2
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023
88:407f
ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
usb 1-6: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3e03 87:4123
88:407f
ata2: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_nv
  Vendor: ATA       Model: ST3250624AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20
GSI 19 sharing vector 0xE9 and IRQ 19
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 20 (level,
low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:0f.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xCC00 irq 233
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xCC08 irq 233
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3e03 87:4123
88:407f
ata3: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi3 : sata_nv
ata4: SATA link down (SStatus 0)
scsi4 : sata_nv
  Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 20 sharing vector 0x32 and IRQ 20
ACPI: PCI Interrupt 0000:04:05.0[A] -> Link [APC4] -> GSI 19 (level,
low) -> IRQ 50
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 23 (level,
low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0b.0: irq 209, io mem 0xfe02f000
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[50]
MMIO=[fdbff000-fdbff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 3:0:0:0: Attached scsi disk sdc
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000b31499]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
input: PC Speaker as /class/input/input1
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
input: PS/2 Generic Mouse as /class/input/input2
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
pnp: the driver 'mpu401' has been registered
pnp: match found with the PnP device '00:0d' and the driver 'mpu401'
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 22 (level,
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:10.1 to 64
  Vendor: VIA-P     Model: VT6205-DevB       Rev: 2.82
  Type:   Direct-Access                      ANSI SCSI revision: 02
sd 2:0:0:0: Attached scsi removable disk sdd
  Vendor: VIA-P     Model: VT6205-DevM       Rev: 2.82
  Type:   Direct-Access                      ANSI SCSI revision: 02
sd 2:0:0:1: Attached scsi removable disk sde
usb-storage: device scan complete
Adding 5855684k swap on /dev/sda3.  Priority:-1 extents:1
across:5855684k
EXT3 FS on sda1, internal journal
Probing IDE interface ide1...
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SGI XFS with ACLs, security attributes, realtime, large block/inode
numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sdc1
Ending clean XFS mount for filesystem: sdc1
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
directory
NFSD: starting 90-second grace period
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
GSI 21 sharing vector 0x3A and IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APC7] -> GSI 16 (level,
low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:05.0 to 64
NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8762  Mon May 15
13:58:14 PDT 2006
eth0: no IPv6 routers present

 
-- 
Andy, BlueArc Engineering
