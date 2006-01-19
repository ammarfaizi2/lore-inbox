Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWASPLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWASPLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWASPLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:11:49 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:13841 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1161207AbWASPLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:11:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Out of Memory: Killed process 16498 (java).
Date: Thu, 19 Jan 2006 15:11:45 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Out of Memory: Killed process 16498 (java).
Thread-Index: AcYc3O4ptYfT18gTQbOXqfX/OfrRSwALWtfg
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please add this patch, retest?

Dmesg now reports:

# dmesg
Bootdata ok (command line is root=/dev/hda1 ro )
Linux version 2.6.15-1-amd64-k8 (Debian 2.6.15-1) (luther@debian.org)
(gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #2 Thu Jan 19
13:00:18 GMT 2006
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
time.c: Detected 2202.924 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x5c39000 - 0x9c39000
Memory: 4045192k/5242880k available (1703k kernel code, 148144k
reserved, 738k data, 148k init)
Calibrating delay using timer specific routine.. 4412.87 BogoMIPS
(lpj=2206436)
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
agpgart: AGP aperture is 64M @ 0xec000000
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
audit(1137682942.372:1): initialized
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
input: AT Translated Set 2 keyboard as /class/input/input0
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
hda: HDS722525VLAT80, ATA DISK drive
hdb: Maxtor 6Y200P0, ATA DISK drive
isa bounce pool size: 16 pages
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
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
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
USB Universal Host Controller Interface driver v2.3
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 2
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 18, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
libata version 1.20 loaded.
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
skge 1.2 addr 0xfa900000 irq 19 chip Yukon-Lite rev 7
skge eth0: addr 00:11:2f:a7:fb:ef
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 2
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
input: PC Speaker as /class/input/input1
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 20
e100: eth1: e100_probe: addr 0xfac00000, irq 20, MAC addr
00:D0:B7:BF:92:C8
sata_promise 0000:00:08.0: version 1.03
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 20
ata1: SATA max UDMA/133 cmd 0xFFFFC20000006200 ctl 0xFFFFC20000006238
bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xFFFFC20000006280 ctl 0xFFFFC200000062B8
bmdma 0x0 irq 20
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 2
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 18, io base 0x0000e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 2
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 18, io base 0x0000e400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 2
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 18, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via 0000:00:0f.0: routed to hard irq line 1
ata3: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
ata4: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
ata3: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003
88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
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
e100: intel: e100_watchdog: link up, 100Mbps, half-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
pnp: the driver 'parport_pc' has been registered
lp: driver loaded but no devices found
intel: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
mtrr: type mismatch for f0000000,8000000 old: write-back new:
write-combining
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:155
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:150
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       43224kB (0kB HighMem)
Active:48792 inactive:903480 dirty:404079 writeback:90 unstable:0
free:10806 slab:37887 mapped:48269 pagetables:1588
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:34928kB min:6052kB low:7564kB high:9076kB active:700kB
inactive:2845172kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:8276kB min:2036kB low:2544kB high:3052kB active:194468kB
inactive:768748kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4390*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 34928kB
Normal: 863*4kB 85*8kB 45*16kB 17*32kB 9*64kB 6*128kB 0*256kB 1*512kB
1*1024kB 0*2048kB 0*4096kB = 8276kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
940324 pages shared
38 pages swap cached
Out of Memory: Killed process 6780 (java).
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:178
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:160
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404087 writeback:90 unstable:0
free:21942 slab:37866 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936211 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:178
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:161
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404087 writeback:90 unstable:0
free:21942 slab:37865 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936211 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:170
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404087 writeback:90 unstable:0
free:21942 slab:37855 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936211 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:177
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404070 writeback:45 unstable:0
free:21942 slab:37848 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936211 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:177
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404070 writeback:45 unstable:0
free:21942 slab:37848 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936211 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:177
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404070 writeback:39 unstable:0
free:21942 slab:37848 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936211 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:176
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903473 dirty:404070 writeback:28 unstable:0
free:21942 slab:37848 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:2 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768744kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936213 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:176
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903474 dirty:404070 writeback:13 unstable:0
free:21942 slab:37848 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:4 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768748kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936212 pages shared
38 pages swap cached
oom-killer: gfp_mask=0xd1, order=0

Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
<ffffffff8014f4b0>{__alloc_pages+536}
       <ffffffff80169788>{bio_alloc_bioset+232}
<ffffffff80169d03>{bio_copy_user+218}
       <ffffffff801bd657>{blk_rq_map_user+136}
<ffffffff801c0008>{sg_io+328}
       <ffffffff801c047c>{scsi_cmd_ioctl+491}
<ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
       <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
<ffffffff802a6db6>{schedule_timeout+158}
       <ffffffff801bf165>{blkdev_ioctl+1365}
<ffffffff80243cb2>{sys_sendto+251}
       <ffffffff801751e5>{__pollwait+0}
<ffffffff8016b16a>{block_ioctl+25}
       <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
       <ffffffff80174cb4>{sys_ioctl+89}
<ffffffff8010e4ba>{system_call+126}
       
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:179
cpu 0 cold: low 0, high 62, batch 15 used:56
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:174
cpu 0 cold: low 0, high 62, batch 15 used:53
HighMem per-cpu: empty
Free pages:       87768kB (0kB HighMem)
Active:37781 inactive:903474 dirty:404070 writeback:4 unstable:0
free:21942 slab:37848 mapped:37226 pagetables:1509
DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
present:12740kB pages_scanned:4 all_unreclaimable? yes
lowmem_reserve[]: 0 2999 4009 4009
DMA32 free:35300kB min:6052kB low:7564kB high:9076kB active:260kB
inactive:2845148kB present:3071904kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 1010 1010
Normal free:52448kB min:2036kB low:2544kB high:3052kB active:150864kB
inactive:768748kB present:1034240kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 20kB
DMA32: 4483*4kB 61*8kB 43*16kB 36*32kB 37*64kB 11*128kB 0*256kB 0*512kB
1*1024kB 1*2048kB 2*4096kB = 35300kB
Normal: 1618*4kB 479*8kB 324*16kB 231*32kB 124*64kB 59*128kB 21*256kB
9*512kB 2*1024kB 1*2048kB 0*4096kB = 52448kB
HighMem: empty
Swap cache: add 38, delete 0, find 0/0, race 0+0
Free swap  = 9686816kB
Total swap = 9686968kB
Free swap:       9686816kB
1310720 pages of RAM
299467 reserved pages
936216 pages shared
38 pages swap cached
Out of Memory: Killed process 6179 (nautilus).
Out of Memory: Killed process 6203 (clock-applet).
Out of Memory: Killed process 6141 (ssh-agent).
Out of Memory: Killed process 6957 (gnome-session).
Out of Memory: Killed process 6158 (gnome-settings-).
Out of Memory: Killed process 6166 (gnome-settings-).
Out of Memory: Killed process 6205 (mixer_applet2).
Out of Memory: Killed process 6175 (gnome-panel).
Out of Memory: Killed process 6181 (wnck-applet).
Out of Memory: Killed process 6190 (multiload-apple).

-- 
Andy, BlueArc Engineering
