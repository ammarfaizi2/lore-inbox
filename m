Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVLDDAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVLDDAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 22:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVLDDAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 22:00:49 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:18639 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932193AbVLDDAs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 22:00:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kSKemdX5yfFtvAzkmxKnICNQ/XS/B+0tWMYyDS1Q2YILagPRz0ig8y2JXFr/msF7p6ISWVVLE93xn39mK5eQbdam57YSonsI1OaYV1D3ndn3+urrHRHCavN40wfoMrBXYykhcEv4pCbS8Bk5pMZC+AOONAo/7hLREIYR5tSURtg=
Message-ID: <9dda34920512031900o1055afffre8dbf7ae00232687@mail.gmail.com>
Date: Sat, 3 Dec 2005 22:00:47 -0500
From: Paul Blazejowski <diffie@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My clock is running on X2 cpu using x86_64 kernel, there's also some
invalid IRQ. Check vendor BIOS spews, details in dmesg below:

Bootdata ok (command line is root=/dev/sda1 ro elevator=cfq vga=795)
Linux version 2.6.15-rc4 (root@blaze) (gcc version 3.4.4) #1 SMP
PREEMPT Sat Dec 3 04:45:27 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000001fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000001fff30c0
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @
0x000000001fff9900
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000001fff9a00
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000001fff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-20000000
Using 31 for the hash shift.
Bootmem setup node 0 0000000000000000-000000001fff0000
On node 0 totalpages: 127929
  DMA zone: 2704 pages, LIFO batch:2
  DMA32 zone: 125225 pages, LIFO batch:64
  Normal zone: 0 pages, LIFO batch:2
  HighMem zone: 0 pages, LIFO batch:2
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
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
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Checking aperture...
CPU 0: aperture @ c50000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro elevator=cfq vga=795
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2400.207 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 510208k/524224k available (2818k kernel code, 13628k reserved,
1255k data, 248k init)
Calibrating delay using timer specific routine.. 4803.43 BogoMIPS (lpj=2401715)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 15.001 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4799.69 BogoMIPS (lpj=2399847)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 568 cycles)
Brought up 2 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
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
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:09.0
  IO window: a000-afff
  MEM window: d0000000-d1ffffff
  PREFETCH window: 30000000-300fffff
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
  MEM window: c8000000-cfffffff
  PREFETCH window: c0000000-c7ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
GSI 16 sharing vector 0xD9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level,
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 217, io mem 0xd2004000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v2.3
sl811: driver sl811-hcd, 19 May 2005
usb 1-2: new full speed USB device using ohci_hcd and address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-3: new full speed USB device using ohci_hcd and address 3
hub 1-3:1.0: USB hub found
hub 1-3:1.0: 3 ports detected
usb 1-4: new low speed USB device using ohci_hcd and address 4
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as
/class/input/input0
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-0000:00:02.0-4
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20010100000, using
10240k, total 131072k
vesafb: mode is 1280x1024x32, linelength=5120, pages=0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
vesafb: Mode is not VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
fb1: VGA16 VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin
is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
usb 1-3.1: new low speed USB device using ohci_hcd and address 5
input: Microsoft Natural Keyboard Pro as /class/input/input1
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-3.1
input: Microsoft Natural Keyboard Pro as /class/input/input2
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-3.1
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
GSI 17 sharing vector 0xE1 and IRQ 17
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level,
low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 225
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 225
ata1: no device found (phy stat 00000000)
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 18 sharing vector 0xE9 and IRQ 18
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level,
low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 233
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 233
ata3: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:407f
ata3: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: no device found (phy stat 00000000)
scsi3 : sata_nv
  Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
ip_conntrack version 2.4 (2047 buckets, 16376 max) - 288 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SGI XFS with ACLs, security attributes, large block/inode numbers, no
debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
Freeing unused kernel memory: 248k freed
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
GSI 19 sharing vector 0x32 and IRQ 19
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level,
low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:02.1: irq 50, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 2-2: new high speed USB device using ehci_hcd and address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 23 (level,
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 50710 usecs
intel8x0: clocking to 46809
usb 1-2: USB disconnect, address 2
usb 1-3: USB disconnect, address 3
usb 1-3.1: USB disconnect, address 5
usb 1-3: new full speed USB device using ohci_hcd and address 6
hub 1-3:1.0: USB hub found
hub 1-3:1.0: 3 ports detected
usb 1-4: USB disconnect, address 4
usb 1-4: new low speed USB device using ohci_hcd and address 7
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as
/class/input/input3
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-0000:00:02.0-4
usb 1-3.1: new low speed USB device using ohci_hcd and address 8
input: Microsoft Natural Keyboard Pro as /class/input/input4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-3.1
input: Microsoft Natural Keyboard Pro as /class/input/input5
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-3.1
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.47.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 22 (level,
low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
eth0: no link during initialization.
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 20 sharing vector 0x3A and IRQ 20
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 58
Installing spdif_bug patch: Audigy 2 Platinum [SB0240P]
eth0: link up.
gameport: EMU10K1 is pci0000:05:07.1/gameport0, io 0xa400, speed 1205kHz
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
GSI 21 sharing vector 0x42 and IRQ 21
ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 66
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[66] 
MMIO=[d100e000-d100e7ff]  Max Packet=[2048]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 22 sharing vector 0x4A and IRQ 22
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level,
low) -> IRQ 74
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[74] 
MMIO=[d100c000-d100c7ff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 58
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 58
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091065c55]
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 66
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-8168  Thu
Oct 20 10:49:01 PDT 2005
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 66
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-8168  Thu
Oct 20 10:49:01 PDT 2005
X does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

X does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

X does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

glxinfo does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

glxinfo does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

glxinfo does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

glxgears does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

glxgears does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

glxgears does an incomplete pfn remapping
Call Trace:<ffffffff801695b8>{remap_pfn_range+152}
<ffffffff8024bdac>{pci_bus_read_config_dword+124}
       <ffffffff883de2d6>{:nvidia:nv_kern_mmap+1410}
<ffffffff8016dd2d>{do_mmap_pgoff+1389}
       <ffffffff80114406>{sys_mmap+150} <ffffffff8010dd36>{system_call+126}

Losing some ticks... checking if CPU frequency changed.
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip default_idle+0x36/0x80
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!
Hangcheck: hangcheck value past margin!

Running ntpdate gives time offsets:

root@blaze:~# uptime
 21:59:45 up  2:08,  4 users,  load average: 1.70, 1.41, 0.71
root@blaze:~# ntpdate time
Looking for host time and service ntp
host found : time
 3 Dec 21:59:41 ntpdate[19591]: step time server 192.168.0.1 offset
-11.837451 sec

Kernel config and any other details are available upon request.

Thanks,

Paul B.
