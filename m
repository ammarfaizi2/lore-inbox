Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbTBKNel>; Tue, 11 Feb 2003 08:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267822AbTBKNel>; Tue, 11 Feb 2003 08:34:41 -0500
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:25103 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id <S267808AbTBKNeg> convert rfc822-to-8bit; Tue, 11 Feb 2003 08:34:36 -0500
Message-Id: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
Date: Tue, 11 Feb 2003 14:43:46 +0100
From: Henrik Persson <nix@socialism.nu>
To: linux-kernel@vger.kernel.org
Subject: via rhine bug? (timeouts and resets)
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

I know this has been up before, but I couldn't find a solution in the
archives that would solve my problems.. 

The problem is that my Via Rhine-NIC when transmitting alot of data fast
(like.. ftp:ing large files over the network at 100mbit/s) gets an error
(frame dropped, transmit error, reset).. As a cause of this the speed
drops to about 3-4MB/s and the rest of the communication trough the
network isn't working very well..

Note that this ONLY happens when there's alot of traffic (i.e. speeds at
~100mbit/s)..

Here is my dmesg (notice that the driver is inserted twice.. Once at
boot-time and once later on, loaded with debug=3)..

And ah, yes. It's an Acer Aspire 1300XV if that helps.. And yes, I've
tried the rhinefet.o-module from viarena..

Thanks. Hope anyone knows what to do..

Linux version 2.4.20 (root@vega) (gcc version 2.95.3 20010315 (release))
#5 Tue Feb 11 12:05:25 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000effffc0 (ACPI data)
 BIOS-e820: 000000000effffc0 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
239MB LOWMEM available.
On node 0 totalpages: 61424
zone(0): 4096 pages.
zone(1): 57328 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 noapic
Initializing CPU#0
Detected 1200.078 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 240244k/245696k available (1486k kernel code, 5064k reserved, 418k
data, 256k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1cbf9ff 00000000 00000000
CPU: AMD mobile AMD Athlon(tm) XP 1400+  stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xe8a64, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
PCI: Using IRQ router default [1106/8231] at 00:11.0
PCI: Cannot allocate resource region 0 of device 00:0a.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
EC: found, GPE 1
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2
ACPI: Battery socket found, battery present
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Lid Switch (CM) found
ACPI: Thermal Zone found
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
vesafb: framebuffer at 0x90000000, mapped to 0xcf807000, size 15296k
vesafb: mode is 1024x768x8, linelength=1024, pages=18
vesafb: protected mode interface info at c000:7926
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
hdc: QSI DVD-ROM SDR-083, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0348484, I/O limit 4095Mb (mask 0xffffffff)
hda: 39070080 sectors (20004 MB), CHS=2584/240/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 189M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xa0000000
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0x1200, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 256k freed
hub.c: new USB device 00:11.2-1, assigned address 2
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer]
on usb1:2.0
hub.c: new USB device 00:11.2-2, assigned address 3
Adding Swap: 491392k swap-space (priority -1)
input1: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on
usb1:3.0
input2: USB HID v1.10 Pointer [Logitech Logitech USB Keyboard] on usb1:3.1
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Enabling device 00:12.0 (0001 -> 0003)
eth0: VIA VT6102 Rhine-II at 0xf0000000, 00:c0:9f:0d:d1:dd, IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
45e1.
Via 686a audio driver 1.9.1
ac97_codec: AC97 Modem codec, id: CXT41(Unknown)
via82cxxx: board #1 at 0xE000, IRQ 10
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
eth0: no IPv6 routers present
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
via-rhine: reset finished after 5 microseconds.
eth%d: Set to forced full duplex, autonegotiation disabled.
eth0: VIA VT6102 Rhine-II at 0xf0000000, 00:c0:9f:0d:d1:dd, IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
45e1.
eth0: via_rhine_open() irq 11.
eth0: reset finished after 5 microseconds.
eth0: Done via_rhine_open(), status 0c1a MII status: 782d.
eth0: no IPv6 routers present
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0209, frame dropped.
eth0: Something Wicked happened! 0209.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.
eth0: Transmit error, Tx status 00008800.
eth0: MII status changed: Autonegotiation advertising 01e1  partner 45e1.
eth0: Abort 0208, frame dropped.
eth0: Something Wicked happened! 0208.


-- 
Henrik Persson
e-mail: nix@socialism.nu  WWW: http://nix.badanka.com
ICQ: 26019058             PGP/GPG: http://nix.badanka.com/pgp
PGP-Key-ID: 0x43B68116    PGP-Keyserver: pgp.mit.edu
