Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWCAKrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWCAKrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWCAKrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:47:11 -0500
Received: from mailgate.terastack.com ([195.173.195.66]:64271 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S964921AbWCAKrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:47:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Wed, 1 Mar 2006 10:47:04 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393C0D0@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY9FkQCx/Sn8x4KRI23YnIdVqnXTwABxJsg
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch. Here's the output from dmesg after applying it:

Bootdata ok (command line is root=/dev/hda1 ro )
Linux version 2.6.15-1-amd64-k8 (Debian 2.6.15-1) (luther@debian.org)
(gcc version 4.0.3 20060212 (prerelease) (Debian 4.0.2-9)) #2 Wed Mar 1
10:09:53 GMT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffb0000 (usable)
 BIOS-e820: 00000000bffb0000 - 00000000bffc0000 (ACPI data)
 BIOS-e820: 00000000bffc0000 - 00000000bfff0000 (ACPI NVS)
 BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @
0x00000000000fa7c0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000506 MSFT 0x00000097) @
0x00000000bffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000506 MSFT 0x00000097) @
0x00000000bffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000506 MSFT 0x00000097) @
0x00000000bffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000506 MSFT 0x00000097) @
0x00000000bffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @
0x0000000000000000
On node 0 totalpages: 1029721
  DMA zone: 3185 pages, LIFO batch:0
  DMA32 zone: 767976 pages, LIFO batch:31
  Normal zone: 258560 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
Looks like a VIA chipset. Disabling IOMMU. Overwrite with
"iommu=allowed"
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3f780000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2202.916 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x5c39000 - 0x9c39000
Memory: 4045192k/5242880k available (1703k kernel code, 148148k
reserved, 738k data, 148k init)
Calibrating delay using timer specific routine.. 4412.88 BogoMIPS
(lpj=2206444)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) 64 Processor 3500+ stepping 00
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
blk_max_low_pfn=1310720, blk_max_pfn=1310720
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0F03
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0C01
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: 00:07: ioport range 0x680-0x6ff has been reserved
pnp: 00:07: ioport range 0x290-0x297 has been reserved
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: faf00000-fbffffff
  PREFETCH window: f0000000-f9ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1141209586.378:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:02' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:03' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'serial'
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: match found with the PnP device '00:0b' and the driver 'serial'
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
0000:00:09.0: ttyS2 at I/O 0xa400 (irq = 16) is a 16550A
0000:00:09.0: ttyS3 at I/O 0xa000 (irq = 16) is a 16550A
bounce: queue ffff81013f97ad18, setting pfn 1310720, max_low 1310720
q=ffff81013f97ad18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97aa88, setting pfn 1310720, max_low 1310720
q=ffff81013f97aa88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a7f8, setting pfn 1310720, max_low 1310720
q=ffff81013f97a7f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a568, setting pfn 1310720, max_low 1310720
q=ffff81013f97a568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a2d8, setting pfn 1310720, max_low 1310720
q=ffff81013f97a2d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f97a048, setting pfn 1310720, max_low 1310720
q=ffff81013f97a048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980d18, setting pfn 1310720, max_low 1310720
q=ffff81013f980d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980a88, setting pfn 1310720, max_low 1310720
q=ffff81013f980a88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9807f8, setting pfn 1310720, max_low 1310720
q=ffff81013f9807f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980568, setting pfn 1310720, max_low 1310720
q=ffff81013f980568, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f9802d8, setting pfn 1310720, max_low 1310720
q=ffff81013f9802d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f980048, setting pfn 1310720, max_low 1310720
q=ffff81013f980048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa4ed18, setting pfn 1310720, max_low 1310720
q=ffff81013fa4ed18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa4ea88, setting pfn 1310720, max_low 1310720
q=ffff81013fa4ea88, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa4e7f8, setting pfn 1310720, max_low 1310720
q=ffff81013fa4e7f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa4e568, setting pfn 1310720, max_low 1310720
q=ffff81013fa4e568, dma_addr=140000000, bounce pfn 1310720
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 148k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: HDS722525VLAT80, ATA DISK drive
hdb: Maxtor 6Y200P0, ATA DISK drive
bounce: queue ffff81013fa4e2d8, setting pfn 1310720, max_low 1310720
q=ffff81013fa4e2d8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa4e2d8, setting pfn 1048575, max_low 1310720
q=ffff81013fa4e2d8, dma_addr=ffffffff, bounce pfn 1048575
bounce: queue ffff81013fa4e048, setting pfn 1310720, max_low 1310720
q=ffff81013fa4e048, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013fa4e048, setting pfn 1048575, max_low 1310720
q=ffff81013fa4e048, dma_addr=ffffffff, bounce pfn 1048575
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
bounce: queue ffff81013f541d18, setting pfn 1310720, max_low 1310720
q=ffff81013f541d18, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f541d18, setting pfn 1310720, max_low 1310720
q=ffff81013f541d18, dma_addr=140000000, bounce pfn 1310720
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 390721968 sectors (200049 MB) w/7938KiB Cache, CHS=24321/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
hdb: max request size: 1024KiB
hdb: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63,
UDMA(133)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 18
skge 1.2 addr 0xfa900000 irq 18 chip Yukon-Lite rev 7
skge eth0: addr 00:11:2f:a7:fb:ef
SCSI subsystem initialized
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
USB Universal Host Controller Interface driver v2.3
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 3
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 19, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
libata version 1.20 loaded.
sata_promise 0000:00:08.0: version 1.03
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 20
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004200 ctl 0xFFFFC20000004238
bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xFFFFC20000004280 ctl 0xFFFFC200000042B8
bmdma 0x0 irq 20
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 3
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 19, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 3
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 19, io base 0x0000e400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 3
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 19, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 20
e100: eth1: e100_probe: addr 0xfac00000, irq 20, MAC addr
00:D0:B7:BF:92:C8
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ata3: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
ata4: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: PC Speaker as /class/input/input1
bounce: queue ffff81013f541a88, setting pfn 1310720, max_low 1310720
q=ffff81013f541a88, dma_addr=140000000, bounce pfn 1310720
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ata3: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003
88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_via
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
bounce: queue ffff81013f5417f8, setting pfn 1310720, max_low 1310720
q=ffff81013f5417f8, dma_addr=140000000, bounce pfn 1310720
bounce: queue ffff81013f5417f8, setting pfn 1048575, max_low 1310720
q=ffff81013f5417f8, dma_addr=ffffffff, bounce pfn 1048575
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:11.5 to 64
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3
sd 2:0:0:0: Attached scsi disk sda
Adding 1951856k swap on /dev/hda5.  Priority:-1 extents:1
across:1951856k
Adding 1951856k swap on /dev/hda6.  Priority:-2 extents:1
across:1951856k
Adding 1951856k swap on /dev/hda7.  Priority:-3 extents:1
across:1951856k
Adding 996020k swap on /dev/hdb2.  Priority:-4 extents:1 across:996020k
Adding 996020k swap on /dev/hdb3.  Priority:-5 extents:1 across:996020k
Adding 995988k swap on /dev/hdb5.  Priority:-6 extents:1 across:995988k
Adding 843372k swap on /dev/hdb6.  Priority:-7 extents:1 across:843372k
EXT3 FS on hda1, internal journal
ieee1394: Initialized config rom entry `ip1394'
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SGI XFS with ACLs, security attributes, realtime, large block/inode
numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
e100: intel: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
intel: no IPv6 routers present
pnp: the driver 'parport_pc' has been registered
lp: driver loaded but no devices found
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
mtrr: type mismatch for f0000000,8000000 old: write-back new:
write-combining
hda: DMA table too small
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=6e9e800, len=4096/0, pfn=1185312
sg1: dma=6e9f800, len=4096/0, pfn=1185270
sg2: dma=6ea0800, len=4096/0, pfn=1184892
sg3: dma=6ea1800, len=4096/0, pfn=1185144
sg4: dma=6ea2800, len=4096/0, pfn=1185102
sg5: dma=6ea3800, len=4096/0, pfn=1185059
sg6: dma=6ea4800, len=4096/0, pfn=1185017
sg7: dma=6ea5800, len=4096/0, pfn=1184975
sg8: dma=6ea6800, len=4096/0, pfn=1184933
sg9: dma=6ea7800, len=4096/0, pfn=1184850
sg10: dma=6ea8800, len=4096/0, pfn=1186142
sg11: dma=6ea9800, len=4096/0, pfn=1186814
sg12: dma=6eaa800, len=4096/0, pfn=1186731
sg13: dma=6eab800, len=4096/0, pfn=1186689
sg14: dma=6eac800, len=4096/0, pfn=1186227
sg15: dma=6ead800, len=4096/0, pfn=1186185
sg16: dma=6eae800, len=4096/0, pfn=1186100
sg17: dma=6eaf800, len=4096/0, pfn=1185807
sg18: dma=6eb0800, len=4096/0, pfn=1186058
sg19: dma=6eb1800, len=4096/0, pfn=1186017
sg20: dma=6eb2800, len=4096/0, pfn=1185975
sg21: dma=6eb3800, len=4096/0, pfn=1185933
sg22: dma=6eb4800, len=4096/0, pfn=1185891
sg23: dma=6eb5800, len=4096/0, pfn=1185849
sg24: dma=6eb6800, len=4096/0, pfn=1187813
sg25: dma=6eb7800, len=4096/0, pfn=1187771
sg26: dma=6eb9000, len=4096/0, pfn=1187520
sg27: dma=6eba000, len=4096/0, pfn=1187687
sg28: dma=6ebb000, len=4096/0, pfn=1187646
sg29: dma=6ebc000, len=4096/0, pfn=1187604
sg30: dma=6ebd000, len=4096/0, pfn=1187562
sg31: dma=6ebe000, len=4096/0, pfn=1187478
sg32: dma=6ebf000, len=4096/0, pfn=1187436
sg33: dma=6ec0000, len=4096/0, pfn=1187184
sg34: dma=6ec1000, len=4096/0, pfn=1187394
sg35: dma=6ec2000, len=4096/0, pfn=1187352
sg36: dma=6ec3000, len=4096/0, pfn=1187310
sg37: dma=6ec4000, len=4096/0, pfn=1187267
sg38: dma=6ec5000, len=4096/0, pfn=1187225
sg39: dma=6ec6000, len=4096/0, pfn=1187142
sg40: dma=6ec7000, len=4096/0, pfn=1186848
sg41: dma=6ec8000, len=4096/0, pfn=1187100
sg42: dma=6ec9000, len=4096/0, pfn=1187016
sg43: dma=6eca000, len=4096/0, pfn=1186974
sg44: dma=6ecb000, len=4096/0, pfn=1186932
sg45: dma=6ecc000, len=4096/0, pfn=1186890
sg46: dma=6ecd000, len=4096/0, pfn=1188811
sg47: dma=6ece000, len=4096/0, pfn=1188519
sg48: dma=6ecf000, len=4096/0, pfn=1188770
sg49: dma=6ed0000, len=4096/0, pfn=1188687
sg50: dma=6ed1000, len=4096/0, pfn=1188645
sg51: dma=6ed2000, len=4096/0, pfn=1188603
sg52: dma=6ed3000, len=4096/0, pfn=1188561
sg53: dma=6ed4000, len=4096/0, pfn=1188225
sg54: dma=6ed5000, len=4096/0, pfn=1188350
sg55: dma=6ed6000, len=4096/0, pfn=1188309
sg56: dma=6ed7000, len=4096/0, pfn=1188267
sg57: dma=6ed8000, len=4096/0, pfn=1188183
sg58: dma=6ed9000, len=4096/0, pfn=1187888
sg59: dma=6eda000, len=4096/0, pfn=1188141
sg60: dma=6edb000, len=4096/0, pfn=1188099
sg61: dma=6edc000, len=4096/0, pfn=1188057
sg62: dma=6edd000, len=4096/0, pfn=1188015
sg63: dma=6ede000, len=4096/0, pfn=1187972
sg64: dma=6edf000, len=4096/0, pfn=1187930
sg65: dma=6ee0000, len=4096/0, pfn=1187847
sg66: dma=6ee1000, len=4096/0, pfn=1189853
sg67: dma=6ee2000, len=4096/0, pfn=1189097
sg68: dma=6ee3000, len=4096/0, pfn=1189266
sg69: dma=6ee4000, len=4096/0, pfn=1189224
sg70: dma=6ee5000, len=4096/0, pfn=1189182
sg71: dma=6ee6000, len=4096/0, pfn=1189140
sg72: dma=6ee7000, len=4096/0, pfn=1189055
sg73: dma=6ee8000, len=4096/0, pfn=1189013
sg74: dma=6ee9000, len=4096/0, pfn=1190810
sg75: dma=6eea000, len=4096/0, pfn=1188972
sg76: dma=6eeb000, len=4096/0, pfn=1188930
sg77: dma=6eec000, len=4096/0, pfn=1188888
sg78: dma=6eed000, len=4096/0, pfn=1190894
sg79: dma=6eee000, len=4096/0, pfn=1190852
sg80: dma=6eef000, len=4096/0, pfn=1190768
sg81: dma=6ef0000, len=4096/0, pfn=1190475
sg82: dma=6ef1000, len=4096/0, pfn=1190642
sg83: dma=6ef2000, len=4096/0, pfn=1190600
sg84: dma=6ef3000, len=4096/0, pfn=1190559
sg85: dma=6ef4000, len=4096/0, pfn=1190517
sg86: dma=6ef5000, len=4096/0, pfn=1190433
sg87: dma=6ef6000, len=4096/0, pfn=1190391
sg88: dma=6ef7000, len=4096/0, pfn=1190349
sg89: dma=6ef8000, len=4096/0, pfn=1190138
sg90: dma=6ef9000, len=4096/0, pfn=1190307
sg91: dma=6efa000, len=4096/0, pfn=1190265
sg92: dma=6efb000, len=4096/0, pfn=1190180
sg93: dma=6efc000, len=4096/0, pfn=1190097
sg94: dma=6efd000, len=4096/0, pfn=1190055
sg95: dma=6efe000, len=4096/0, pfn=1191851
sg96: dma=6eff000, len=4096/0, pfn=1190013
sg97: dma=6f00000, len=4096/0, pfn=1189971
sg98: dma=6f01000, len=4096/0, pfn=1191935
sg99: dma=6f02000, len=4096/0, pfn=1194513
sg100: dma=6f03000, len=4096/0, pfn=1194261
sg101: dma=6f04000, len=4096/0, pfn=1194471
sg102: dma=6f05000, len=4096/0, pfn=1194429
sg103: dma=6f06000, len=4096/0, pfn=1194387
sg104: dma=6f07000, len=4096/0, pfn=1194345
sg105: dma=6f08000, len=4096/0, pfn=1194303
sg106: dma=6f09000, len=4096/0, pfn=1194218
sg107: dma=6f0a000, len=4096/0, pfn=1194135
sg108: dma=6f0b000, len=4096/0, pfn=1195973
sg109: dma=6f0c000, len=4096/0, pfn=1194093
sg110: dma=6f0d000, len=4096/0, pfn=1194051
sg111: dma=6f0e000, len=4096/0, pfn=1194009
sg112: dma=6f0f000, len=4096/0, pfn=1196015
sg113: dma=6f10000, len=4096/0, pfn=1195931
sg114: dma=6f11000, len=4096/0, pfn=1195889
sg115: dma=6f12000, len=4096/0, pfn=1195679
sg116: dma=6f13000, len=4096/0, pfn=1195847
sg117: dma=6f14000, len=4096/0, pfn=1195804
sg118: dma=6f15000, len=4096/0, pfn=1195763
sg119: dma=6f16000, len=4096/0, pfn=1195721
sg120: dma=6f17000, len=4096/0, pfn=1195637
sg121: dma=6f18000, len=4096/0, pfn=1195595
sg122: dma=6f19000, len=4096/0, pfn=1195553
sg123: dma=6f1a000, len=4096/0, pfn=1195470
sg124: dma=6f1b000, len=4096/0, pfn=1195428
sg125: dma=6f1c000, len=4096/0, pfn=1195386
sg126: dma=6f1d000, len=4096/0, pfn=1195260
sg127: dma=6f1e000, len=4096/0, pfn=1195218
sg128: dma=6f1f000, len=4096/0, pfn=1195176
sg129: dma=6f20000, len=4096/0, pfn=1197014
sg130: dma=6f21000, len=4096/0, pfn=1195134
sg131: dma=6f22000, len=4096/0, pfn=1195092
sg132: dma=6f23000, len=4096/0, pfn=1195050
sg133: dma=6f24000, len=4096/0, pfn=1195008
sg134: dma=6f25000, len=4096/0, pfn=1170485
sg135: dma=6f26000, len=4096/0, pfn=1170443
sg136: dma=6f27000, len=4096/0, pfn=1172281
sg137: dma=6f28000, len=4096/0, pfn=1172450
sg138: dma=6f29000, len=4096/0, pfn=1172408
sg139: dma=6f2a000, len=4096/0, pfn=1172366
sg140: dma=6f2b000, len=4096/0, pfn=1172323
sg141: dma=6f2c000, len=4096/0, pfn=1172239
sg142: dma=6f2d000, len=4096/0, pfn=1171905
sg143: dma=6f2e000, len=4096/0, pfn=1172155
sg144: dma=6f2f000, len=4096/0, pfn=1172113
sg145: dma=6f30000, len=4096/0, pfn=1172030
sg146: dma=6f31000, len=4096/0, pfn=1171989
sg147: dma=6f32000, len=4096/0, pfn=1171947
sg148: dma=6f33000, len=4096/0, pfn=1171862
sg149: dma=6f34000, len=4096/0, pfn=1171820
sg150: dma=6f35000, len=4096/0, pfn=1171778
sg151: dma=6f36000, len=4096/0, pfn=1171610
sg152: dma=6f37000, len=4096/0, pfn=1171736
sg153: dma=6f38000, len=4096/0, pfn=1171694
sg154: dma=6f39000, len=4096/0, pfn=1171652
sg155: dma=6f3a000, len=4096/0, pfn=1171568
sg156: dma=6f3b000, len=4096/0, pfn=1171527
sg157: dma=6f3c000, len=4096/0, pfn=1171485
sg158: dma=6f3d000, len=4096/0, pfn=1173322
sg159: dma=6f3e000, len=4096/0, pfn=1173491
sg160: dma=6f3f000, len=4096/0, pfn=1173448
sg161: dma=6f40000, len=4096/0, pfn=1173406
sg162: dma=6f41000, len=4096/0, pfn=1173280
sg163: dma=6f42000, len=4096/0, pfn=1173238
sg164: dma=6f43000, len=4096/0, pfn=1173196
sg165: dma=6f44000, len=4096/0, pfn=1173154
sg166: dma=6f45000, len=4096/0, pfn=1173113
sg167: dma=6f46000, len=4096/0, pfn=1173030
sg168: dma=6f47000, len=4096/0, pfn=1172987
sg169: dma=6f48000, len=4096/0, pfn=1172652
sg170: dma=6f49000, len=4096/0, pfn=1172568
sg171: dma=6f4a000, len=4096/0, pfn=1172526
sg172: dma=6f4b000, len=4096/0, pfn=1172483
sg173: dma=6f4c000, len=4096/0, pfn=1174489
sg174: dma=6f4d000, len=4096/0, pfn=1174238
sg175: dma=6f4e000, len=4096/0, pfn=1174196
sg176: dma=6f4f000, len=4096/0, pfn=1174154
sg177: dma=6f50000, len=4096/0, pfn=1174112
sg178: dma=6f51000, len=4096/0, pfn=1174069
sg179: dma=6f52000, len=4096/0, pfn=1173944
sg180: dma=6f53000, len=4096/0, pfn=1173651
sg181: dma=6f54000, len=4096/0, pfn=1173902
sg182: dma=6f55000, len=4096/0, pfn=1173860
sg183: dma=6f56000, len=4096/0, pfn=1173819
sg184: dma=6f57000, len=4096/0, pfn=1173777
sg185: dma=6f58000, len=4096/0, pfn=1173735
sg186: dma=6f59000, len=4096/0, pfn=1173608
sg187: dma=6f5a000, len=4096/0, pfn=1173566
sg188: dma=6f5b000, len=4096/0, pfn=1175363
sg189: dma=6f5c000, len=4096/0, pfn=1173524
sg190: dma=6f5d000, len=4096/0, pfn=1175530
sg191: dma=6f5e000, len=4096/0, pfn=1175488
sg192: dma=6f5f000, len=4096/0, pfn=1175026
sg193: dma=6f60000, len=4096/0, pfn=1174944
sg194: dma=6f61000, len=4096/0, pfn=1174692
sg195: dma=6f62000, len=4096/0, pfn=1174902
sg196: dma=6f63000, len=4096/0, pfn=1174860
sg197: dma=6f64000, len=4096/0, pfn=1174819
sg198: dma=6f65000, len=4096/0, pfn=1174776
sg199: dma=6f66000, len=4096/0, pfn=1174734
sg200: dma=6f67000, len=4096/0, pfn=1174650
sg201: dma=6f68000, len=4096/0, pfn=1176405
sg202: dma=6f69000, len=4096/0, pfn=1174566
sg203: dma=6f6a000, len=4096/0, pfn=1176572
sg204: dma=6f6b000, len=4096/0, pfn=1176531
sg205: dma=6f6c000, len=4096/0, pfn=1176489
sg206: dma=6f6d000, len=4096/0, pfn=1176447
sg207: dma=6f6e000, len=4096/0, pfn=1176362
sg208: dma=6f6f000, len=4096/0, pfn=1176320
sg209: dma=6f70000, len=4096/0, pfn=1176069
sg210: dma=6f71000, len=4096/0, pfn=1224020
sg211: dma=6f72000, len=4096/0, pfn=1176278
sg212: dma=6f73000, len=4096/0, pfn=1176236
sg213: dma=6f74000, len=4096/0, pfn=1176194
sg214: dma=6f75000, len=4096/0, pfn=1176152
sg215: dma=6f76000, len=4096/0, pfn=1176110
sg216: dma=6f77000, len=4096/0, pfn=1176027
sg217: dma=6f78000, len=4096/0, pfn=1175733
sg218: dma=6f79000, len=4096/0, pfn=1175944
sg219: dma=6f7a000, len=4096/0, pfn=1175901
sg220: dma=6f7b000, len=4096/0, pfn=1175859
sg221: dma=6f7c000, len=4096/0, pfn=1175817
sg222: dma=6f7d000, len=4096/0, pfn=1175775
sg223: dma=6f7e000, len=4096/0, pfn=1175691
sg224: dma=6f7f000, len=4096/0, pfn=1177445
sg225: dma=6f80000, len=4096/0, pfn=1175649
sg226: dma=6f81000, len=4096/0, pfn=1175608
sg227: dma=6f82000, len=4096/0, pfn=1175566
sg228: dma=6f83000, len=4096/0, pfn=1177572
sg229: dma=6f84000, len=4096/0, pfn=1177530
sg230: dma=6f85000, len=4096/0, pfn=1177403
sg231: dma=6f86000, len=4096/0, pfn=1177361
sg232: dma=6f87000, len=4096/0, pfn=1177110
sg233: dma=6f88000, len=4096/0, pfn=1177319
sg234: dma=6f89000, len=4096/0, pfn=1177277
sg235: dma=6f8a000, len=4096/0, pfn=1177235
sg236: dma=6f8b000, len=4096/0, pfn=1177194
sg237: dma=6f8c000, len=4096/0, pfn=1177152
sg238: dma=6f8d000, len=4096/0, pfn=1177068
sg239: dma=6f8e000, len=4096/0, pfn=1176774
sg240: dma=6f8f000, len=4096/0, pfn=1177026
sg241: dma=6f90000, len=4096/0, pfn=1176983
sg242: dma=6f91000, len=4096/0, pfn=1176858
sg243: dma=6f92000, len=4096/0, pfn=1176816
sg244: dma=6f93000, len=4096/0, pfn=1176733
sg245: dma=6f94000, len=4096/0, pfn=1176691
sg246: dma=6f95000, len=4096/0, pfn=1176649
sg247: dma=6f96000, len=4096/0, pfn=1178486
sg248: dma=6f97000, len=4096/0, pfn=1176607
sg249: dma=6f98000, len=4096/0, pfn=1178613
sg250: dma=6f99000, len=4096/0, pfn=1178570
sg251: dma=6f9a000, len=4096/0, pfn=1178528
sg252: dma=6f9b000, len=4096/0, pfn=1178444
sg253: dma=6f9c000, len=4096/0, pfn=1178402
sg254: dma=6f9d000, len=4096/0, pfn=1178151
sg255: dma=6f9e000, len=4096/0, pfn=1178360
hda: DMA table too small
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=724b800, len=4096/0, pfn=1067002
sg1: dma=724c800, len=4096/0, pfn=1224339
sg2: dma=724d800, len=4096/0, pfn=1224338
sg3: dma=724e800, len=4096/0, pfn=1224336
sg4: dma=724f800, len=4096/0, pfn=1224335
sg5: dma=7250800, len=4096/0, pfn=1224334
sg6: dma=7251800, len=4096/0, pfn=1224333
sg7: dma=7252800, len=4096/0, pfn=1224332
sg8: dma=7253800, len=4096/0, pfn=1227264
sg9: dma=7254800, len=4096/0, pfn=1244897
sg10: dma=7255800, len=4096/0, pfn=1244896
sg11: dma=7256800, len=4096/0, pfn=1224331
sg12: dma=7257800, len=4096/0, pfn=1224330
sg13: dma=7258800, len=4096/0, pfn=1224329
sg14: dma=7259800, len=4096/0, pfn=1224327
sg15: dma=725a800, len=4096/0, pfn=1224326
sg16: dma=725b800, len=4096/0, pfn=1224325
sg17: dma=725c800, len=4096/0, pfn=1224324
sg18: dma=725d800, len=4096/0, pfn=1224323
sg19: dma=725e800, len=4096/0, pfn=1224321
sg20: dma=725f800, len=4096/0, pfn=1224320
sg21: dma=7260800, len=4096/0, pfn=1224319
sg22: dma=7261800, len=4096/0, pfn=1224318
sg23: dma=7262800, len=4096/0, pfn=1224317
sg24: dma=7263800, len=4096/0, pfn=1224316
sg25: dma=7264800, len=4096/0, pfn=1224314
sg26: dma=7265800, len=4096/0, pfn=1224313
sg27: dma=7266800, len=4096/0, pfn=1224309
sg28: dma=7267800, len=4096/0, pfn=1224269
sg29: dma=7268800, len=4096/0, pfn=1224308
sg30: dma=7269800, len=4096/0, pfn=1224306
sg31: dma=726a800, len=4096/0, pfn=1224305
sg32: dma=726b800, len=4096/0, pfn=1224304
sg33: dma=726c800, len=4096/0, pfn=1224302
sg34: dma=726d800, len=4096/0, pfn=1224301
sg35: dma=726e800, len=4096/0, pfn=1224300
sg36: dma=726f800, len=4096/0, pfn=1224298
sg37: dma=7270800, len=4096/0, pfn=1224297
sg38: dma=7271800, len=4096/0, pfn=1224296
sg39: dma=7272800, len=4096/0, pfn=1224295
sg40: dma=7273800, len=4096/0, pfn=1224294
sg41: dma=7274800, len=4096/0, pfn=1224293
sg42: dma=7275800, len=4096/0, pfn=1224291
sg43: dma=7276800, len=4096/0, pfn=1224290
sg44: dma=7277800, len=4096/0, pfn=1224289
sg45: dma=7279000, len=4096/0, pfn=1224288
sg46: dma=727a000, len=4096/0, pfn=1224287
sg47: dma=727b000, len=4096/0, pfn=1224286
sg48: dma=727c000, len=4096/0, pfn=1224284
sg49: dma=727d000, len=4096/0, pfn=1224283
sg50: dma=727e000, len=4096/0, pfn=1224282
sg51: dma=727f000, len=4096/0, pfn=1224281
sg52: dma=7280000, len=4096/0, pfn=1224280
sg53: dma=7281000, len=4096/0, pfn=1224278
sg54: dma=7282000, len=4096/0, pfn=1224277
sg55: dma=7283000, len=4096/0, pfn=1224276
sg56: dma=7284000, len=4096/0, pfn=1224275
sg57: dma=7285000, len=4096/0, pfn=1224274
sg58: dma=7286000, len=4096/0, pfn=1224273
sg59: dma=7287000, len=4096/0, pfn=1224271
sg60: dma=7288000, len=4096/0, pfn=1224268
sg61: dma=7289000, len=4096/0, pfn=1224229
sg62: dma=728a000, len=4096/0, pfn=1224267
sg63: dma=728b000, len=4096/0, pfn=1224265
sg64: dma=728c000, len=4096/0, pfn=1224264
sg65: dma=728d000, len=4096/0, pfn=1224263
sg66: dma=728e000, len=4096/0, pfn=1224262
sg67: dma=728f000, len=4096/0, pfn=1224261
sg68: dma=7290000, len=4096/0, pfn=1224260
sg69: dma=7291000, len=4096/0, pfn=1224258
sg70: dma=7292000, len=4096/0, pfn=1224257
sg71: dma=7293000, len=4096/0, pfn=1224256
sg72: dma=7294000, len=4096/0, pfn=1224254
sg73: dma=7295000, len=4096/0, pfn=1224253
sg74: dma=7296000, len=4096/0, pfn=1224252
sg75: dma=7297000, len=4096/0, pfn=1224250
sg76: dma=7298000, len=4096/0, pfn=1224249
sg77: dma=7299000, len=4096/0, pfn=1224248
sg78: dma=729a000, len=4096/0, pfn=1224247
sg79: dma=729b000, len=4096/0, pfn=1224246
sg80: dma=729c000, len=4096/0, pfn=1224244
sg81: dma=729d000, len=4096/0, pfn=1224243
sg82: dma=729e000, len=4096/0, pfn=1224242
sg83: dma=729f000, len=4096/0, pfn=1224241
sg84: dma=72a0000, len=4096/0, pfn=1224240
sg85: dma=72a1000, len=4096/0, pfn=1224239
sg86: dma=72a2000, len=4096/0, pfn=1224237
sg87: dma=72a3000, len=4096/0, pfn=1224236
sg88: dma=72a4000, len=4096/0, pfn=1224235
sg89: dma=72a5000, len=4096/0, pfn=1224234
sg90: dma=72a6000, len=4096/0, pfn=1224233
sg91: dma=72a7000, len=4096/0, pfn=1224232
sg92: dma=72a8000, len=4096/0, pfn=1224228
sg93: dma=72a9000, len=4096/0, pfn=1224189
sg94: dma=72aa000, len=4096/0, pfn=1224227
sg95: dma=72ab000, len=4096/0, pfn=1224226
sg96: dma=72ac000, len=4096/0, pfn=1224225
sg97: dma=72ad000, len=4096/0, pfn=1224223
sg98: dma=72ae000, len=4096/0, pfn=1224222
sg99: dma=72af000, len=4096/0, pfn=1224221
sg100: dma=72b0000, len=4096/0, pfn=1224220
sg101: dma=72b1000, len=4096/0, pfn=1224219
sg102: dma=72b2000, len=4096/0, pfn=1224218
sg103: dma=72b3000, len=4096/0, pfn=1224216
sg104: dma=72b4000, len=4096/0, pfn=1224215
sg105: dma=72b5000, len=4096/0, pfn=1224214
sg106: dma=72b6000, len=4096/0, pfn=1224213
sg107: dma=72b7000, len=4096/0, pfn=1224212
sg108: dma=72b8000, len=4096/0, pfn=1224211
sg109: dma=72b9000, len=4096/0, pfn=1224209
sg110: dma=72ba000, len=4096/0, pfn=1224208
sg111: dma=72bb000, len=4096/0, pfn=1224207
sg112: dma=72bc000, len=4096/0, pfn=1224206
sg113: dma=72bd000, len=4096/0, pfn=1224205
sg114: dma=72be000, len=4096/0, pfn=1224203
sg115: dma=72bf000, len=4096/0, pfn=1224202
sg116: dma=72c0000, len=4096/0, pfn=1224200
sg117: dma=72c1000, len=4096/0, pfn=1224199
sg118: dma=72c2000, len=4096/0, pfn=1224198
sg119: dma=72c3000, len=4096/0, pfn=1224197
sg120: dma=72c4000, len=4096/0, pfn=1224195
sg121: dma=72c5000, len=4096/0, pfn=1224194
sg122: dma=72c6000, len=4096/0, pfn=1224193
sg123: dma=72c7000, len=4096/0, pfn=1224192
sg124: dma=72c8000, len=4096/0, pfn=1224191
sg125: dma=72c9000, len=4096/0, pfn=1224188
sg126: dma=72ca000, len=4096/0, pfn=1224149
sg127: dma=72cb000, len=4096/0, pfn=1224187
sg128: dma=72cc000, len=4096/0, pfn=1224186
sg129: dma=72cd000, len=4096/0, pfn=1224185
sg130: dma=72ce000, len=4096/0, pfn=1224184
sg131: dma=72cf000, len=4096/0, pfn=1224182
sg132: dma=72d0000, len=4096/0, pfn=1224181
sg133: dma=72d1000, len=4096/0, pfn=1224180
sg134: dma=72d2000, len=4096/0, pfn=1224179
sg135: dma=72d3000, len=4096/0, pfn=1224178
sg136: dma=72d4000, len=4096/0, pfn=1224176
sg137: dma=72d5000, len=4096/0, pfn=1224174
sg138: dma=72d6000, len=4096/0, pfn=1224173
sg139: dma=72d7000, len=4096/0, pfn=1224172
sg140: dma=72d8000, len=4096/0, pfn=1224171
sg141: dma=72d9000, len=4096/0, pfn=1224170
sg142: dma=72da000, len=4096/0, pfn=1224168
sg143: dma=72db000, len=4096/0, pfn=1224167
sg144: dma=72dc000, len=4096/0, pfn=1224166
sg145: dma=72dd000, len=4096/0, pfn=1224165
sg146: dma=72de000, len=4096/0, pfn=1224164
sg147: dma=72df000, len=4096/0, pfn=1224163
sg148: dma=72e0000, len=4096/0, pfn=1224160
sg149: dma=72e1000, len=4096/0, pfn=1224159
sg150: dma=72e2000, len=4096/0, pfn=1224158
sg151: dma=72e3000, len=4096/0, pfn=1224157
sg152: dma=72e4000, len=4096/0, pfn=1224156
sg153: dma=72e5000, len=4096/0, pfn=1224154
sg154: dma=72e6000, len=4096/0, pfn=1224153
sg155: dma=72e7000, len=4096/0, pfn=1224152
sg156: dma=72e8000, len=4096/0, pfn=1224151
sg157: dma=72e9000, len=4096/0, pfn=1224147
sg158: dma=72ea000, len=4096/0, pfn=1224109
sg159: dma=72eb000, len=4096/0, pfn=1224146
sg160: dma=72ec000, len=4096/0, pfn=1224144
sg161: dma=72ed000, len=4096/0, pfn=1224143
sg162: dma=72ee000, len=4096/0, pfn=1224142
sg163: dma=72ef000, len=4096/0, pfn=1224141
sg164: dma=72f0000, len=4096/0, pfn=1224140
sg165: dma=72f1000, len=4096/0, pfn=1224138
sg166: dma=72f2000, len=4096/0, pfn=1224137
sg167: dma=72f3000, len=4096/0, pfn=1224136
sg168: dma=72f4000, len=4096/0, pfn=1224135
sg169: dma=72f5000, len=4096/0, pfn=1224134
sg170: dma=72f6000, len=4096/0, pfn=1224132
sg171: dma=72f7000, len=4096/0, pfn=1224131
sg172: dma=72f8000, len=4096/0, pfn=1224130
sg173: dma=72f9000, len=4096/0, pfn=1224129
sg174: dma=72fa000, len=4096/0, pfn=1224128
sg175: dma=72fb000, len=4096/0, pfn=1224127
sg176: dma=72fc000, len=4096/0, pfn=1224125
sg177: dma=72fd000, len=4096/0, pfn=1224124
sg178: dma=72fe000, len=4096/0, pfn=1224123
sg179: dma=72ff000, len=4096/0, pfn=1224122
sg180: dma=7300000, len=4096/0, pfn=1224121
sg181: dma=7301000, len=4096/0, pfn=1224120
sg182: dma=7302000, len=4096/0, pfn=1224118
sg183: dma=7303000, len=4096/0, pfn=1224117
sg184: dma=7304000, len=4096/0, pfn=1224116
sg185: dma=7305000, len=4096/0, pfn=1224115
sg186: dma=7306000, len=4096/0, pfn=1224114
sg187: dma=7307000, len=4096/0, pfn=1224112
sg188: dma=7308000, len=4096/0, pfn=1224111
sg189: dma=7309000, len=4096/0, pfn=1224110
sg190: dma=730a000, len=4096/0, pfn=1224108
sg191: dma=730b000, len=4096/0, pfn=1224070
sg192: dma=730c000, len=4096/0, pfn=1224106
sg193: dma=730d000, len=4096/0, pfn=1224105
sg194: dma=730e000, len=4096/0, pfn=1224104
sg195: dma=730f000, len=4096/0, pfn=1224103
sg196: dma=7310000, len=4096/0, pfn=1224102
sg197: dma=7311000, len=4096/0, pfn=1224101
sg198: dma=7312000, len=4096/0, pfn=1224099
sg199: dma=7313000, len=4096/0, pfn=1224098
sg200: dma=7314000, len=4096/0, pfn=1224097
sg201: dma=7315000, len=4096/0, pfn=1224096
sg202: dma=7316000, len=4096/0, pfn=1224095
sg203: dma=7317000, len=4096/0, pfn=1224094
sg204: dma=7318000, len=4096/0, pfn=1224091
sg205: dma=7319000, len=4096/0, pfn=1224090
sg206: dma=731a000, len=4096/0, pfn=1224089
sg207: dma=731b000, len=4096/0, pfn=1224088
sg208: dma=731c000, len=4096/0, pfn=1224087
sg209: dma=731d000, len=4096/0, pfn=1224086
sg210: dma=731e000, len=4096/0, pfn=1224084
sg211: dma=731f000, len=4096/0, pfn=1224083
sg212: dma=7320000, len=4096/0, pfn=1224082
sg213: dma=7321000, len=4096/0, pfn=1224081
sg214: dma=7322000, len=4096/0, pfn=1224080
sg215: dma=7323000, len=4096/0, pfn=1224078
sg216: dma=7324000, len=4096/0, pfn=1224077
sg217: dma=7325000, len=4096/0, pfn=1224076
sg218: dma=7326000, len=4096/0, pfn=1224075
sg219: dma=7327000, len=4096/0, pfn=1224074
sg220: dma=7328000, len=4096/0, pfn=1224073
sg221: dma=7329000, len=4096/0, pfn=1224071
sg222: dma=732a000, len=4096/0, pfn=1224069
sg223: dma=732b000, len=4096/0, pfn=1224030
sg224: dma=732c000, len=4096/0, pfn=1224068
sg225: dma=732d000, len=4096/0, pfn=1224067
sg226: dma=732e000, len=4096/0, pfn=1224065
sg227: dma=732f000, len=4096/0, pfn=1224064
sg228: dma=7330000, len=4096/0, pfn=1224063
sg229: dma=7331000, len=4096/0, pfn=1224062
sg230: dma=7332000, len=4096/0, pfn=1224061
sg231: dma=7333000, len=4096/0, pfn=1224060
sg232: dma=7334000, len=4096/0, pfn=1224058
sg233: dma=7335000, len=4096/0, pfn=1224057
sg234: dma=7336000, len=4096/0, pfn=1224056
sg235: dma=7337000, len=4096/0, pfn=1224055
sg236: dma=7338000, len=4096/0, pfn=1224054
sg237: dma=7339000, len=4096/0, pfn=1224053
sg238: dma=733a000, len=4096/0, pfn=1224051
sg239: dma=733b000, len=4096/0, pfn=1224050
sg240: dma=733c000, len=4096/0, pfn=1224049
sg241: dma=733d000, len=4096/0, pfn=1224048
sg242: dma=733e000, len=4096/0, pfn=1224047
sg243: dma=733f000, len=4096/0, pfn=1224045
sg244: dma=7340000, len=4096/0, pfn=1224044
sg245: dma=7341000, len=4096/0, pfn=1224043
sg246: dma=7342000, len=4096/0, pfn=1224042
sg247: dma=7343000, len=4096/0, pfn=1224041
sg248: dma=7344000, len=4096/0, pfn=1224039
sg249: dma=7345000, len=4096/0, pfn=1224037
sg250: dma=7346000, len=4096/0, pfn=1224036
sg251: dma=7347000, len=4096/0, pfn=1224035
sg252: dma=7348000, len=4096/0, pfn=1224034
sg253: dma=7349000, len=4096/0, pfn=1224033
sg254: dma=734a000, len=4096/0, pfn=1224032
sg255: dma=734b000, len=4096/0, pfn=1224029
hda: DMA table too small
ide dma table, 256 entries, bounce pfn 1310720
sg0: dma=b7faf000, len=4096/0, pfn=753583
sg1: dma=b79b4000, len=4096/0, pfn=752052
sg2: dma=95cc000, len=4096/0, pfn=1208756
sg3: dma=95cd000, len=4096/0, pfn=1209286
sg4: dma=b7607000, len=4096/0, pfn=751111
sg5: dma=95ce000, len=4096/0, pfn=1225664
sg6: dma=b6cad000, len=4096/0, pfn=748717
sg7: dma=b6e26000, len=4096/0, pfn=749094
sg8: dma=b688b000, len=4096/0, pfn=747659
sg9: dma=b6a2b000, len=4096/0, pfn=748075
sg10: dma=95cf800, len=4096/0, pfn=1204806
sg11: dma=95d0800, len=4096/0, pfn=1203283
sg12: dma=b60f3000, len=4096/0, pfn=745715
sg13: dma=b6300000, len=4096/0, pfn=746240
sg14: dma=95d1800, len=4096/0, pfn=1202669
sg15: dma=95d2800, len=4096/0, pfn=1201342
sg16: dma=95d3800, len=4096/0, pfn=1201695
sg17: dma=b5b09000, len=4096/0, pfn=744201
sg18: dma=b5560000, len=4096/0, pfn=742752
sg19: dma=b5723000, len=4096/0, pfn=743203
sg20: dma=95d4800, len=4096/0, pfn=1225607
sg21: dma=95d5800, len=4096/0, pfn=1199733
sg22: dma=95d6800, len=4096/0, pfn=1198396
sg23: dma=95d7800, len=4096/0, pfn=1198848
sg24: dma=95d8800, len=4096/0, pfn=1197381
sg25: dma=b49b4000, len=4096/0, pfn=739764
sg26: dma=b440e000, len=4096/0, pfn=738318
sg27: dma=95d9800, len=4096/0, pfn=1196964
sg28: dma=b4014000, len=4096/0, pfn=737300
sg29: dma=b421b000, len=4096/0, pfn=737819
sg30: dma=b3c67000, len=4096/0, pfn=736359
sg31: dma=b3e15000, len=4096/0, pfn=736789
sg32: dma=95da800, len=4096/0, pfn=1193402
sg33: dma=95db800, len=4096/0, pfn=1225629
sg34: dma=95dc800, len=4096/0, pfn=1192489
sg35: dma=b3785000, len=4096/0, pfn=735109
sg36: dma=b315b000, len=4096/0, pfn=733531
sg37: dma=95dd800, len=4096/0, pfn=1190222
sg38: dma=95de800, len=4096/0, pfn=1190704
sg39: dma=95df800, len=4096/0, pfn=1189057
sg40: dma=95e0800, len=4096/0, pfn=1189567
sg41: dma=b2939000, len=4096/0, pfn=731449
sg42: dma=b25bb000, len=4096/0, pfn=730555
sg43: dma=b204e000, len=4096/0, pfn=729166
sg44: dma=95e1800, len=4096/0, pfn=1186102
sg45: dma=95e2800, len=4096/0, pfn=1186320
sg46: dma=95e3800, len=4096/0, pfn=1186776
sg47: dma=95e4800, len=4096/0, pfn=1225612
sg48: dma=b1948000, len=4096/0, pfn=727368
sg49: dma=b1447000, len=4096/0, pfn=726087
sg50: dma=95e5800, len=4096/0, pfn=1182875
sg51: dma=95e6800, len=4096/0, pfn=1183454
sg52: dma=95e7800, len=4096/0, pfn=1225571
sg53: dma=95e8800, len=4096/0, pfn=1182057
sg54: dma=95e9800, len=4096/0, pfn=1182463
sg55: dma=b08ab000, len=4096/0, pfn=723115
sg56: dma=b08d0000, len=4096/0, pfn=723152
sg57: dma=b0bd5000, len=4096/0, pfn=723925
sg58: dma=95ea800, len=4096/0, pfn=1180475
sg59: dma=95eb800, len=4096/0, pfn=1178861
sg60: dma=b0295000, len=4096/0, pfn=721557
sg61: dma=95ec800, len=4096/0, pfn=1266062
sg62: dma=95ed800, len=4096/0, pfn=1176735
sg63: dma=af89e000, len=4096/0, pfn=719006
sg64: dma=af9b4000, len=4096/0, pfn=719284
sg65: dma=af4a8000, len=4096/0, pfn=717992
sg66: dma=95ee800, len=4096/0, pfn=1176554
sg67: dma=95ef800, len=4096/0, pfn=1175190
sg68: dma=aec5e000, len=4096/0, pfn=715870
sg69: dma=95f0800, len=4096/0, pfn=1174284
sg70: dma=95f1800, len=4096/0, pfn=1172750
sg71: dma=95f2800, len=4096/0, pfn=1173272
sg72: dma=aeba1000, len=4096/0, pfn=715681
sg73: dma=95f3800, len=4096/0, pfn=1171887
sg74: dma=ae7f3000, len=4096/0, pfn=714739
sg75: dma=95f4800, len=4096/0, pfn=1225582
sg76: dma=adc68000, len=4096/0, pfn=711784
sg77: dma=95f5800, len=4096/0, pfn=1168456
sg78: dma=ad97c000, len=4096/0, pfn=711036
sg79: dma=95f6800, len=4096/0, pfn=1167416
sg80: dma=95f7800, len=4096/0, pfn=1166598
sg81: dma=ad10e000, len=4096/0, pfn=708878
sg82: dma=95f9000, len=4096/0, pfn=1165571
sg83: dma=95fa000, len=4096/0, pfn=1165825
sg84: dma=95fb000, len=4096/0, pfn=1164592
sg85: dma=95fc000, len=4096/0, pfn=1225480
sg86: dma=ac9d0000, len=4096/0, pfn=707024
sg87: dma=acb38000, len=4096/0, pfn=707384
sg88: dma=95fd000, len=4096/0, pfn=1163696
sg89: dma=95fe000, len=4096/0, pfn=1164061
sg90: dma=95ff000, len=4096/0, pfn=1225565
sg91: dma=ac14f000, len=4096/0, pfn=704847
sg92: dma=ad910000, len=4096/0, pfn=710928
sg93: dma=9600000, len=4096/0, pfn=1161833
sg94: dma=abf93000, len=4096/0, pfn=704403
sg95: dma=aba5d000, len=4096/0, pfn=703069
sg96: dma=9601000, len=4096/0, pfn=1159577
sg97: dma=9602000, len=4096/0, pfn=1162011
sg98: dma=9603000, len=4096/0, pfn=1158506
sg99: dma=ab17e000, len=4096/0, pfn=700798
sg100: dma=9604000, len=4096/0, pfn=1157612
sg101: dma=aac0b000, len=4096/0, pfn=699403
sg102: dma=aa8d2000, len=4096/0, pfn=698578
sg103: dma=9605000, len=4096/0, pfn=1155133
sg104: dma=9606000, len=4096/0, pfn=1225549
sg105: dma=aa6a9000, len=4096/0, pfn=698025
sg106: dma=aa173000, len=4096/0, pfn=696691
sg107: dma=aa335000, len=4096/0, pfn=697141
sg108: dma=a9d5b000, len=4096/0, pfn=695643
sg109: dma=9607000, len=4096/0, pfn=1152239
sg110: dma=9608000, len=4096/0, pfn=1152821
sg111: dma=9609000, len=4096/0, pfn=1151501
sg112: dma=a957f000, len=4096/0, pfn=693631
sg113: dma=a902f000, len=4096/0, pfn=692271
sg114: dma=960a000, len=4096/0, pfn=1150727
sg115: dma=a8ce8000, len=4096/0, pfn=691432
sg116: dma=960b000, len=4096/0, pfn=1147956
sg117: dma=960c000, len=4096/0, pfn=1225481
sg118: dma=960d000, len=4096/0, pfn=1265927
sg119: dma=a8aa7000, len=4096/0, pfn=690855
sg120: dma=960e000, len=4096/0, pfn=1147539
sg121: dma=a8672000, len=4096/0, pfn=689778
sg122: dma=a860d000, len=4096/0, pfn=689677
sg123: dma=960f000, len=4096/0, pfn=1145214
sg124: dma=a7e00000, len=4096/0, pfn=687616
sg125: dma=a7845000, len=4096/0, pfn=686149
sg126: dma=a7831000, len=4096/0, pfn=686129
sg127: dma=9610000, len=4096/0, pfn=1225458
sg128: dma=a7646000, len=4096/0, pfn=685638
sg129: dma=a70c3000, len=4096/0, pfn=684227
sg130: dma=9611000, len=4096/0, pfn=1142614
sg131: dma=a6ca7000, len=4096/0, pfn=683175
sg132: dma=a6eea000, len=4096/0, pfn=683754
sg133: dma=a68ff000, len=4096/0, pfn=682239
sg134: dma=9612000, len=4096/0, pfn=1222724
sg135: dma=697e2000, len=4096/0, pfn=432098
sg136: dma=9613000, len=4096/0, pfn=1221919
sg137: dma=9614000, len=4096/0, pfn=1139509
sg138: dma=a67bc000, len=4096/0, pfn=681916
sg139: dma=a6234000, len=4096/0, pfn=680500
sg140: dma=9615000, len=4096/0, pfn=1136752
sg141: dma=9616000, len=4096/0, pfn=1137359
sg142: dma=a5801000, len=4096/0, pfn=677889
sg143: dma=9617000, len=4096/0, pfn=1136524
sg144: dma=9618000, len=4096/0, pfn=1134927
sg145: dma=9619000, len=4096/0, pfn=1133595
sg146: dma=a5006000, len=4096/0, pfn=675846
sg147: dma=961a000, len=4096/0, pfn=1132572
sg148: dma=961b000, len=4096/0, pfn=1133165
sg149: dma=a4f06000, len=4096/0, pfn=675590
sg150: dma=961c000, len=4096/0, pfn=1221902
sg151: dma=961d800, len=4096/0, pfn=1132454
sg152: dma=961e800, len=4096/0, pfn=1221862
sg153: dma=a459c000, len=4096/0, pfn=673180
sg154: dma=961f800, len=4096/0, pfn=1129645
sg155: dma=9620800, len=4096/0, pfn=1130049
sg156: dma=a4336000, len=4096/0, pfn=672566
sg157: dma=a3e0a000, len=4096/0, pfn=671242
sg158: dma=9621800, len=4096/0, pfn=1129458
sg159: dma=a3a4b000, len=4096/0, pfn=670283
sg160: dma=9622800, len=4096/0, pfn=1126774
sg161: dma=a3563000, len=4096/0, pfn=669027
sg162: dma=a3003000, len=4096/0, pfn=667651
sg163: dma=9623800, len=4096/0, pfn=1126141
sg164: dma=a2c99000, len=4096/0, pfn=666777
sg165: dma=9624800, len=4096/0, pfn=1221885
sg166: dma=a29fa000, len=4096/0, pfn=666106
sg167: dma=a2b6f000, len=4096/0, pfn=666479
sg168: dma=a25a2000, len=4096/0, pfn=664994
sg169: dma=9625800, len=4096/0, pfn=1121282
sg170: dma=9626800, len=4096/0, pfn=1121882
sg171: dma=a1c0e000, len=4096/0, pfn=662542
sg172: dma=9627800, len=4096/0, pfn=1121147
sg173: dma=a18bb000, len=4096/0, pfn=661691
sg174: dma=9628800, len=4096/0, pfn=1120121
sg175: dma=a1505000, len=4096/0, pfn=660741
sg176: dma=a1724000, len=4096/0, pfn=661284
sg177: dma=9629800, len=4096/0, pfn=1116777
sg178: dma=962a800, len=4096/0, pfn=1115188
sg179: dma=962b800, len=4096/0, pfn=1221868
sg180: dma=962c800, len=4096/0, pfn=1232088
sg181: dma=962d800, len=4096/0, pfn=1233027
sg182: dma=9faff000, len=4096/0, pfn=654079
sg183: dma=962e800, len=4096/0, pfn=1112769
sg184: dma=9f726000, len=4096/0, pfn=653094
sg185: dma=962f800, len=4096/0, pfn=1221824
sg186: dma=9630800, len=4096/0, pfn=1110606
sg187: dma=9edf9000, len=4096/0, pfn=650745
sg188: dma=9e8f7000, len=4096/0, pfn=649463
sg189: dma=9631800, len=4096/0, pfn=1108249
sg190: dma=9e48f000, len=4096/0, pfn=648335
sg191: dma=9e7a3000, len=4096/0, pfn=649123
sg192: dma=9632800, len=4096/0, pfn=1107834
sg193: dma=9633800, len=4096/0, pfn=1221852
sg194: dma=9de5f000, len=4096/0, pfn=646751
sg195: dma=9d864000, len=4096/0, pfn=645220
sg196: dma=9635800, len=4096/0, pfn=1104256
sg197: dma=9d413000, len=4096/0, pfn=644115
sg198: dma=9d1e8000, len=4096/0, pfn=643560
sg199: dma=9cc5a000, len=4096/0, pfn=642138
sg200: dma=9cff6000, len=4096/0, pfn=643062
sg201: dma=9c4ab000, len=4096/0, pfn=640171
sg202: dma=9c790000, len=4096/0, pfn=640912
sg203: dma=9636800, len=4096/0, pfn=1098015
sg204: dma=9bd2f000, len=4096/0, pfn=638255
sg205: dma=9bfd3000, len=4096/0, pfn=638931
sg206: dma=9ba8e000, len=4096/0, pfn=637582
sg207: dma=9637800, len=4096/0, pfn=1221834
sg208: dma=9b77b000, len=4096/0, pfn=636795
sg209: dma=9b1f2000, len=4096/0, pfn=635378
sg210: dma=9639000, len=4096/0, pfn=1094604
sg211: dma=9aa0d000, len=4096/0, pfn=633357
sg212: dma=963a000, len=4096/0, pfn=1091699
sg213: dma=9a70b000, len=4096/0, pfn=632587
sg214: dma=9a035000, len=4096/0, pfn=630837
sg215: dma=963b000, len=4096/0, pfn=1091576
sg216: dma=963c000, len=4096/0, pfn=1090291
sg217: dma=963d000, len=4096/0, pfn=1221784
sg218: dma=98c8b000, len=4096/0, pfn=625803
sg219: dma=98e6f000, len=4096/0, pfn=626287
sg220: dma=963e000, len=4096/0, pfn=1088257
sg221: dma=963f000, len=4096/0, pfn=1221818
sg222: dma=97d1e000, len=4096/0, pfn=621854
sg223: dma=9640000, len=4096/0, pfn=1085880
sg224: dma=9641000, len=4096/0, pfn=1084486
sg225: dma=9642000, len=4096/0, pfn=1085115
sg226: dma=96c8e000, len=4096/0, pfn=617614
sg227: dma=96e47000, len=4096/0, pfn=618055
sg228: dma=9643000, len=4096/0, pfn=1082851
sg229: dma=964f1000, len=4096/0, pfn=615665
sg230: dma=96660000, len=4096/0, pfn=616032
sg231: dma=961d5000, len=4096/0, pfn=614869
sg232: dma=9644000, len=4096/0, pfn=1080727
sg233: dma=9645000, len=4096/0, pfn=1081323
sg234: dma=9646000, len=4096/0, pfn=1079852
sg235: dma=9647000, len=4096/0, pfn=1221801
sg236: dma=954d4000, len=4096/0, pfn=611540
sg237: dma=956f8000, len=4096/0, pfn=612088
sg238: dma=950bd000, len=4096/0, pfn=610493
sg239: dma=9528c000, len=4096/0, pfn=610956
sg240: dma=9648000, len=4096/0, pfn=1076990
sg241: dma=9649000, len=4096/0, pfn=1075291
sg242: dma=948d3000, len=4096/0, pfn=608467
sg243: dma=94b25000, len=4096/0, pfn=609061
sg244: dma=9449b000, len=4096/0, pfn=607387
sg245: dma=964a000, len=4096/0, pfn=1073483
sg246: dma=964b000, len=4096/0, pfn=1073949
sg247: dma=964c000, len=4096/0, pfn=1072438
sg248: dma=964d000, len=4096/0, pfn=1072865
sg249: dma=93fec000, len=4096/0, pfn=606188
sg250: dma=7eac4000, len=4096/0, pfn=518852
sg251: dma=93997000, len=4096/0, pfn=604567
sg252: dma=964e000, len=4096/0, pfn=1077105
sg253: dma=964f000, len=4096/0, pfn=1070987
sg254: dma=93013000, len=4096/0, pfn=602131
sg255: dma=b6fcf000, len=4096/0, pfn=749519

-- 
Andy, BlueArc Engineering
