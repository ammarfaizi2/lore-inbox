Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271717AbTG2N3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271728AbTG2N3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:29:43 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:2787 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271717AbTG2N3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:29:11 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <herbert@13thfloor.at>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problems related to DMA or DDR memory on Intel 845 chipset?
Date: Tue, 29 Jul 2003 09:40:35 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGOELDCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <20030728202845.GA10304@www.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>so there is some device attached to what? which uses
>DMA transfers (busmaster?) to receive/send data from/to
>memory, and after your device 'thinks' the dma is done,
>it asserts an interrupt, which sometimes gets lost?

We are attached to some industrial equipment.  Yes, DMA busmaster.  Yes, the
device asserts it's interrupt.  At some point things get totally hosed and
that interrupt never gets through.  We then have to reset the machine . . .

>this would suggest that your external hardware is
>broken, maybe the signal is to weak or not within
>the requiered timing parameters ...

. . . sounds likely.  We are investigating this further.

>> . . . Meanwhile, I made another discovery on the internet that indicates
>> that DMA is not supported with an ICH4 controller (which is what this
system

>sorry, you are mixing up completely different things ...
>UDMA is a transfer mode used by IDE, which is referred on
>this page.

Thanks.  A couple of others have responded similarly.

>does your device use the IDE interface and compy to
>at least ATA/33, then UDMA is something which should
>be of concern to you ...

Nope, we don't use the IDE interface.

>please try to describe the setup more technically, because
>otherwise it is not possible to say anything ...

We are using the ASUS P4PE MoBo (chipsets:  Intel 82845PE MCH and Intel
82801DB ICH4).  FSB: 533 MHz
Below you'll find additional info on the system.  Please let me know what
additional information you might need.

Thanks!
Kathy


Results of lpci:

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
(rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra
TF
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:09.0 Communication controller: Altera Corporation PCI Fiber Optic Engrave
Interface (rev 02)


The following is from the messages file:

Jul 22 04:11:45 rti10 syslogd 1.4.1: restart.
Jul 22 03:02:05 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:04:25 rti10 kernel: hda: dma_intr: status=0x50 { DriveReady
SeekComplete }
Jul 22 03:16:05 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:16:25 rti10 kernel:
Jul 22 03:21:05 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:23:05 rti10 kernel: hdc: lost interrupt
Jul 22 03:27:45 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:29:45 rti10 kernel: hdc: lost interrupt
Jul 22 03:34:25 rti10 cups: cupsd startup succeeded
Jul 22 08:22:27 rti10 syslogd 1.4.1: restart.
Jul 22 08:22:27 rti10 syslog: syslogd startup succeeded
Jul 22 08:22:27 rti10 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 22 08:22:27 rti10 kernel: Linux version 2.4.20-8
(bhcompile@porky.devel.redhat.com) (gcc version 3.2.2 20030222 (Red Hat
Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
Jul 22 08:22:27 rti10 kernel: BIOS-provided physical RAM map:
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 0000000000100000 -
000000001ffec000 (usable)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000001ffec000 -
000000001ffef000 (ACPI data)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000001ffef000 -
000000001ffff000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000001ffff000 -
0000000020000000 (ACPI NVS)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Jul 22 08:22:27 rti10 kernel: 0MB HIGHMEM available.
Jul 22 08:22:27 rti10 kernel: 511MB LOWMEM available.
Jul 22 08:22:27 rti10 kernel: On node 0 totalpages: 131052
Jul 22 08:22:27 rti10 kernel: zone(0): 4096 pages.
Jul 22 08:22:27 rti10 kernel: zone(1): 126956 pages.
Jul 22 08:22:27 rti10 kernel: zone(2): 0 pages.
Jul 22 08:22:27 rti10 kernel: Kernel command line: ro root=LABEL=/
Jul 22 08:22:27 rti10 kernel: Initializing CPU#0
Jul 22 08:22:27 rti10 kernel: Detected 2405.482 MHz processor.
Jul 22 08:22:27 rti10 kernel: Console: colour VGA+ 80x25
Jul 22 08:22:27 rti10 kernel: Calibrating delay loop... 4797.23 BogoMIPS
Jul 22 08:22:27 rti10 kernel: Memory: 511336k/524208k available (1347k
kernel code, 10308k reserved, 999k data, 132k init, 0k highmem)
Jul 22 08:22:27 rti10 kernel: Dentry cache hash table entries: 65536 (order:
7, 524288 bytes)
Jul 22 08:22:27 rti10 kernel: Inode cache hash table entries: 32768 (order:
6, 262144 bytes)
Jul 22 08:22:27 rti10 kernel: Mount cache hash table entries: 512 (order: 0,
4096 bytes)
Jul 22 08:22:27 rti10 kernel: Buffer-cache hash table entries: 32768 (order:
5, 131072 bytes)
Jul 22 08:22:27 rti10 kernel: Page-cache hash table entries: 131072 (order:
7, 524288 bytes)
Jul 22 08:22:27 rti10 syslog: klogd startup succeeded
Jul 22 08:22:27 rti10 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul 22 08:22:27 rti10 kernel: CPU: L2 cache: 512K
Jul 22 08:22:27 rti10 kernel: Intel machine check architecture supported.
Jul 22 08:22:27 rti10 kernel: Intel machine check reporting enabled on
CPU#0.
Jul 22 08:22:27 rti10 portmap: portmap startup succeeded
Jul 22 08:22:27 rti10 kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping 07
Jul 22 08:22:28 rti10 kernel: Enabling fast FPU save and restore... done.
Jul 22 08:22:28 rti10 nfslock: rpc.statd startup succeeded
Jul 22 08:22:28 rti10 kernel: Enabling unmasked SIMD FPU exception
support... done.
Jul 22 08:22:28 rti10 rpc.statd[3174]: Version 1.0.1 Starting
Jul 22 08:22:28 rti10 kernel: Checking 'hlt' instruction... OK.
Jul 22 08:22:28 rti10 keytable:
Jul 22 08:22:28 rti10 kernel: POSIX conformance testing by UNIFIX
Jul 22 08:22:28 rti10 keytable: Loading system font:
Jul 22 08:22:28 rti10 kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Jul 22 08:22:28 rti10 kernel: mtrr: detected mtrr type: Intel
Jul 22 08:22:28 rti10 kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1e50,
last bus=2
Jul 22 08:22:28 rti10 kernel: PCI: Using configuration type 1
Jul 22 08:22:28 rti10 kernel: PCI: Probing PCI hardware
Jul 22 08:22:28 rti10 kernel: PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Jul 22 08:22:28 rti10 kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB
PCI Bridge
Jul 22 08:22:28 rti10 kernel: PCI: Using IRQ router PIIX [8086/24c0] at
00:1f.0
Jul 22 08:22:28 rti10 kernel: isapnp: Scanning for PnP cards...
Jul 22 08:22:28 rti10 kernel: isapnp: No Plug & Play device found
Jul 22 08:22:28 rti10 kernel: Linux NET4.0 for Linux 2.4
Jul 22 08:22:28 rti10 kernel: Based upon Swansea University Computer Society
NET3.039
Jul 22 08:22:28 rti10 kernel: Initializing RT netlink socket
Jul 22 08:22:28 rti10 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16)
Jul 22 08:22:28 rti10 kernel: Starting kswapd
Jul 22 08:22:28 rti10 kernel: VFS: Disk quotas vdquot_6.5.1
Jul 22 08:22:28 rti10 kernel: pty: 2048 Unix98 ptys configured
Jul 22 08:22:28 rti10 kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jul 22 08:22:28 rti10 kernel: ttyS0 at 0x03f8 (irq = 4) is a 16550A
Jul 22 08:22:28 rti10 kernel: ttyS1 at 0x02f8 (irq = 3) is a 16550A
Jul 22 08:22:28 rti10 keytable:
Jul 22 08:22:28 rti10 kernel: Real Time Clock Driver v1.10e
Jul 22 08:22:28 rti10 rc: Starting keytable:  succeeded
Jul 22 08:22:28 rti10 kernel: Floppy drive(s): fd0 is 1.44M
Jul 22 08:22:28 rti10 kernel: FDC 0 is a post-1991 82077
Jul 22 08:22:28 rti10 kernel: NET4: Frame Diverter 0.46
Jul 22 08:22:28 rti10 kernel: RAMDISK driver initialized: 16 RAM disks of
4096K size 1024 blocksize
Jul 22 08:22:28 rti10 kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00beta-2.4
Jul 22 08:22:28 rti10 kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jul 22 08:22:28 rti10 kernel: ICH4: IDE controller at PCI slot 00:1f.1
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 11 for device 00:1f.1
Jul 22 08:22:28 rti10 kernel: PCI: Sharing IRQ 11 with 00:1d.2
Jul 22 08:22:28 rti10 kernel: ICH4: chipset revision 2
Jul 22 08:22:28 rti10 kernel: ICH4: not 100%% native mode: will probe irqs
later
Jul 22 08:22:28 rti10 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Jul 22 08:22:28 rti10 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:pio
Jul 22 08:22:28 rti10 kernel: hda: ST340016A, ATA DISK drive
Jul 22 08:22:28 rti10 kernel: blk: queue c03c9f40, I/O limit 4095Mb (mask
0xffffffff)
Jul 22 08:22:28 rti10 kernel: hdc: FX54++W, ATAPI CD/DVD-ROM drive
Jul 22 08:22:28 rti10 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 22 08:22:28 rti10 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 22 08:22:28 rti10 kernel: hda: host protected area => 1
Jul 22 08:22:28 rti10 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=4865/255/63, UDMA(100)
Jul 22 08:22:28 rti10 kernel: ide-floppy driver 0.99.newide
Jul 22 08:22:28 rti10 kernel: Partition check:
Jul 22 08:22:28 rti10 kernel:  hda: hda1 hda2 hda3
Jul 22 08:22:28 rti10 kernel: ide-floppy driver 0.99.newide
Jul 22 08:22:28 rti10 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Jul 22 08:22:28 rti10 kernel: md: Autodetecting RAID arrays.
Jul 22 08:22:28 rti10 random: Initializing random number generator:
succeeded
Jul 22 08:22:28 rti10 kernel: md: autorun ...
Jul 22 08:22:28 rti10 kernel: md: ... autorun DONE.
Jul 22 08:22:28 rti10 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 22 08:22:28 rti10 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jul 22 08:22:28 rti10 kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Jul 22 08:22:28 rti10 kernel: TCP: Hash tables configured (established 32768
bind 65536)
Jul 22 08:22:28 rti10 kernel: Linux IP multicast router 0.06 plus PIM-SM
Jul 22 08:22:28 rti10 kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jul 22 08:22:28 rti10 kernel: RAMDISK: Compressed image found at block 0
Jul 22 08:22:28 rti10 kernel: Freeing initrd memory: 146k freed
Jul 22 08:22:28 rti10 kernel: VFS: Mounted root (ext2 filesystem).
Jul 22 08:22:28 rti10 kernel: Journalled Block Device driver loaded
Jul 22 08:22:28 rti10 kernel: EXT3-fs: INFO: recovery required on readonly
filesystem.
Jul 22 08:22:28 rti10 kernel: EXT3-fs: write access will be enabled during
recovery.
Jul 22 08:22:28 rti10 kernel: kjournald starting.  Commit interval 5 seconds
Jul 22 08:22:28 rti10 kernel: EXT3-fs: ide0(3,2): orphan cleanup on readonly
fs
Jul 22 08:22:28 rti10 rc: Starting pcmcia:  succeeded
Jul 22 08:22:28 rti10 netfs: Mounting other filesystems:  succeeded
Jul 22 08:22:28 rti10 kernel: EXT3-fs: ide0(3,2): 4 orphan inodes deleted
Jul 22 08:22:28 rti10 aksparlnx: Loading Aladdin HASP/Hardlock driver:
Jul 22 08:22:28 rti10 kernel: EXT3-fs: recovery complete.
Jul 22 08:22:28 rti10 kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jul 22 08:22:28 rti10 kernel: Freeing unused kernel memory: 132k freed
Jul 22 08:22:28 rti10 kernel: usb.c: registered new driver usbdevfs
Jul 22 08:22:28 rti10 kernel: usb.c: registered new driver hub
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: $Revision: 1.275 $ time 17:59:01
Mar 13 2003
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: High bandwidth mode enabled
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 5 for device 00:1d.0
Jul 22 08:22:28 rti10 kernel: PCI: Sharing IRQ 5 with 01:00.0
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: USB UHCI at I/O 0xb800, IRQ 5
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: Detected 2 ports
Jul 22 08:22:28 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 1
Jul 22 08:22:28 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:28 rti10 kernel: hub.c: 2 ports detected
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 5 for device 00:1d.1
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 5
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: Detected 2 ports
Jul 22 08:22:28 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 2
Jul 22 08:22:28 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:28 rti10 kernel: hub.c: 2 ports detected
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 11 for device 00:1d.2
Jul 22 08:22:28 rti10 kernel: PCI: Sharing IRQ 11 with 00:1f.1
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 11
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: Detected 2 ports
Jul 22 08:22:28 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 3
Jul 22 08:22:28 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:28 rti10 kernel: hub.c: 2 ports detected
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: v1.275:USB Universal Host
Controller Interface driver
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 9 for device 00:1d.7
Jul 22 08:22:28 rti10 kernel: ehci-hcd 00:1d.7: Intel Corp. 82801DB USB EHCI
Controller
Jul 22 08:22:28 rti10 kernel: ehci-hcd 00:1d.7: irq 9, pci mem e0851000
Jul 22 08:22:29 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 4
Jul 22 08:22:29 rti10 kernel: ehci-hcd 00:1d.7: enabled 64bit PCI DMA
Jul 22 08:22:29 rti10 kernel: PCI: 00:1d.7 PCI cache line size set
incorrectly (0 bytes) by BIOS/FW.
Jul 22 08:22:29 rti10 kernel: PCI: 00:1d.7 PCI cache line size corrected to
128.
Jul 22 08:22:29 rti10 kernel: ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00,
driver 2003-Jan-22
Jul 22 08:22:29 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:29 rti10 kernel: hub.c: 6 ports detected
Jul 22 08:22:29 rti10 kernel: usb.c: registered new driver hiddev
Jul 22 08:22:29 rti10 kernel: usb.c: registered new driver hid
Jul 22 08:22:29 rti10 kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik
<vojtech@suse.cz>
Jul 22 08:22:29 rti10 kernel: hid-core.c: USB HID support drivers
Jul 22 08:22:29 rti10 kernel: mice: PS/2 mouse device common for all mice
Jul 22 08:22:29 rti10 kernel: hub.c: connect-debounce failed, port 2
disabled
Jul 22 08:22:29 rti10 kernel: hub.c: new USB device 00:1d.2-2, assigned
address 2
Jul 22 08:22:29 rti10 kernel: usb.c: USB device 2 (vend/prod 0x529/0x1) is
not claimed by any active driver.
Jul 22 08:22:29 rti10 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,2), internal journal
Jul 22 08:22:29 rti10 kernel: Adding Swap: 1044216k swap-space (priority -1)
Jul 22 08:22:29 rti10 aksparlnx: Warning: kernel-module version mismatch
Jul 22 08:22:29 rti10 kernel: kjournald starting.  Commit interval 5 seconds
Jul 22 08:22:29 rti10 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,1), internal journal
Jul 22 08:22:29 rti10 aksparlnx: ^I/opt/aksparlnx/drv/2.4.19/aksparlnx.o was
compiled for kernel version 2.4.19
Jul 22 08:22:29 rti10 kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jul 22 08:22:29 rti10 aksparlnx: ^Iwhile this kernel is version 2.4.20-8
Jul 22 08:22:29 rti10 kernel: ohci1394: $Rev: 693 $ Ben Collins
<bcollins@debian.org>
Jul 22 08:22:29 rti10 aksparlnx: Warning: loading
/opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: non-GPL
license - Copyright 1999-2002 Aladdin Knowledge Systems.
Jul 22 08:22:29 rti10 kernel: PCI: Found IRQ 11 for device 02:03.0
Jul 22 08:22:29 rti10 aksparlnx:   See
http://www.tux.org/lkml/#export-tainted for information about tainted
modules
Jul 22 08:22:29 rti10 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]
MMIO=[f2000000-f20007ff]  Max Packet=[2048]
Jul 22 08:22:29 rti10 aksparlnx: Warning: loading
/opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: forced load
Jul 22 08:22:29 rti10 kernel: ieee1394: SelfID completion called outside of
bus reset!
Jul 22 08:22:29 rti10 aksparlnx: Module aksparlnx loaded, with warnings
Jul 22 08:22:29 rti10 kernel: parport0: PC-style at 0x378
[PCSPP,TRISTATE,EPP]
Jul 22 08:22:29 rti10 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 22 08:22:29 rti10 kernel: Broadcom 4401 Ethernet Driver bcm4400 ver.
1.0.1 (08/26/02)
Jul 22 08:22:29 rti10 kernel: PCI: Found IRQ 11 for device 02:05.0
Jul 22 08:22:29 rti10 aksparlnx:
Jul 22 08:22:29 rti10 kernel: eth0: Broadcom BCM4401 100Base-T found at mem
f1800000, IRQ 11, node addr 00e018ff35ec
Jul 22 08:22:29 rti10 rc: Starting aksparlnx:  succeeded
Jul 22 08:22:29 rti10 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 22 08:22:29 rti10 kernel: parport0: PC-style at 0x378
[PCSPP,TRISTATE,EPP]
Jul 22 08:22:29 rti10 kernel: aksparlnx: EYE/HASP driver v1.05/API
v3.81/major 60 loaded (ppi)
Jul 22 08:22:29 rti10 apmd[3251]: Version 3.0.2 (APM BIOS 1.2, Linux driver
1.16)
Jul 22 08:22:29 rti10 apmd: apmd startup succeeded
Jul 22 08:22:29 rti10 aksusbd[3263]: loaded, daemon version: 1.5, key API
(USB) version: 3.81, key API (parallel) version: 3.81
Jul 22 08:22:29 rti10 aksusbd: aksusbd startup succeeded
Jul 22 08:22:29 rti10 automount[3315]: starting automounter version 3.1.7,
path = /home, maptype = file, mapname = /etc/auto.home
Jul 22 08:22:29 rti10 autofs: automount startup succeeded
Jul 22 08:22:29 rti10 kernel: bcm4400: eth0 NIC Link is Up, 100 Mbps full
duplex
Jul 22 08:22:29 rti10 automount[3315]: using kernel protocol version 3
Jul 22 08:22:25 rti10 network: Setting network parameters:  succeeded
Jul 22 08:22:25 rti10 network: Bringing up loopback interface:  succeeded
Jul 22 08:22:29 rti10 sshd:  succeeded
Jul 22 08:22:30 rti10 apmd[3251]: Charge: * * * (-1% unknown)
Jul 22 08:22:31 rti10 xinetd[3343]: xinetd Version 2.3.10 started with
libwrap options compiled in.
Jul 22 08:22:31 rti10 xinetd[3343]: Started working: 2 available services
Jul 22 08:22:31 rti10 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 22 08:22:33 rti10 xinetd: xinetd startup succeeded
Jul 22 08:22:33 rti10 exportfs[3352]: No 'sync' or 'async' option specified
for export "*:/export/home".   Assuming default behaviour ('sync').   NOTE:
this default has changed from previous versions
Jul 22 08:22:33 rti10 exportfs: exportfs: No 'sync' or 'async' option
specified for export "*:/export/home".
Jul 22 08:22:33 rti10 exportfs:   Assuming default behaviour ('sync').
Jul 22 08:22:33 rti10 exportfs:   NOTE: this default has changed from
previous versions
Jul 22 08:22:33 rti10 kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Jul 22 08:22:33 rti10 nfs: Starting NFS services:  succeeded
Jul 22 08:22:33 rti10 nfs: rpc.rquotad startup succeeded
Jul 22 08:22:33 rti10 nfs: rpc.nfsd startup succeeded
Jul 22 08:22:33 rti10 nfs: rpc.mountd startup succeeded
Jul 22 08:22:33 rti10 vsftpd: true startup succeeded
Jul 22 08:22:33 rti10 amd[3396]: switched to logfile "syslog"
Jul 22 08:22:33 rti10 amd[3396]: AM-UTILS VERSION INFORMATION:
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1997-2003 Erez Zadok
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1990 Jan-Simon Pendry
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1990 Imperial College of
Science, Technology & Medicine
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1990 The Regents of the
University of California.
Jul 22 08:22:33 rti10 amd[3396]: am-utils version 6.0.9 (build 1).
Jul 22 08:22:33 rti10 amd[3396]: Built by root@sylvester.devel.redhat.com on
date Tue Feb  4 05:46:40 EST 2003.
Jul 22 08:22:33 rti10 amd[3396]: cpu=i386 (little-endian), arch=i386,
karch=i686.
Jul 22 08:22:33 rti10 amd[3396]: full_os=linux, os=linux,
osver=2.4.20-2.25smp, vendor=redhat.
Jul 22 08:22:33 rti10 amd[3396]: Map support for: root, passwd, hesiod,
ldap, union, nisplus, nis, ndbm, file, error.
Jul 22 08:22:33 rti10 amd[3396]: AMFS: nfs, link, nfsx, nfsl, host, linkx,
program, union, inherit, ufs,
Jul 22 08:22:33 rti10 amd[3396]:       lofs, cdfs, auto, direct, toplvl,
error.
Jul 22 08:22:33 rti10 amd: Jul 22 08:22:33 rti10 amd[3396]/info:  using
configuration file /etc/amd.conf
Jul 22 08:22:33 rti10 amd[3396]: FS: iso9660, lofs, nfs, nfs3, tmpfs, ext2.
Jul 22 08:22:33 rti10 amd[3396]: Network: wire="192.9.200.0"
(netnumber=192.9.200).
Jul 22 08:22:33 rti10 amd[3396]: My ip addr is 192.9.200.239
Jul 22 08:22:33 rti10 amd[3397]: released controlling tty using setsid()
Jul 22 08:22:33 rti10 amd[3397]: file server localhost, type local, state
starts up
Jul 22 08:22:33 rti10 amd[3397]: /dev/hda2 restarted fstype link on /
Jul 22 08:22:33 rti10 amd[3397]: none restarted fstype link on /proc
Jul 22 08:22:33 rti10 amd[3397]: usbdevfs restarted fstype link on
/proc/bus/usb
Jul 22 08:22:33 rti10 amd[3397]: /dev/hda1 restarted fstype link on /boot
Jul 22 08:22:33 rti10 amd[3397]: none restarted fstype link on /dev/pts
Jul 22 08:22:33 rti10 amd[3397]: none restarted fstype link on /dev/shm
Jul 22 08:22:33 rti10 amd[3397]: automount(pid3315) restarted fstype link on
/home
Jul 22 08:22:33 rti10 amd: amd startup succeeded
Jul 22 08:22:33 rti10 amd[3397]: initializing amd.conf map /etc/amd.net of
type file
Jul 22 08:22:33 rti10 oeeclslinuxrti: Starting Linux Collage RTI drivers:
Jul 22 08:22:33 rti10 amd[3397]: first time load of map /etc/amd.net
succeeded
Jul 22 08:22:33 rti10 amd[3397]: /etc/amd.net mounted fstype toplvl on /net
Jul 22 08:22:33 rti10 oeeclslinuxrti: Installing Parallel Port Driver
Jul 22 08:22:33 rti10 oeeclslinuxrti: insmod: pp: no module by that name
found
Jul 22 08:22:34 rti10 oeeclslinuxrti: Using
/lib/modules/2.4.20-8/kernel/drivers/ieee1394/ieee1394.o
Jul 22 08:22:34 rti10 oeeclslinuxrti: insmod: a module named ieee1394
already exists
Jul 22 08:22:34 rti10 kernel: raw1394: /dev/raw1394 device initialized
Jul 22 08:22:34 rti10 oeeclslinuxrti: Using
/lib/modules/2.4.20-8/kernel/drivers/ieee1394/raw1394.o
Jul 22 08:22:34 rti10 oeeclslinuxrti: mknod: `/dev/pp0': File exists
Jul 22 08:22:34 rti10 rc: Starting oeeclslinuxrti:  succeeded
Jul 22 08:22:34 rti10 sendmail: sendmail startup succeeded
Jul 22 08:22:34 rti10 sendmail: sm-client startup succeeded
Jul 22 08:22:35 rti10 gpm: gpm startup succeeded
Jul 22 08:22:37 rti10 httpd: httpd startup succeeded
Jul 22 08:22:38 rti10 canna:  succeeded
Jul 22 08:22:38 rti10 crond: crond startup succeeded
Jul 22 08:22:40 rti10 kernel: lp0: using parport0 (polling).
Jul 22 08:22:40 rti10 kernel: lp0: console ready
Jul 22 08:22:40 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 08:22:40 rti10 last message repeated 15 times
Jul 22 08:22:40 rti10 cups: cupsd startup succeeded
Jul 22 08:22:41 rti10 xfs: xfs startup succeeded
Jul 22 08:22:41 rti10 anacron: anacron startup succeeded
Jul 22 08:22:41 rti10 atd: atd startup succeeded
Jul 22 08:22:42 rti10 xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Jul 22 08:22:42 rti10 rc: Starting firstboot:  succeeded
Jul 22 08:22:42 rti10 automount[3315]: attempting to mount entry /home/cls
Jul 22 08:22:42 rti10 rc: Starting mdc_misc:  succeeded
Jul 22 08:22:42 rti10 login(pam_unix)[3649]: session opened for user cls by
LOGIN(uid=0)
Jul 22 08:22:42 rti10 automount[3315]: attempting to mount entry
/home/clshome
Jul 22 08:22:42 rti10  -- cls[3649]: LOGIN ON tty1 BY cls
Jul 22 08:22:49 rti10 gconfd (cls-3723): starting (version 2.2.0), pid 3723
user 'cls'
Jul 22 08:22:49 rti10 gconfd (cls-3723): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source
at position 0
Jul 22 08:22:49 rti10 gconfd (cls-3723): Resolved address
"xml:readwrite:/home/clshome/.gconf" to a writable config source at position
1
Jul 22 08:22:49 rti10 gconfd (cls-3723): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at
position 2
Jul 22 08:22:55 rti10 kernel: ide-floppy driver 0.99.newide
Jul 22 08:22:55 rti10 kernel: hdc: ATAPI 54X CD-ROM drive, 128kB Cache,
UDMA(33)
Jul 22 08:22:55 rti10 kernel: Uniform CD-ROM driver Revision: 3.12
Jul 22 08:22:57 rti10 kernel: cdrom: This disc doesn't have any tracks I
recognize!
Jul 22 08:23:59 rti10 automount[3816]: expired /home/cls
Jul 22 08:24:01 rti10 su(pam_unix)[3815]: session opened for user root by
cls(uid=301)


Thanks,
Kathy

