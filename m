Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUA1Kq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 05:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUA1Kq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 05:46:28 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:63759 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265900AbUA1KqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 05:46:23 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1075286311@astro.swin.edu.au>
Subject: Cursor disappears on console, no frame-buffer
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-26788-30547-200401282138-tc@hexane.ssi.swin.edu.au>
Date: Wed, 28 Jan 2004 21:46:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, a few kernel revisions ago, I experimented with the
frame-buffer. I don't know what I broke, but with nothing frame-buffer
related in the kernel (It could have been broken for a long time, I
don't use the console that much, but it certainly worked at one
stage):

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#

I no longer have a console mode cursor (after the first screen scrolls
by at bootup - there is a cursor until the cursor hits the bottom of
the screen -- it's like it just walked off the end).

This is on a laptop with an ATI Rage128 video card. For reference, X
works fine. I turned off the lilo graphical mode, and there is no
append=vga or anything now, so everything should be at the
defaults. Dmesg output is at bottom.

I have tested 2.6.0-test9 or so, and I think the same problem came up
(as well as many new ones, so it'll be a while before I test it again).


Linux version 2.4.25-pre7 (root@scuzzie) (gcc version 3.3.3 20040110 (prerelease) (Debian)) #1 Wed Jan 28 18:42:00 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffdb000 (usable)
 BIOS-e820: 000000000ffdb000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65499
zone(0): 4096 pages.
zone(1): 61403 pages.
zone(2): 0 pages.
Dell Inspiron machine detected. Enabling interrupts during APM calls.
Kernel command line: auto BOOT_IMAGE=linux ro root=303 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 651.490 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1300.88 BogoMIPS
Memory: 256396k/261996k available (1534k kernel code, 5212k reserved, 538k data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc13e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-220, ATA DISK drive
blk: queue c0347920, I/O limit 4095Mb (mask 0xffffffff)
hdc: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2432/255/63, UDMA(33)
hdc: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-224E           Rev: 3.7C
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
usb.c: registered new driver hub
Yenta ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000006
Yenta ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000020
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
host/uhci.c: USB UHCI at I/O 0xdce0, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: cb_alloc(bus 6): vendor 0x115d, device 0x0003
PCI: Enabling device 06:00.0 (0000 -> 0003)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
Adding Swap: 514040k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
mice: PS/2 mouse device common for all mice
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] AGP 0.99 Aperture @ 0xf4000000 64MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
xircom_tulip_cb.c derived from tulip.c:v0.91 4/14/99 becker@scyld.com
 unofficial 2.4.x kernel port, version 0.91+LK1.1, October 11, 2001
PCI: Setting latency timer of device 06:00.0 to 64
eth0: Xircom Cardbus Adapter rev 3 at 0x4800, 00:10:A4:8A:06:A3, IRQ 11.
eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
eth0: Link is up, running at 100Mbit half-duplex
Real Time Clock Driver v1.10f
PCI: Found IRQ 5 for device 00:08.0
maestro3: enabled hack for 'Dell Inspiron 4000'
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Press any key to continue, any other key to abort
           -- thrillbert's code
