Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbSK3MF0>; Sat, 30 Nov 2002 07:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbSK3MF0>; Sat, 30 Nov 2002 07:05:26 -0500
Received: from pilt.cultus.no ([194.248.142.50]:36368 "EHLO pilt.cultus.no")
	by vger.kernel.org with ESMTP id <S267233AbSK3MFX>;
	Sat, 30 Nov 2002 07:05:23 -0500
Message-ID: <3DE8AB3E.8070400@cultus.no>
Date: Sat, 30 Nov 2002 13:12:46 +0100
From: Jens-Christian Skibakk <jens@cultus.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DRI doesn't work with Radeon 7500 on Dell Inspiron 4150.


Both glxgears and tuxracer crashes with the Illegal instruction error message.
the strace output of glxgears is:

If I doesn't load the DRI module into X, both glxgears and tuxracer works, but of course without HW-redering.

XFree86 version: 4.2.1
binutils: 2.13.90.0.10-1

debian:~# strace glxgears
.
.
.
open("/dev/dri/card0", O_RDWR)          = 4
.
.
.
brk(0x80c1000)                          = 0x80c1000
ioctl(3, 0x541b, [0])                   = 0
ioctl(4, 0x40186448, 0xbffff904)        = 0
--- SIGILL (Illegal instruction) ---
+++ killed by SIGILL +++


Output of dmesg after the crash is (no errors concerning the Illegal instruction):

Linux version 2.4.20-ac1 (root@debian) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sat Nov 30 12:05:10 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffe2800 (usable)
 BIOS-e820: 000000000ffe2800 - 0000000010000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65506
zone(0): 4096 pages.
zone(1): 61410 pages.
zone(2): 0 pages.
Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
Kernel command line: BOOT_IMAGE=2.4.20-ac1 ro root=304
Initializing CPU#0
Detected 1695.030 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 254332k/262024k available (1112k kernel code, 5260k reserved, 296k data, 248k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=32047 max_file_pages=0 max_inodes=0 max_dentries=32047
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.70GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 02:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.5
Real Time Clock Driver v1.10e
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1f.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.18-ac
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] AGP 0.99 on Intel i845 @ 0xe8000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 02:00.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
hda: IC25N040ATCS05-0, ATA DISK drive
blk: queue c02d1920, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=4864/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
Intel 810 + AC97 Audio, version 0.24, 12:05:56 Nov 30 2002
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH3 found at IO 0xdc80 and 0xd800, MEM 0x0000 and 0x0000, IRQ 11
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: CRY91 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 248k freed
hub.c: new USB device 00:1d.0-1, assigned address 2
input0: USB HID v1.00 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye?] on usb1:2.0
Adding Swap: 498004k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mod




