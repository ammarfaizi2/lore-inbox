Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUDOVWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUDOVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:21:38 -0400
Received: from imap.gmx.net ([213.165.64.20]:57814 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261204AbUDOVTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:19:48 -0400
X-Authenticated: #1189245
Message-ID: <407EFC70.3070902@gmx.net>
Date: Thu, 15 Apr 2004 23:19:44 +0200
From: Carsten Menke <bootsy52@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113 Netscape6/6.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.x USB support needed for PS/2 Mouse/Keyboard to be functional
Content-Type: multipart/mixed;
 boundary="------------030705050306000304030308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705050306000304030308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

it has taken a long time to find out why I was unable to run any 2.6 
Kernel (2.6.0 - 2.6.5).
The Problem is, that if I do not have usb support compiled in (or as as 
module)
my PS/2 Keyboard and PS/2 Mouse does not work and immeditley freeze when 
X starts (though the
system is still running as I could see on the system clock).

Keyboard works, as long as I do not start the X server, but soon as X 
has started the Keyboard freeze. The Mouse
never worked. Both work fine under 2.4.x without USB

I consider this as a bug, as this is nowhere documented that usb is 
needed to run PS/2 periphals (or at least nowhere where
I looked [ Documentation/Google/kernel list])

My setup is

Microsoft Office Pro Natural Keyboard connected via PS/2 Adapter
Microsoft Optical Mouse also connected via the PS/2 Adapter

in between sits a KVM Switch.

X is at Version 4.4.0

relevant sections of XF86Config

Section "InputDevice"
         Identifier "Mouse"
         Option "Protocol" "IMPS/2"
         Option "Device" "/dev/misc/psaux"
         Driver "mouse"
         Option "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"
         Identifier "Keyboard"
         Option "XkbModel" "pc105"
         Option "XkbLayout" "de"
         Driver "keyboard"
EndSection


dmesg is attached to this mail

--------------030705050306000304030308
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.5 (root@Bootsy) (gcc version 3.3.3) #5 Thu Apr 15 20:51:03 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f62d0
ACPI: RSDT (v001 ASUS   MED_2001 0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   MED_2001 0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: BOOT (v001 ASUS   MED_2001 0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: DSDT (v001   ASUS MED_2001 0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.5 ro root=308
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 902.541 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 514628k/524272k available (2555k kernel code, 8896k reserved, 823k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1769.47 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xf0000000, mapped to 0xe080a000, size 16384k
vesafb: mode is 800x600x16, linelength=1600, pages=3
vesafb: protected mode interface info at c000:0f34
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x3a set to 0x1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Console: switching to colour frame buffer device 100x37
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 32M @ 0xfc000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: 20X10, ATAPI CD/DVD-ROM drive
hdd: LITEON DVD-ROM LTD122, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 p13 > p3 p4
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:04.2: irq 11, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:04.3: irq 11, io base 0000d000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1546:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:534:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
usb 1-1: new full speed USB device using address 2
usb 1-2: new full speed USB device using address 3
Adding 1052220k swap on /dev/ide/host0/bus0/target0/lun0/part7.  Priority:-1 extents:1
NTFS driver 2.1.6 [Flags: R/W MODULE].
NTFS volume version 3.0.
XFS mounting filesystem hda9
Ending clean XFS mount for filesystem: hda9
XFS mounting filesystem hda10
Ending clean XFS mount for filesystem: hda10
XFS mounting filesystem hda11
Ending clean XFS mount for filesystem: hda11
XFS mounting filesystem hda12
Ending clean XFS mount for filesystem: hda12
XFS mounting filesystem hda13
Ending clean XFS mount for filesystem: hda13
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe18b0000, 00:30:84:26:c9:86, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--------------030705050306000304030308--
