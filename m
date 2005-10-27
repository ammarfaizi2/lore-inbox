Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVJ0VAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVJ0VAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVJ0VAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:00:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:11143 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932240AbVJ0VAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:00:51 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <52ek66wuia.fsf@cisco.com>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <1130446278.5416.10.camel@blade>  <52ek66wuia.fsf@cisco.com>
Content-Type: multipart/mixed; boundary="=-ykW70Jo8FCqYs9cqDl7/"
Date: Thu, 27 Oct 2005 23:00:47 +0200
Message-Id: <1130446847.5416.17.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ykW70Jo8FCqYs9cqDl7/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Roland,

>     > BIOS-provided physical RAM map:
>     >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>     >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>     >  BIOS-e820: 00000000000edbb0 - 0000000000100000 (reserved)
>     >  BIOS-e820: 0000000000100000 - 00000000cec11000 (usable)
>     >  BIOS-e820: 00000000cec11000 - 00000000cee12000 (ACPI NVS)
>     >  BIOS-e820: 00000000cee12000 - 00000000cf68f000 (usable)
>     >  BIOS-e820: 00000000cf68f000 - 00000000cf6e9000 (ACPI NVS)
>     >  BIOS-e820: 00000000cf6e9000 - 00000000cf6ed000 (usable)
>     >  BIOS-e820: 00000000cf6ed000 - 00000000cf6ff000 (ACPI data)
>     >  BIOS-e820: 00000000cf6ff000 - 00000000cf700000 (usable)
> 
> If that's the full e820 map, then I guess the question is why did the
> BIOS not tell you about any memory above 0xcf700000?

yes, that's it. Attached is the full dmesg of the last boot.

Regards

Marcel


--=-ykW70Jo8FCqYs9cqDl7/
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=utf-8
Content-Transfer-Encoding: 8bit

Bootdata ok (command line is root=/dev/sda3 ro quiet)
Linux version 2.6.14-rc5 (holtmann@blade) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #2 SMP Thu Oct 27 20:53:15 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000edbb0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cec11000 (usable)
 BIOS-e820: 00000000cec11000 - 00000000cee12000 (ACPI NVS)
 BIOS-e820: 00000000cee12000 - 00000000cf68f000 (usable)
 BIOS-e820: 00000000cf68f000 - 00000000cf6e9000 (ACPI NVS)
 BIOS-e820: 00000000cf6e9000 - 00000000cf6ed000 (usable)
 BIOS-e820: 00000000cf6ed000 - 00000000cf6ff000 (ACPI data)
 BIOS-e820: 00000000cf6ff000 - 00000000cf700000 (usable)
ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
ACPI: RSDT (v001 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x00000000cf6fde48
ACPI: FADT (v001 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x00000000cf6fcf10
ACPI: MADT (v001 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x00000000cf6fce10
ACPI: WDDT (v001 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x00000000cf6f7f90
ACPI: MCFG (v001 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x00000000cf6f7f10
ACPI: ASF! (v032 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x00000000cf6fcd10
ACPI: DSDT (v001 INTEL  D945GNT  0x00000412 MSFT 0x01000013) @ 0x0000000000000000
On node 0 totalpages: 848946
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 844947 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d0000000 (gap: cf700000:30900000)
Checking aperture...
Built 1 zonelists
Kernel command line: root=/dev/sda3 ro quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2800.236 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3339124k/3398656k available (2029k kernel code, 56232k reserved, 741k data, 184k init)
Calibrating delay using timer specific routine.. 5609.32 BogoMIPS (lpj=11218649)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.64 BogoMIPS (lpj=11201286)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) D CPU 2.80GHz stepping 04
APIC error on CPU1: 00(40)
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -7 cycles, maxerr 1449 cycles)
Brought up 2 CPUs
softlockup thread 1 started up.
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at f0000000
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: 00:05: ioport range 0x500-0x53f has been reserved
pnp: 00:05: ioport range 0x400-0x47f could not be reserved
pnp: 00:05: ioport range 0x680-0x6ff has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: e0200000-e02fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: e0300000-e03fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: disabled.
  MEM window: e0400000-e04fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: e0000000-e00fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler cfq registered
libata version 1.12 loaded.
ata_piix version 1.04
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x20C8 ctl 0x20EE bmdma 0x20A0 irq 185
ata2: SATA max UDMA/133 cmd 0x20C0 ctl 0x20EA bmdma 0x20A8 irq 185
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata1: dev 0 ATA, max UDMA7, 390721968 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0x20C7
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP2004C   Rev: VM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: replayed 37 transactions in 1 seconds
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
NET: Registered protocol family 1
Adding 3903784k swap on /dev/sda2.  Priority:-1 extents:1 across:3903784k
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: Using r5 hash to sort names
ReiserFS: sda5: found reiserfs format "3.6" with standard journal
ReiserFS: sda5: using ordered data mode
ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda5: checking transaction log (sda5)
ReiserFS: sda5: Using r5 hash to sort names
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1b.0 to 64
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 233, io base 0x00002080
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 185, io base 0x00002060
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 177, io base 0x00002040
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 50, io base 0x00002020
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xe01c4000
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
hw_random hardware driver 1.0.0 loaded
usb 1-1: USB disconnect, address 2
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:04:08.0[A] -> GSI 20 (level, low) -> IRQ 58
e100: eth0: e100_probe: addr 0xe0000000, irq 58, MAC addr 00:13:20:64:F4:C5
usb 1-1: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.0-1
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80378d00(lo)
IPv6 over IPv4 tunneling driver
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 50
[drm] Initialized i915 1.1.0 20040405 on minor 0: 
mtrr: base(0xd0020000) is not aligned on a size(0x400000) boundary
eth0: no IPv6 routers present
NET: Registered protocol family 17
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized

--=-ykW70Jo8FCqYs9cqDl7/--

