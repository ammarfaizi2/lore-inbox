Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTGRVdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271925AbTGRVdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:33:55 -0400
Received: from server.snowfall.se ([213.136.34.4]:3077 "EHLO mail.snowfall.se")
	by vger.kernel.org with ESMTP id S271898AbTGRV3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:29:23 -0400
Date: Fri, 18 Jul 2003 23:44:18 +0200 (CEST)
From: Stefan Cars <stefan@snowfall.se>
X-X-Sender: stefan@guldivar.globalwire.se
To: linux-kernel@vger.kernel.org
Subject: ICH5 SATA high interrupt/system load again...
Message-ID: <20030718233631.F31074@guldivar.globalwire.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've seen the discussion regarding high interrupt / system load on the
ICH5 SATA and I'm asking what todo about it if I can't put my BIOS into
"normal" mode. This machine is an Dell Precision 360 and for some stupid
reason they have for this model removed the possibility in the BIOS to
change this sort of things (you can't change much really). I'm using
2.4.21-ac4. Just to extract a simple tar file brings the system load up
and the computer is slow...


Here is some info:






tjatte:/import# cat /proc/interrupts
           CPU0
  0:     557725          XT-PIC  timer
  1:        102          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ehci_hcd
  9:   16409116          XT-PIC  libata, usb-uhci, eth0
 10:          0          XT-PIC  usb-uhci
 11:          0          XT-PIC  usb-uhci, usb-uhci
 15:          3          XT-PIC  ide1
NMI:          0
ERR:          0
tjatte:/import#



tjatte:/import# dmesg
Linux version 2.4.21-ac4 (root@tjatte) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Fri Jul 18 14:35:56 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff74000 (usable)
 BIOS-e820: 000000001ff74000 - 000000001ff76000 (ACPI NVS)
 BIOS-e820: 000000001ff76000 - 000000001ff97000 (ACPI data)
 BIOS-e820: 000000001ff97000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130932
zone(0): 4096 pages.
zone(1): 126836 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda3 ro
Initializing CPU#0
Detected 2593.549 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5177.34 BogoMIPS
Memory: 514828k/523728k available (1776k kernel code, 8516k reserved, 719k
data, 100k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfba8a, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router default [8086/24d0] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/O]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Intel chipset (device id: 2578), you might want to
try agp_try_unsupported=1.
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.7.0 20020828 on minor 1
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ata_piix version 0.9
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: SATA max UDMA/100 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 9
ata2: SATA max UDMA/100 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 9
ata1: dev 0 ATA, max UDMA/133, 234375000 sectors
ata1: dev 0 configured for UDMA/100
ata2: thread exiting
scsi1 : ata_piix
scsi2 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 0.51
  Type:   Direct-Access                      ANSI SCSI revision: 05
libata version 0.51 loaded.
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 234375000 512-byte hdwr sectors (120000 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2
ehci_hcd 00:1d.7: irq 5, pci mem e0821800
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 128.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-12/2.4
hub.c: USB hub found
hub.c: 8 ports detected
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
host/uhci.c: USB UHCI at I/O 0xff80, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
host/uhci.c: USB UHCI at I/O 0xff60, IRQ 10
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
host/uhci.c: USB UHCI at I/O 0xff40, IRQ 9
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
host/uhci.c: USB UHCI at I/O 0xff20, IRQ 11
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 100k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
hub.c: new USB device 00:1d.2-2, assigned address 2
input0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb4:2.0
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex

