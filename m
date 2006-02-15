Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030606AbWBODLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030606AbWBODLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWBODLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:11:54 -0500
Received: from mail.majordomo.ru ([81.177.16.8]:35846 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S1030606AbWBODLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:11:53 -0500
Message-ID: <43F2BFA0.6020105@nndl.org>
Date: Wed, 15 Feb 2006 05:44:00 +0000
From: "Nikolay N. Ivanov" <nn@nndl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15.x - very slow disk-writing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:

> 
> Please send the output of `dmesg -s 1000000'.
> 

Oh, sorry! I've really forgotten about dmesg. Here it is:



Linux version 2.6.15.4nn9 (nn@dt) (gcc version 3.3.4) #9 Mon Feb 13
18:01:36 MSK 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001f7f0000 (usable)
  BIOS-e820: 000000001f7f0000 - 000000001f7f3000 (ACPI NVS)
  BIOS-e820: 000000001f7f3000 - 000000001f800000 (ACPI data)
  BIOS-e820: 000000001f800000 - 0000000020000000 (reserved)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
503MB LOWMEM available.
On node 0 totalpages: 129008
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 124912 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
DMI not present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f72c0
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1f7f5540
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.15.4 ro root=308
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1002.433 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 507688k/516032k available (2361k kernel code, 7876k reserved,
728k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2007.17 BogoMIPS
(lpj=1003589)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Celeron(TM) CPU                1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 1e20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
PCI quirk: region 5000-500f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: e0000000-e2ffffff
   PREFETCH window: 30000000-300fffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1139981297.254:1): initialized
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level,
low) -> IRQ 12
0000:00:0a.0: ttyS2 at I/O 0xec08 (irq = 12) is a 16450
0000:00:0a.0: ttyS3 at I/O 0xec10 (irq = 12) is a 8250
Couldn't register serial port 0000:00:0a.0: -28
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
eth0: RealTek RTL8139 at 0xe800, 4c:00:10:51:32:1e, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: SAMSUNG SP0411N, ATA DISK drive
Probing IDE interface ide1...
hdc: ASUS CB-5216A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63
hda: cache flushes supported
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 5, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 5 (level, low)
-> IRQ 5
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: irq 5, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
input: Darfon USB Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Darfon USB Optical Mouse] on usb-0000:00:07.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
ALSA device list:
   No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
ip_conntrack version 2.4 (4031 buckets, 32248 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
input: AT Translated Set 2 keyboard as /class/input/input1
Adding 522072k swap on /dev/hda9.  Priority:-1 extents:1 across:522072k
EXT3 FS on hda8, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
cyblafb: CyblaFB version 0.54 initializing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 12 (level,
low) -> IRQ 12
PCI: Setting latency timer of device 0000:00:07.5 to 64
agpgart: Detected VIA Apollo ProMedia/PLE133Ta chipset
agpgart: AGP aperture is 8M @ 0xe4000000
spurious 8259A interrupt: IRQ7.



-- 
Nikolay N. Ivanov
mailto: nn@nndl.org

