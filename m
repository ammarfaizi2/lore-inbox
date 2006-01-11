Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWAKVkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWAKVkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWAKVkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:40:05 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:1478 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750819AbWAKVkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:40:04 -0500
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
Date: Thu, 12 Jan 2006 08:39:47 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <ubuas1lf66e8ti3bhv4he9etdd1c3rar80@4ax.com>
References: <20060111042135.24faf878.akpm@osdl.org>
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 04:21:35 -0800, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
>
>- New config options (VMSPLIT_*) to permit non-standard user/kernel
>  splitting on x86.  Needs testing please.
>
>- Lots of updates to the USB, PCI, driver and I2C trees.  This is usually a
>  worry.

Well, it booted :o)  but I get these strange:

grant@sempro:~$ dmesg |grep -B 5 "SET:"
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
**** SET: Misaligned resource pointer: efe7ac22 Type 07 Len 0
--
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
sd 1:0:0:0: Attached scsi disk sdb
**** SET: Misaligned resource pointer: efe7ac22 Type 07 Len 0
--
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=5 option
         and report if it works on your machine.
         For more details, read ALSA-Configuration.txt.
**** SET: Misaligned resource pointer: b19c5b82 Type 07 Len 0
--
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 19
e100: eth0: e100_probe: addr 0xee100000, irq 19, MAC addr 00:02:B3:3F:EA:67
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
**** SET: Misaligned resource pointer: efed7662 Type 07 Len 0

Plus a warning:
Driver 'w83627hf' needs updating - please use bus_type methods

Full dmesg appended.  grep = .config at:
  http://bugsplatter.mine.nu/test/boxen/sempro/config-2.6.15-mm3a.gz

Thanks,
Grant.

grant@sempro:~$ dmesg
Linux version 2.6.15-mm3a (grant@sempro) (gcc version 3.3.6) #1 Thu Jan 12 09:28:24 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1023MB LOWMEM available.
found SMP MP-table at 000f52f0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 258032 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 KM400                                 ) @ 0x000f6dd0
ACPI: RSDT (v001 KM400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 KM400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 KM400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7f40
ACPI: DSDT (v001 KM400  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 1833.216 MHz processor.
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=2.6.15-mm3a ro root=803 video=vesafb:mtrr,ywrap
CPU 0 irqstacks, hard=b0479000 soft=b0478000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1034408k/1048512k available (2502k kernel code, 13608k reserved, 843k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3669.41 BogoMIPS (lpj=18347083)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Sempron(tm)   2600+ stepping 01
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbaf0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20051216
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 *12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs *20)
ACPI: PCI Interrupt Link [ALKB] (IRQs *21)
ACPI: PCI Interrupt Link [ALKC] (IRQs *22)
ACPI: PCI Interrupt Link [ALKD] (IRQs *23)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: the driver 'system' has been registered
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ec000000-edffffff
  PREFETCH window: e8000000-ebffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
io scheduler noop registered
io scheduler deadline registered
PCI: Bypassing VIA 8237 APIC De-Assert Message
vesafb: framebuffer at 0xe8000000, mapped to 0xf0880000, using 1536k, total 65536k
vesafb: mode is 1024x768x8, linelength=1024, pages=3
vesafb: protected mode interface info at c000:e710
vesafb: pmi: set display start = b00ce755, set palette = b00ce7da
vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Time: tsc clocksource has been installed.
Console: switching to colour frame buffer device 85x34
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
Using specific hotkey driver
ACPI: Thermal Zone [THRM] (50 C)
Real Time Clock Driver v1.12ac
pnp: the driver 'i8042 kbd' has been registered
pnp: the driver 'i8042 aux' has been registered
pnp: the driver 'i8042 kbd' has been unregistered
pnp: the driver 'i8042 aux' has been unregistered
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 0 ports, IRQ sharing disabled
pnp: the driver 'serial' has been registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
**** SET: Misaligned resource pointer: efe7ac22 Type 07 Len 0
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xe700-0xe707, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xe708-0xe70f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hdb: LITE-ON DVDRW SOHW-812S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
QLogic Fibre Channel HBA Driver
libata version 1.20 loaded.
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 0
sata_via 0000:00:0f.0: routed to hard irq line 0
ata1: SATA max UDMA/133 cmd 0xE100 ctl 0xE202 bmdma 0xE500 irq 16
ata2: SATA max UDMA/133 cmd 0xE300 ctl 0xE402 bmdma 0xE508 irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata2: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: ST3120827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
sd 1:0:0:0: Attached scsi disk sdb
**** SET: Misaligned resource pointer: efe7ac22 Type 07 Len 0
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.4, from 12 to 1
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 17, io mem 0xee102000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 17, io base 0x0000e800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 1
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 17, io base 0x0000e900
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 1
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 17, io base 0x0000ea00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 1
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 17, io base 0x0000eb00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-2: new low speed USB device using uhci_hcd and address 2
Initializing USB Mass Storage driver...
usb 2-2: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: Microsoft Microsoft IntelliMouse® Optical as /class/input/input0
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:10.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=5 option
         and report if it works on your machine.
         For more details, read ALSA-Configuration.txt.
**** SET: Misaligned resource pointer: b19c5b82 Type 07 Len 0
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:11.5, from 12 to 2
PCI: Setting latency timer of device 0000:00:11.5 to 64
input: AT Translated Set 2 keyboard as /class/input/input1
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
ALSA device list:
  #0: VIA 8237 with VIA1617A at 0xec00, irq 18
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 514040k swap on /dev/sda5.  Priority:1 extents:1 across:514040k
Adding 1028120k swap on /dev/sdb1.  Priority:1 extents:1 across:1028120k
ReiserFS: sdb5: found reiserfs format "3.6" with standard journal
ReiserFS: sdb5: using ordered data mode
ReiserFS: sdb5: journal params: device sdb5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb5: checking transaction log (sdb5)
ReiserFS: sdb5: Using r5 hash to sort names
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: Using r5 hash to sort names
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 19
e100: eth0: e100_probe: addr 0xee100000, irq 19, MAC addr 00:02:B3:3F:EA:67
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
**** SET: Misaligned resource pointer: efed7662 Type 07 Len 0
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [ALKD] -> GSI 23 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:12.0, from 10 to 4
eth1: VIA Rhine II at 0xee103000, 00:11:09:d1:8e:23, IRQ 20.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
eth1: link up, 100Mbps, full-duplex, lpa 0x41E1
Driver 'w83627hf' needs updating - please use bus_type methods
grant@sempro:~$

