Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUDFCfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 22:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbUDFCfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 22:35:51 -0400
Received: from [202.28.93.1] ([202.28.93.1]:51718 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S263596AbUDFCfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 22:35:13 -0400
Date: Tue, 6 Apr 2004 09:35:10 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040406093510.33c937e3.kitt@gear.kku.ac.th>
In-Reply-To: <200404060227.58325.daniel.ritz@gmx.ch>
References: <200404060227.58325.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> this is a known problem with the acer travelmate 361. it reports IRQ 11 for
> the O2Micro cardbus bridge when it is in reality IRQ 10.
> 
> see:
> 	http://www.naos.co.nz/hardware/laptop/acer-361evi/x94.html#AEN138
> and
> 	http://sourceforge.net/tracker/index.php?func=detail&aid=533863&group_id=2405&atid=102405

Thanks for info. I'll try that.

> please give a full dmesg and a lspci -vvvn.
> are you using ACPI?

My boot param is "acpi=on pci=noacpi", below is output from dmesg and lspci. 


kitt

--

$ dmesg
Linux version 2.6.5 (root@peorth.kitty.in.th) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 Mon Apr 5 06:06:17 ICT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7e0000 (usable)
 BIOS-e820: 000000000f7e0000 - 000000000f7e8000 (ACPI data)
 BIOS-e820: 000000000f7e8000 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 000000000f800000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63456
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59360 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 Acer                                      ) @ 0x000fe030
ACPI: RSDT (v001 Acer   TM360    0x00000001 Acer 0x00000000) @ 0x0f7e0000
ACPI: FADT (v001 Acer   TM360    0x00000001 Acer 0x00000000) @ 0x0f7e0054
ACPI: BOOT (v001 Acer   TM360    0x00000001 Acer 0x00000000) @ 0x0f7e002c
ACPI: DSDT (v001   Acer   AN360  0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf108
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 acpi=on pci=noacpi vga=791 rhgb
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 999.945 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 247580k/253824k available (1931k kernel code, 5508k reserved, 752k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1982.46 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmaskPCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
vesafb: framebuffer at 0x98000000, mapped to 0xd000e000, size 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x6e set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THR1] (39 C)
ACPI: Thermal Zone [THR2] (33 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0x98000000
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa890-0xa897, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa898-0xa89f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4025GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DV-28E-B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
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
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
mtrr: base(0x98000000) is not aligned on a size(0x180000) boundary
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000a4a0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:01:09.1
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0000a4e0
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000a800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [A4Tech USB Optical Mouse] on usb-0000:00:1d.0-1
EXT3 FS on hda2, internal journal
Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50448 usecs
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1172 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:01:03.0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[80100000-801007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0120900300000000]
microcode: error! Bad data in microcode data file
microcode: Error in the microcode data
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 10 for device 0000:01:08.0
PCI: Sharing IRQ 10 with 0000:01:05.0
e100: eth0: e100_probe: addr 0x80101000, irq 10, MAC addr 00:00:E2:61:54:AE
mtrr: base(0x98000000) is not aligned on a size(0x180000) boundary
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
cdrom: This disc doesn't have any tracks I recognize!
Synaptics driver lost sync at byte 4
Synaptics driver resynced.
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
ip_tables: (C) 2000-2002 Netfilter core team
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Setting latency timer of device 0000:00:1f.6 to 64
spurious 8259A interrupt: IRQ7.
cdrom: This disc doesn't have any tracks I recognize!
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
PCI: Found IRQ 10 for device 0000:01:05.0
PCI: Sharing IRQ 10 with 0000:01:08.0
Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 10
Socket status: 30000011
PCI: Found IRQ 11 for device 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.1
Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
irq 10: nobody cared!
Call Trace:
 [<c0108eca>] __report_bad_irq+0x2a/0x90
 [<c0108fc0>] note_interrupt+0x70/0xb0
 [<c0109270>] do_IRQ+0x120/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c01217ee>] do_softirq+0x3e/0xa0
 [<c010924a>] do_IRQ+0xfa/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c0113284>] delay_pmtmr+0x14/0x20
 [<c01cf512>] __delay+0x12/0x20
 [<d0de29fe>] yenta_probe_irq+0xfe/0x140 [yenta_socket]
 [<d0de2a7a>] yenta_get_socket_capabilities+0x3a/0x70 [yenta_socket]
 [<d0de2dc7>] yenta_probe+0x1a7/0x240 [yenta_socket]
 [<c01d3712>] pci_device_probe_static+0x52/0x70
 [<c01d376c>] __pci_device_probe+0x3c/0x50
 [<c01d37ac>] pci_device_probe+0x2c/0x50
 [<c0232b1f>] bus_match+0x3f/0x70
 [<c0232c4c>] driver_attach+0x5c/0xa0
 [<c0232f78>] bus_add_driver+0xa8/0xc0
 [<c02333cf>] driver_register+0x2f/0x40
 [<c01d399c>] pci_register_driver+0x5c/0x90
 [<d0d9400f>] yenta_socket_init+0xf/0x11 [yenta_socket]
 [<c0134722>] sys_init_module+0x142/0x280
 [<c0107459>] sysenter_past_esp+0x52/0x71
 
handlers:
[<d0d55890>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
[<d0d4da10>] (ohci_irq_handler+0x0/0x860 [ohci1394])
[<d0d3e1d0>] (e100_intr+0x0/0x5a0 [e100])
[<d0da15c0>] (snd_intel8x0_interrupt+0x0/0x230 [snd_intel8x0m])
[<d0de18a0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #10
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:01:09.1
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.0
Yenta: CardBus bridge found at 0000:01:09.1 [1025:1022]
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000410

$ lspci -vvvn
00:00.0 Class 0600: 8086:3575 (rev 03)
        Subsystem: 1025:1022
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: <available only to root>
 
00:02.0 Class 0300: 8086:3577 (rev 03)
        Subsystem: 1025:1022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 98000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at 90100000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: <available only to root>
 
00:02.1 Class 0380: 8086:3577
        Subsystem: 1025:1022
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at 80200000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: <available only to root>
 
00:1d.0 Class 0c03: 8086:2482 (rev 01)
        Subsystem: 1025:1022
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at a4a0 [size=32]
 
00:1d.1 Class 0c03: 8086:2484 (rev 01)
        Subsystem: 1025:1022
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at a4e0 [size=32]
 
00:1d.2 Class 0c03: 8086:2487 (rev 01)
        Subsystem: 1025:1022
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at a800 [size=32]
 
00:1e.0 Class 0604: 8086:2448 (rev 41)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: 80100000-801fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 
00:1f.0 Class 0601: 8086:248c (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 Class 0101: 8086:248a (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: 1025:1022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at a890 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]
 
00:1f.3 Class 0c05: 8086:2483 (rev 01)
        Subsystem: 1025:1022
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 8000 [size=32]
 
00:1f.5 Class 0401: 8086:2485 (rev 01)
        Subsystem: 1025:1022
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 9800 [size=256]
        Region 1: I/O ports at 9c00 [size=64]
 
00:1f.6 Class 0703: 8086:2486 (rev 01)
        Subsystem: 1025:1022
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at a000 [size=256]
        Region 1: I/O ports at a400 [size=128]
 
01:03.0 Class 0c00: 104c:8026 (prog-if 10)
        Subsystem: 1025:1022
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at 80104000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>
 
01:05.0 Class 0607: 104c:ac50 (rev 01)
        Subsystem: 12a3:ab01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
 
01:08.0 Class 0200: 8086:1031 (rev 41)
        Subsystem: 1025:1022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 80101000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 7000 [size=64]
        Capabilities: <available only to root>
 
01:09.0 Class 0607: 1217:6933 (rev 02)
        Subsystem: 1025:1022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
 
01:09.1 Class 0607: 1217:6933 (rev 02)
        Subsystem: 1025:1022
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10003000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=0a, subordinate=0d, sec-latency=176
        Memory window 0: 11400000-117ff000 (prefetchable)
        Memory window 1: 11800000-11bff000
        I/O window 0: 00005000-000050ff
        I/O window 1: 00005400-000054ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001


