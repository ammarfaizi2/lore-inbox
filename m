Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTJVVa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTJVVa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:30:28 -0400
Received: from main.gmane.org ([80.91.224.249]:8934 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261168AbTJVVaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:30:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: bd <bdonlan@users.sf.net>
Subject: 2.6.0-test8: 'sleeping function called from invalid context at include/asm/semaphore.h: 119' at boot
Date: Tue, 21 Oct 2003 20:08:22 -0400
Organization: Not RoadRunner, that's for sure.
Message-ID: <rcug61-a26.ln1@bd-home-comp.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
X-yzzy: Nothing happens.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I boot 2.6.0-test8, it sends the following to dmesg:
Debug: sleeping function called from invalid context at
include/asm/semaphore.h:
119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011a386>] __might_sleep+0xa0/0xc2
 [<c011cdd7>] acquire_console_sem+0x3a/0x59
 [<c011d00c>] register_console+0x9f/0x1ca
 [<c02c9327>] vgacon_save_screen+0x0/0x68
 [<c04b5cb3>] con_init+0x1f4/0x241
 [<c0105000>] _stext+0x0/0x61
 [<c04b50c3>] console_init+0x33/0x40
 [<c04a462b>] start_kernel+0xbe/0x15d
 [<c04a443f>] unknown_bootoption+0x0/0xfa


Full dmesg:
Linux version 2.6.0-test8 (root@bd-home-comp.no-ip.org) (gcc version 3.2.3
20030422 (Gentoo Linux 1.4 3.2.3-r2, propolice)) #2 Tue Oct 21 19:25:03 EDT
2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 00000000000ec000 (ACPI NVS)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017f00000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98048
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 93952 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000e8010
ACPI: RSDT (v001 COMPAQ CARS6C31 0x00000001  0x00000000) @ 0x000e8080
ACPI: FADT (v001 COMPAQ CARS6C31 0x00000001  0x00000000) @ 0x000e80cc
ACPI: SSDT (v001 COMPAQ CARS6C3  0x00000001 MSFT 0x01000007) @ 0x000e8187
ACPI: DSDT (v001 COMPAQ DSDTTBL  0x00000001 MSFT 0x01000007) @ 0x00000000
Building zonelist for node : 0
Kernel command line: ro root=/dev/hdb3 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 797.771 MHz processor.
Console: colour VGA+ 80x25
Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011a386>] __might_sleep+0xa0/0xc2
 [<c011cdd7>] acquire_console_sem+0x3a/0x59
 [<c011d00c>] register_console+0x9f/0x1ca
 [<c02c9327>] vgacon_save_screen+0x0/0x68
 [<c04b5cb3>] con_init+0x1f4/0x241
 [<c0105000>] _stext+0x0/0x61
 [<c04b50c3>] console_init+0x33/0x40
 [<c04a462b>] start_kernel+0xbe/0x15d
 [<c04a443f>] unknown_bootoption+0x0/0xfa

Memory: 383240k/392192k available (2737k kernel code, 8188k reserved, 982k
data, 152k init, 0k highmem)
Calibrating delay loop... 1576.96 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 797.0481 MHz.
..... host bus clock speed is 99.0685 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa134, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 10 11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i810 E Chipset.
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0x44000000
[drm] Initialized i810 1.4.0 20030605 on minor 0
[drm] Initialized i830 1.3.2 20021108 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:01:0a.0 (0000 -> 0001)
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:01:08.0 (0004 -> 0007)
eth0: ADMtek Comet rev 17 at 0xd88a4000, 00:03:6D:11:10:9E, IRQ 3.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2020-0x2027, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x2028-0x202f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdb: Maxtor 6E040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-32123S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-32123S        Rev: XS0K
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 16x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver
v2.1
uhci_hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0000eec0
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (3064 buckets, 24512 max) - 160 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
found reiserfs format "3.6" with standard journal
hub 1-0:1.0: new USB device on port 1, assigned address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
Reiserfs journal params: device hdb3, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb3) for (hdb3)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 152k freed
hub 1-1:1.0: new USB device on port 3, assigned address 3
drivers/usb/input/hid-core.c: ctrl urb status -32 received
input: USB HID v1.00 Gamepad [Ver 1.0 USB To RS232 Interface (V1.0) BaudRate
2400bps] on usb-0000:00:1f.2-1.3
Adding 1005440k swap on /dev/hdb1.  Priority:0 extents:1
Adding 529192k swap on /dev/hda2.  Priority:0 extents:1
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb2, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb2) for (hdb2)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
Disabled Privacy Extensions on device c0459a00(lo)
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
eth0: no IPv6 routers present
blk: queue d7bf8e00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue d7bf8a00, I/O limit 4095Mb (mask 0xffffffff)
spurious 8259A interrupt: IRQ7.
snd_maestro3: Unknown parameter `snd-pcm-oss'
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


The system runs fine once it finishes booting, however, except that
'xosview' hangs at startup and must be killed.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lcp5x533NjVSos4RAluzAJ93bdgsxqDQNvGD83oOs+LON5JamACfQ7Wm
HzuRqTMomv8i2+h0M6xytU8=
=5HUl
-----END PGP SIGNATURE-----

