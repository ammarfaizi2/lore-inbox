Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSKUS6R>; Thu, 21 Nov 2002 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbSKUS6R>; Thu, 21 Nov 2002 13:58:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22733 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S266307AbSKUS6K>;
	Thu, 21 Nov 2002 13:58:10 -0500
Date: Thu, 21 Nov 2002 20:07:21 +0100
From: Kristof Sardemann <ksardem@linux01.gwdg.de>
X-Mailer: The Bat! (v1.60q) Personal
Reply-To: Kristof Sardemann <ksardem@linux01.gwdg.de>
Organization: KKI
X-Priority: 3 (Normal)
Message-ID: <511801825.20021121200721@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
CC: manfred@colorfullife.com
Subject: Re: bug in via-rhine network-driver (transmit timed out) debug-report
In-Reply-To: <3DD76371.4060009@colorfullife.com>
References: <3DD76371.4060009@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>The hang could be caused by incomplete tx underrun handling, the
>linuxfet driver resets several registers after a tx underrun.
>Could you load the driver with debug=3? For example by adding 'options
>via-rhine debug=3' into your /etc/modules.conf?

As you said I loaded the driver with options via-rhine debug=3
but in debug-mode there was no error any longer!
I know this is a bit strange but if I get the error-message
again I'll post it...

Here are some system-informations: (with debug=3, no errors)

lsmod:
via-rhine 13612 2
mii        1232 0 [via-rhine]

complete dmesg:
Linux version 2.4.19-my (root@geeko) (gcc version 3.2) #2 Thu Nov 7 11:01:44 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
 BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scanning bios EBDA for MXT signature
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
Advanced speculative caching feature not present
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f70f0
ACPI: RSDT (v001 COMPAQ AWRDACPI 16944.11825) @ 0x17ff3000
ACPI: FADT (v001 COMPAQ AWRDACPI 16944.11825) @ 0x17ff3040
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda5   vga=788 init 3
Initializing CPU#0
Detected 349.976 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 697.95 BogoMIPS
Memory: 385080k/393152k available (1770k kernel code, 7684k reserved, 438k data, 164k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20020829
PCI: PCI BIOS revision 2.10 entry at 0xfb1f0, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: overridden by ACPI.
mxt_scan_bios: enter
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
kinoded started
VFS: Diskquotas version dquot_6.5.0 initialized
aio_setup: num_physpages = 24572
aio_setup: sizeof(struct page) = 48
vesafb: framebuffer at 0xdc000000, mapped to 0xd8815000, size 8192k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at c000:4785
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Looking for splash picture.... found (800x600, 19991 bytes).
Console: switching to colour frame buffer device 82x26
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 32049H2, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03baea4, I/O limit 4095Mb (mask 0xffffffff)
hda: safely enabled flush
hda: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 16 devices)
[drm] Initialized gamma 1.0.0 20010216 on minor 0
[drm] Initialized tdfx 1.0.0 20010216 on minor 1
[drm] Initialized r128 2.2.0 20010917 on minor 2
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 131k freed
VFS: Mounted root (ext2 filesystem).
EXT2-fs warning (device ide0(3,5)): ext2_read_super: mounting ext3 filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 164k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5(mp-v6)(15/07/2002) module loaded
Adding Swap: 257000k swap-space (priority 42)
via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 9 for device 00:09.0
via-rhine: reset finished after 5 microseconds.
eth0: VIA VT6102 Rhine-II at 0xe400, 00:05:5d:e5:3d:17, IRQ 9.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
PCI: Found IRQ 9 for device 00:0a.0
via-rhine: reset finished after 5 microseconds.
eth1: VIA VT6102 Rhine-II at 0xe800, 00:05:5d:e5:2d:f1, IRQ 9.
eth1: MII PHY found at address 8, status 0x782d advertising 01e1 Link 41e1.
eth0: via_rhine_open() irq 9.
eth0: reset finished after 5 microseconds.
eth0: Setting full-duplex based on MII #8 link partner capability of 45e1.
eth0: Done via_rhine_open(), status 0c1a MII status: 782d.
eth1: via_rhine_open() irq 9.
eth1: reset finished after 5 microseconds.
eth1: Setting full-duplex based on MII #8 link partner capability of 41e1.
eth1: Done via_rhine_open(), status 0c1a MII status: 782d.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16X PnP'
isapnp: 1 Plug & Play card detected total
ip_tables: (C) 2000-2002 Netfilter core team
usb-uhci.c: $Revision: 1.275 $ time 09:23:14 Nov  7 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
hdc: bad special flag: 0x03
ide-floppy driver 0.99.newide
hdc: no flushcache support
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
cdrom: open failed.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
eth0: no IPv6 routers present


Hope that helps. ;)

--
Bye.
Kristof <ksardem@linux01.gwdg.de>

