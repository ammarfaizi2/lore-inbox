Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264967AbUEQLll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264967AbUEQLll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUEQLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:41:41 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:31195 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264967AbUEQLlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:41:32 -0400
Subject: Re: HDIO_SET_DMA failed: with nforce2 board
From: Mike Kordik <Mike@Kordik.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405171313.02675.bzolnier@elka.pw.edu.pl>
References: <pan.2004.05.17.02.15.01.317598@kordik.net>
	 <200405171313.02675.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1084793981.12242.1.camel@Jacob>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 07:39:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 07:13, Bartlomiej Zolnierkiewicz wrote:
> On Monday 17 of May 2004 04:15, Mike wrote:
> > I have an nforce2 based board and I cannot enable dma.
> 
> 'dmesg' output, please
> 

I posted using PAN and I am trying to respond with PAM but todays posts
and some of yesterdays are not showing up. I do not know what the
problem is but I apologize for responding this way. Here is my dmesg
output:

Linux version 2.6.4-rc1-mm1 (root@cdimage) (gcc version 3.3.3 20040217
(Gentoo Linux 3.3.3, propolice-3.3-7)) #3 Mon May 17 00:17:40 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                    ) @
0x000f69f0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x1fff74c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @
0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda3
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1464.461 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514428k/524224k available (2551k kernel code, 9032k reserved,
917k data, 144k init, 0k highmem)
Calibrating delay loop... 2891.77 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000
00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000
00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaa50, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fb490
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb4c0, dseg 0xf0000
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [pm]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver 2.1.6 [Flags: R/W].
udf: registering filesystem
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'serial'
pnp: match found with the PnP device '00:0f' and the driver 'serial'
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xc000, 00:0d:61:c9:d2:c6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
pnp: the driver 'ide' has been registered
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: WDC WD1600BB-00HTA0, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8582, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 240119615 sectors (122941 MB)
	native  capacity is 240121728 sectors (122942 MB)
hda: 240119615 sectors (122941 MB) w/2048KiB Cache, CHS=65535/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdb: max request size: 1024KiB
hdb: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63
 /dev/ide/host0/bus0/target1/lun0: unknown partition table
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05
15:41:49 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
BIOS EDD facility v0.12 2004-Jan-26, 2 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 10, pci mem e08f5000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem e08fc000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb 2-1: new full speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 7 ports detected
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed
Jan 14 18:29:26 PST 2004
found reiserfs format "3.6" with standard journal
usb 2-1.1: new low speed USB device using address 3
usb 2-1.2: new full speed USB device using address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0
alt 0 proto 2 vid 0x04B8 pid 0x0005
drivers/usb/core/usb.c: registered new driver hiddev
Reiserfs journal params: device hda4, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS RS
1000 FW:7.g3 .D USB FW:g3] on usb-0000:00:02.1-1.1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Reiserfs journal params: device hdb, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb) for (hdb)
Using r5 hash to sort names
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49342 usecs
intel8x0: clocking to 47368
Disabled Privacy Extensions on device c0428080(lo)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
process `named' is using obsolete setsockopt SO_BSDCOMPAT
smbfs: Unrecognized mount option noexec
eth0: no IPv6 routers present
0: NVRM: AGPGART: unable to retrieve symbol table
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
spurious 8259A interrupt: IRQ7.
Losing too many ticks!
TSC cannot be used as a timesource.  <4>Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.


