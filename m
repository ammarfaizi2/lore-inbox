Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUGAHqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUGAHqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUGAHqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:46:51 -0400
Received: from [217.222.53.238] ([217.222.53.238]:42507 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S264246AbUGAHqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:46:40 -0400
Message-ID: <40E3C141.5010106@gts.it>
Date: Thu, 01 Jul 2004 09:46:09 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm5
References: <20040630172656.6949ec60.akpm@osdl.org>	<40E3B9F8.8070105@gts.it> <20040701002753.68a4739d.akpm@osdl.org>
In-Reply-To: <20040701002753.68a4739d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010008060002030302020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008060002030302020002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

[...]
> What would the next message have been, if it had not hung up?

Here attached, a normal startup with -mm4.

Note that I had this problem also with -mm3, that occasionally hanged 
both at this step _OR_ after ACPI processor module insertion: in that 
case the last line shown at startup was:

ACPI: Processor [CPU0] (supports C1, C2, C3, 8 throttling states)

i.e. line #154 in the attached dmesg.

All of the boots I've done with -mm5 (5 or 6), instead, hanged after 
ide0 (but may be pure coincidence).

Bye

-- 
Stefano RIVOIR


--------------010008060002030302020002
Content-Type: text/plain;
 name="normal.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="normal.dmesg"

Linux version 2.6.7-mm4 (root@nbsteu) (gcc version 3.3.4 (Debian 1:3.3.4-2)) #11 Thu Jul 1 08:57:10 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffa000 (usable)
 BIOS-e820: 000000001fffa000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131066
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126970 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6410
ACPI: RSDT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa000
ACPI: FADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa0b6
ACPI: BOOT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa030
ACPI: MADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x1fffa058
ACPI: DSDT (v001   ASUS L5C      0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=Linux ro root=1602 idebus=66
ide_setup: idebus=66
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2666.739 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 516340k/524264k available (1327k kernel code, 7188k reserved, 650k data, 96k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5259.26 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1670, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 11 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (off)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0a.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0a.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x3a set to 0x80
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC25N060ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 1024KiB
hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 < hdc5 >
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
kjournald starting.  Commit interval 5 seconds
Adding 248968k swap on /dev/hdc5.  Priority:-1 extents:1
EXT3 FS on hdc2, internal journal
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 49311 usecs
intel8x0: clocking to 48000
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: AC Adapter [AC] (on-line)
Asus Laptop ACPI Extras version 0.28
  Error calling BSTS
  L5G model detected, supported
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (48 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 5, pci mem e08f7000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:03.1: irq 5, pci mem e08f9000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
ohci_hcd 0000:00:03.2: irq 5, pci mem e08fb000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using address 2
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem e0914000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb 1-2: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Linux Kernel Card Services
  options:  [pci] [cardbus]
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [1043:1734]
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000006
ACPI: PCI interrupt 0000:00:0a.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.1 [1043:1734]
Yenta: ISA IRQ mask 0x0040, PCI irq 11
Socket status: 30000006
usb 1-2: new low speed USB device using address 3
drivers/usb/input/hid-core.c: ctrl urb status -32 received
input: USB HID v1.00 Mouse [0461:4d03] on usb-0000:00:03.0-2
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
lp: driver loaded but no devices found
eth0: network connection up using port A
    speed:           10
    autonegotiation: yes
    duplex mode:     half
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled

--------------010008060002030302020002--
