Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131943AbRA3BjY>; Mon, 29 Jan 2001 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132020AbRA3BjO>; Mon, 29 Jan 2001 20:39:14 -0500
Received: from mail11.svr.pol.co.uk ([195.92.193.23]:14676 "EHLO
	mail11.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131943AbRA3BjE>; Mon, 29 Jan 2001 20:39:04 -0500
Date: Tue, 30 Jan 2001 01:38:53 +0000
From: Adam Huffman <bloch@verdurin.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12: SiS pirq handling..
Message-ID: <20010130013853.A2616@bloch.verdurin.priv>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 29, 2001 at 13:51:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The other changes in pre12 aren't likely to be all that noticeable, unless
> you happen to be hit by just that detail.. As always, fedback is
> appreciated.
> 
> 		Linus
> 
> 
> ----
> pre12:
>  - Get non-cpuid Cyrix probing right (it's not a NexGen)
>  - Jens Axboe: cdrom tray status and queing cleanups
>  - AGP GART: don't disable VIA, and allow i815 with external AGP
>  - Coda: use iget4() in order to have big inode numbers without clashes.
>  - Fix UDF writepage() page locking
>  - NIIBE Yutaka: SuperH update
>  - Martin Diehl and others: SiS pirq routing fixes
>  - Andy Grover: ACPI update
>  - Andrea Arkangeli: LVM update
>  - Ingo Molnar: RAID cleanups
>  - David Miller: sparc and networking updates
>  - Make NFS really be able to handle large files
> 

Despite the latest ACPI update, I still get the ACPI slowdown on
initialisation which started with the -pre10 changes.  Also, the uhci
module doesn't work for me (the latest patch from Johannes Erdfelt does
work).  This is an Abit KA7-100, which has the KX133 chipset.  Here is
the dmesg output for this kernel (I had to turn off ACPI in the BIOS in
order to have a usable system):


Linux version 2.4.1-pre12 (adam@bloch.verdurin.priv) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #3 Mon Jan 29 22:24:04 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000ff00000 @ 0000000000100000 (usable)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hde6 vga=1 mem=262144K
Initializing CPU#0
Detected 800.059 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 255488k/262144k available (1096k kernel code, 6268k reserved, 369k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c3f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c3f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c3f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c3f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
42 structures occupying 1165 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 07/20/2000
System Vendor: VIA Technologies, Inc..
Product Name: VT8371.
Version  .
Serial Number  .
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169765kB/56588kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 92049U6, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307030, ATA DISK drive
hdg: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe000-0xe007,0xe402 on irq 11
hda: 40026672 sectors (20494 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(66)
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdg: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1
 hde: [PTBL] [3737/255/63] hde1 hde2 < hde5 hde6 hde7 hde8 hde9 >
 hdg: [PTBL] [3737/255/63] hdg1 hdg2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Registered PPPoX v0.5
Registered PPPoE v0.6.5
8139too Fast Ethernet driver 0.9.13 loaded
PCI: Found IRQ 10 for device 00:0d.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0800000, 00:c0:df:02:8b:11, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: System description tables not found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 248968k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 5 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
PCI: The same IRQ used for device 00:08.0
uhci.c: USB UHCI at I/O 0xc400, IRQ 5
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
uhci: host controller process error. something bad happened
uhci: host controller halted. very bad
usb.c: kmalloc IF c157ccc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: c400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c157ccc0
usb.c: kusbd: /sbin/hotplug add 1
PCI: Found IRQ 5 for device 00:07.3
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:08.0
uhci.c: USB UHCI at I/O 0xc800, IRQ 5
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
uhci: host controller halted. very bad
uhci: host controller process error. something bad happened
uhci: host controller halted. very bad
usb.c: kmalloc IF c157cf40, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 2 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: c800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c157cf40
usb.c: kusbd: /sbin/hotplug add 2
mice: PS/2 mouse device common for all mice
uhci.c: root-hub INT complete: port1: 5ab port2: 58a data: 6
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 3
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 4
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 5a5 port2: 58a data: 4
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
uhci.c: root-hub INT complete: port1: 5a1 port2: 588 data: 4
hub.c: port 2 enable change, status 300
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
eth0: Setting full-duplex based on MII #32 link partner ability of 45e1.
VFS: Disk change detected on device ide1(22,0)
usb.c: registered new driver hid
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
