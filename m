Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADVSf>; Thu, 4 Jan 2001 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADVS0>; Thu, 4 Jan 2001 16:18:26 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:11269 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S135180AbRADVSL>; Thu, 4 Jan 2001 16:18:11 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prelease freezes on serial event
In-Reply-To: <19244.978564515@kao2.melbourne.sgi.com>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 04 Jan 2001 19:04:39 +0000
In-Reply-To: <19244.978564515@kao2.melbourne.sgi.com>
Message-ID: <m2pui35ebc.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> Boot the kdb enhanced kernel and cat /proc/interrupts to see if NMI is
> non-zero.

NMI is zero, so that did not help.

However, I think I have solved the problem. During boot, I saw a
message about ACPI failing to initialise so I removed ACPI from the
configuration and rebuilt. Now the system again survives both power
cycling the modem and incoming voice calls.

Here is the output of dmesg which shows the boot (for the current
working configuration, not the one which failed).
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007efc000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 0000000007ffc000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 0000000007fff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32764
zone(0): 4096 pages.
zone(1): 28668 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (fee00000)
Kernel command line: BOOT_IMAGE=Linux ro root=301
Initializing CPU#0
Detected 605.678 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1209.13 BogoMIPS
Memory: 126620k/131056k available (1375k kernel code, 4048k reserved, 87k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Local APIC disabled by BIOS -- reenabling...
leaving PIC mode, enabling symmetric IO mode.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
calibrating APIC timer ...
..... CPU clock speed is 605.6275 MHz.
..... host bus clock speed is 100.9377 MHz.
cpu: 0, clocks: 1009377, slice: 504688
CPU0<T0:1009376,T1:504688,D:0,S:504688,C:1009377>
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf06d0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.3 present.
46 structures occupying 1330 bytes.
DMI table at 0x000F1D80.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS CUC2000 ACPI BIOS Revision 1011
BIOS Release: 01/21/2000
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: CUC2000.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST315323A, ATA DISK drive
hdb: ST33221A, ATA DISK drive
hdc: OnStream DI-30, ATAPI TAPE drive
hdd: FX240S, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 30008475 sectors (15364 MB) w/512KiB Cache, CHS=1867/255/63, UDMA(66)
hdb: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=6253/16/63, UDMA(33)
hdd: ATAPI 24X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-tape: hdc <-> ht0: OnStream DI-30 rev 1.05
ide-tape: hdc <-> ht0: 990KBps, 64*32kB buffer, 10208kB pipeline, 60ms tDSC, DMA
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb:hdb: set_multmode: status=0x51 { DriveReady SeekComplete Error }
hdb: set_multmode: error=0x04 { DriveStatusError }
 hdb1 hdb2 < hdb5 hdb6 hdb7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
i810_rng hardware driver 0.9.2 loaded
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 270104k swap-space (priority 1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:1f.2
PCI: The same IRQ used for device 02:0b.0
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xa400, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: root-hub INT complete: port1: 93 port2: 93 data: 6
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x5a9/0xa511) is not claimed by any active driver.
hub.c: USB new device connect on bus1/2, assigned device number 3
hub.c: USB hub found
hub.c: 4 ports detected
Linux video capture interface: v1.00
usb.c: registered new driver ov511
ov511.c: USB OV511+ camera found
ov511.c: camera: Creative Labs WebCam 3
ov511.c: Sensor is an OV7620
ov511.c: ov511 driver version 1.28 registered
i810_rng: RNG h/w enabled
i2c-core.o: i2c core module
i801.o version 2.5.4 (20001012)
i2c-core.o: adapter SMBus I801 adapter at e800 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
LDT allocated for cloned task!
ip_tables: (c)2000 Netfilter core team
ip_conntrack (1023 buckets, 8184 max)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP BSD Compression module registered
PPP Deflate Compression module registered
usb.c: deregistering driver ov511
ov511.c: driver deregistered

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
