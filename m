Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTIEBxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTIEBxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:53:20 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:36266 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261947AbTIEBwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:52:55 -0400
Message-ID: <3F57EC78.80801@ameritech.net>
Date: Thu, 04 Sep 2003 20:52:56 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4  on to mpegs and DVB
References: <3F560DC6.2090709@ameritech.net>	<3F57D776.4050404@ameritech.net> <20030904173901.7ab1b4bb.akpm@osdl.org>
In-Reply-To: <20030904173901.7ab1b4bb.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020603030504010107010807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020603030504010107010807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> watermodem <aquamodem@ameritech.net> wrote:
> 
>>The DVD looked and sounded great, but, it was using 
>> 98% of the CPU!  2.4 never used that much.
> 
> 
> A kernel profile will be needed to diagnose this further.  Please see
> Documentation/basic_profiling.txt
> 
> Also check that you have selected the correct IDE chipsets in
> configuration.  And post your dmesg output, especially the IDE bits.

Full mesg attached with IDE stuff included.
Will try to do the profiling this weekend.
DVD app was XINE.  I can provide the config files for it if it would be 
useful.

Also, included: lspci -v, cat /proc/ide/via, and cat settings (DVD)

*** it is interesting that it is identifying the wrong cable type for 
the secondary IDE (DVD/CD) as it most definitely is an 80 wire one.

lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev 44)
         Subsystem: Giga-byte Technology VT82C691 Apollo Pro System 
Controller
         Flags: bus master, medium devsel, latency 16
         Memory at e2000000 (32-bit, prefetchable) [size=32M]
         Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: e0000000-e1ffffff
         Prefetchable memory behind bridge: d8000000-dfffffff
         Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 23)
         Subsystem: Giga-byte Technology VT82C596/A/B PCI to ISA Bridge
         Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) 
(prog-if 8a [Master SecP PriP])
         Flags: bus master, medium devsel, latency 64
         I/O ports at d000 [size=16]
         Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 11) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 64, IRQ 10
         I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management 
(rev 30)
         Flags: medium devsel

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 02)
         Subsystem: Intel Corp. EtherExpress PRO/100B (TX)
         Flags: bus master, medium devsel, latency 64, IRQ 11
         Memory at e5100000 (32-bit, prefetchable) [size=4K]
         I/O ports at d800 [size=32]
         Memory at e5000000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at e4000000 [disabled] [size=1M]

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
         Subsystem: Creative Labs CT4780 SBLive! Value
         Flags: bus master, medium devsel, latency 64, IRQ 5
         I/O ports at dc00 [size=32]
         Capabilities: [dc] Power Management version 1

00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 0a)
         Subsystem: Creative Labs Gameport Joystick
         Flags: bus master, medium devsel, latency 64
         I/O ports at e000 [size=8]
         Capabilities: [dc] Power Management version 1

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
         Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
         Flags: bus master, medium devsel, latency 64, IRQ 10
         Memory at e5101000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
         Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo 
receiver, audio section)
         Flags: bus master, medium devsel, latency 64, IRQ 10
         Memory at e5102000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev a1) (prog-if 00 [VGA])
         Subsystem: ABIT Computer Corp.: Unknown device 6105
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
         Memory at d8000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
         Capabilities: [44] AGP version 2.0

cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt82c596b
Revision:                           ISA 0x23 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       DMA      UDMA
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          30ns      30ns     120ns      60ns
Transfer Rate:   66.6MB/s  66.6MB/s  16.6MB/s  33.3MB/s

IDE drive3 is the DVD:
cat settings
name                value           min             max             mode
----                -----           ---             ---             ----
current_speed       66              0               70              rw
dsc_overlap         1               0               1               rw
ide-scsi            0               0               1               rw
init_speed          12              0               70              rw
io_32bit            1               0               3               rw
keepsettings        0               0               1               rw
nice1               1               0               1               rw
number              3               0               3               rw
pio_mode            write-only      0               255             w
slow                0               0               1               rw
unmaskirq           1               0               1               rw
using_dma           1               0               1               rw


--------------020603030504010107010807
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.0-test4 (root@dali.xxxx.com) (gcc version 3.3.1 (Mandrake Linux 9.2 3.3.1-0.7mdk)) #2 Tue Sep 2 19:55:57 CDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037ff0000 (usable)
 BIOS-e820: 0000000037ff0000 - 0000000037ff3000 (ACPI NVS)
 BIOS-e820: 0000000037ff3000 - 0000000038000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
895MB LOWMEM available.
On node 0 totalpages: 229360
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225264 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6b60
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x37ff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x37ff3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=new_linux ro root=341 devfs=mount video=rivafb:1024x768-24@100 -s
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 997.705 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1970.17 BogoMIPS
Memory: 903208k/917440k available (2797k kernel code, 13452k reserved, 1085k data, 188k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 997.0249 MHz.
..... host bus clock speed is 132.0966 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.3
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0a.1
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0b.1
PM: Adding info for pci:0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc060
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc088, dseg 0xf0000
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
rivafb: nVidia device/chipset 10DE0110
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-M, 32MB @ 0xD8000000)
pty: 256 Unix98 ptys configured
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
ikconfig 0.5 with /proc/ikconfig
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
Activating ISA DMA hang workarounds.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11a
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy0
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection

Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD600BB-32BSA0, ATA DISK drive
PM: Adding info for No Bus:ide0
hdb: WDC WD800BB-75CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
PM: Adding info for ide:0.1
hdc: SAMSUNG CD-R/RW SW-216B Q001 20010913, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
PM: Adding info for ide:1.1
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: Host Protected Area detected.
	current capacity is 156250000 sectors (80000 MB)
	native  capacity is 156301488 sectors (80026 MB)
hdb: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 >
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 10, io base 0000d400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 12
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver module version 2.7.0 (20021208)
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Blaster Live! (rev.10) at 0xdc00, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
ACPI: (supports S0 S1 S4 S4bios S5)
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
hub 1-0:0: new USB device on port 1, assigned address 2
PM: Adding info for usb:1-1
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:07.2-1
PM: Adding info for usb:1-1:0
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
PM: Adding info for usb:1-2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x3002
PM: Adding info for usb:1-2:0
EXT3 FS on hdb1, internal journal
Adding 2096472k swap on /dev/hdb2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS-fs warning (device hda1): parse_options(): Option iocharset is deprecated. Please use option nls=<charsetname> in the future.
NTFS volume version 3.0.
serio: kseriod exiting
exiting...exiting...<3>e100: eth0 NIC Link is Up 100 Mbps Full duplex
microcode: CPU0 already at revision 1 (current=1)
microcode: freed 2048 bytes
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
smbfs: Unrecognized mount option noexec
smbfs: Unrecognized mount option noexec

--------------020603030504010107010807--

