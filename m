Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTIHJrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTIHJrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:47:21 -0400
Received: from maja.beep.pl ([195.245.198.10]:24843 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262327AbTIHJqA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:46:00 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: USB: irq 11: nobody cared!
Date: Mon, 8 Sep 2003 11:43:00 +0200
User-Agent: KMail/1.5.3
Cc: linux-usb-devel@lists.sourceforge.net
References: <200309072132.15278.arekm@pld-linux.org>
In-Reply-To: <200309072132.15278.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309081143.00765.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 of September 2003 21:32, Arkadiusz Miskiewicz wrote:
> Hi,
>
> I've tested 2.6.0test4 with changeset patch from 20030906_2214
> (http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/).
Now I've tested 2.6.0-test4cset20030907_2209 with IDE compiled in (not 
modular) and it seems that only two problems left - jffs and USB one:

> 2) missing symbol
> WARNING: /lib/modules/2.6.0-test4cset20030906rel0.1/kernel/fs/jffs/jffs.ko
> needs unknown symbol set_special_pids
Still there.

> 4) USB no longer working. Was working fine in vanilla test4.
Still there.
Linux version 2.6.0 (builder@beton) (gcc version 3.3.1 (PLD Linux)) #1 Mon Sep 
8 02:39:55 UTC 2003
Video mode to be used for restore is f07
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000eff8000 (ACPI data)
 BIOS-e820: 000000000eff8000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa4a0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x0eff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0eff0030
ACPI: BOOT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x0eff00c0
ACPI: DSDT (v001    VIA TwisterK 0x00001000 INTL 0x02002024) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=pld-2.6.0 ro root=303 console=ttyS0,57600n81 
console=tty0
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1533.459 MHz processor.
Console: colour VGA+ 80x60
Memory: 239664k/245696k available (1662k kernel code, 5336k reserved, 679k 
data, 164k init, 0k highmem)
Calibrating delay loop... 3022.84 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Not enabled at boot.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Embedded Controller [EC0] (gpe 5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 9 *10 11 14 15)
ACPI: Power Resource [FN10] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7710
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x673b, dseg 0xf0000
PnPBIOS: Unknown tag '0x82', length '22'.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Via IRQ fixup for 0000:00:11.3, from 10 to 11
PCI: Via IRQ fixup for 0000:00:11.2, from 10 to 11
PCI: Via IRQ fixup for 0000:00:11.5, from 10 to 11
PCI: Via IRQ fixup for 0000:00:11.6, from 10 to 11
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
w83877f_wdt: WDT driver for W83877F initialised. timeout=30 sec (nowayout=0)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3021GAS, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 187k freed
VFS: Mounted root (romfs filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 164k freed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
blk: queue c1389800, I/O limit 4095Mb (mask 0xffffffff)
EXT3 FS on hda3, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Capability LSM initialized
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU1] (supports C1 C2)
ACPI: Thermal Zone [THRM] (56 C)
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00faf80
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 86 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:74 (@c00fb590)
powernow:  cpuid: 0x781	fsb: 133	maxFID: 0x1	startvid: 0xb
powernow:    FID: 0x6 (6.0x [798MHz])	VID: 0xd (1.350V)
powernow:    FID: 0x7 (6.5x [864MHz])	VID: 0xd (1.350V)
powernow:    FID: 0x9 (7.5x [997MHz])	VID: 0xd (1.350V)
powernow:    FID: 0xb (8.5x [1130MHz])	VID: 0xd (1.350V)
powernow:    FID: 0xd (9.5x [1263MHz])	VID: 0xd (1.350V)
powernow:    FID: 0xf (10.5x [1396MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x1 (11.5x [1529MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 798 MHz. Maximum speed 1529 MHz.
input: PS/2 Generic Mouse on isa0060/serio2
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
PCI: Setting latency timer of device 0000:00:11.5 to 64
NTFS driver 2.1.4 [Flags: R/W MODULE].
NTFS volume version 3.1.
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xd000, 00:a0:cc:da:d9:3c, IRQ 9.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:08.0 [1584:3000]
Yenta: ISA IRQ list 0400, PCI irq5
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x87f
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x400-0x40f 
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci-hcd 0000:00:11.2: UHCI Host Controller
irq 11: nobody cared!
Call Trace:
 [<c010cbdb>] __report_bad_irq+0x2b/0x90
 [<c010ccd4>] note_interrupt+0x64/0xa0
 [<c010cf6e>] do_IRQ+0x12e/0x140
 [<c010b49c>] common_interrupt+0x18/0x20
 [<c0124603>] do_softirq+0x43/0xa0
 [<c010cf48>] do_IRQ+0x108/0x140
 [<c010b49c>] common_interrupt+0x18/0x20
 [<c01add8c>] pci_bus_write_config_word+0x5c/0x80
 [<cfa144a0>] uhci_reset+0x40/0x50 [uhci_hcd]
 [<cf89ba32>] usb_hcd_pci_probe+0x192/0x480 [usbcore]
 [<c01b176b>] pci_device_probe_static+0x4b/0x60
 [<c01b18d6>] __pci_device_probe+0x36/0x50
 [<c01b191c>] pci_device_probe+0x2c/0x50
 [<c01f5dad>] bus_match+0x3d/0x70
 [<c01f5f00>] driver_attach+0x70/0xb0
 [<c01f6201>] bus_add_driver+0xa1/0xc0
 [<c01f6651>] driver_register+0x31/0x40
 [<c01b1b9e>] pci_register_driver+0x5e/0x90
 [<cf8cb0c7>] uhci_hcd_init+0xc7/0x143 [uhci_hcd]
 [<c0137043>] sys_init_module+0x123/0x270
 [<c010b32f>] syscall_call+0x7/0xb

handlers:
[<cf9234b0>] (snd_via82xx_interrupt+0x0/0x110 [snd_via82xx])
Disabling IRQ #11
uhci-hcd 0000:00:11.2: irq 11, io base 0000d400
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:11.3: UHCI Host Controller
uhci-hcd 0000:00:11.3: irq 11, io base 0000d800
uhci-hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
usb 1-1: control timeout on ep0out
uhci-hcd 0000:00:11.2: Unlink after no-IRQ?  Different ACPI or APIC settings 
may help.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03165c0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

