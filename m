Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318994AbSH1VJy>; Wed, 28 Aug 2002 17:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318995AbSH1VJy>; Wed, 28 Aug 2002 17:09:54 -0400
Received: from smtp04.wxs.nl ([195.121.6.59]:42679 "EHLO smtp04.wxs.nl")
	by vger.kernel.org with ESMTP id <S318994AbSH1VJu>;
	Wed, 28 Aug 2002 17:09:50 -0400
Message-ID: <026701c24ed7$f7f8d450$0200a8c0@elvis>
From: "Jasper Verberk" <jasper.verberk@planet.nl>
To: <linux-kernel@vger.kernel.org>
Cc: <jasper.verberk@planet.nl>
Subject: problems with irq
Date: Wed, 28 Aug 2002 23:15:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

I'm having a problem with getting my soundcard too work on my laptop. (Acer
Travelmate 621LV). The chipset of my motherboard is i830 (and so it the
sound because it's all onboard)

I'm using Debian kernel 2.4.19 which I compiled from source.

The problem is: When I play sounds...I don't hear anything...or I hear it
very short...and after that my pc hangs, or sometimes recover after like 10
mins.
This both happens with the i810_audio driver as the alsa snd-intel8x0 (which
is currently installed). After much hours of looking for the problem I found
I'm getting errors about the irq's.

Here's a print of the dmesg file:

--------------------------------------------------------
Linux version 2.4.19 (root@Elvis-laptop) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Wed Aug 28 05:00:51 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7d0000 (usable)
 BIOS-e820: 000000000f7d0000 - 000000000f7e0000 (reserved)
 BIOS-e820: 000000000f7e0000 - 000000000f7e8000 (ACPI data)
 BIOS-e820: 000000000f7e8000 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 000000000f800000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
247MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 63440
zone(0): 4096 pages.
zone(1): 59344 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=303
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 999.894 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1854.66 BogoMIPS
Memory: 247948k/253760k available (1610k kernel code, 5424k reserved, 628k
data, 124k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 989.9863 MHz.
..... host bus clock speed is 131.9980 MHz.
cpu: 0, clocks: 1319980, slice: 659990
CPU0<T0:1319968,T1:659968,D:10,S:659990,C:1319980>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:02.0
PCI: Sharing IRQ 11 with 00:1d.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1d.1
IRQ routing conflict for 00:1f.3, have irq 10, want irq 11
IRQ routing conflict for 00:1f.5, have irq 10, want irq 11
IRQ routing conflict for 00:1f.6, have irq 10, want irq 11
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
IRQ routing conflict for 01:09.1, have irq 10, want irq 11
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:02.0
PCI: Sharing IRQ 11 with 00:1d.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa890-0xa897, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa898-0xa89f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATDA04-0, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=3648/255/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 < hda5 > hda3
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.4.21)
Compaq CISS Driver (v 2.4.5)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
ide-floppy driver 0.99.newide
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found
Highpoint HPT370 Softwareraid driver for linux version 0.01
No raid array found
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 01:09.0
PCI: Sharing IRQ 11 with 00:1d.1
IRQ routing conflict for 00:1f.3, have irq 10, want irq 11
IRQ routing conflict for 00:1f.5, have irq 10, want irq 11
IRQ routing conflict for 00:1f.6, have irq 10, want irq 11
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
IRQ routing conflict for 01:09.1, have irq 10, want irq 11
PCI: Found IRQ 11 for device 01:09.1
PCI: Sharing IRQ 11 with 00:1d.1
IRQ routing conflict for 00:1f.3, have irq 10, want irq 11
IRQ routing conflict for 00:1f.5, have irq 10, want irq 11
IRQ routing conflict for 00:1f.6, have irq 10, want irq 11
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
IRQ routing conflict for 01:09.1, have irq 10, want irq 11
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 08b8, PCI irq10
Socket status: 30000410
Yenta IRQ list 08b8, PCI irq10
Socket status: 30000410
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding Swap: 96352k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 05:09:58 Aug 28 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 00:02.0
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xa4a0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.1
IRQ routing conflict for 00:1f.3, have irq 10, want irq 11
IRQ routing conflict for 00:1f.5, have irq 10, want irq 11
IRQ routing conflict for 00:1f.6, have irq 10, want irq 11
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
IRQ routing conflict for 01:09.1, have irq 10, want irq 11
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xa4e0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.2
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver keyboard
usbkbd.c: :USB HID Boot Protocol keyboard driver
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 01:08.0
eth0: Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller,
00:00:E2:64:FD:F6, IRQ 10.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
----------------------------------------------------------------------------
----

Notice the:
PCI: Found IRQ 11 for device 00:1d.1
IRQ routing conflict for 00:1f.3, have irq 10, want irq 11
IRQ routing conflict for 00:1f.5, have irq 10, want irq 11
IRQ routing conflict for 00:1f.6, have irq 10, want irq 11
IRQ routing conflict for 01:09.0, have irq 10, want irq 11
IRQ routing conflict for 01:09.1, have irq 10, want irq 11

which is in there several times...I'm under the impression that this is
causing the soundcard too NOT work properly.

Does anyone have a idea if there's a fix for this? or did you ever see this
before?

I would like to receive replies/answers/ideas at jasper.verberk@planet.nl

Kind regards and thanks in advance,

Jasper Verberk
The Netherlands

