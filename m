Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270649AbRHNSpd>; Tue, 14 Aug 2001 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270632AbRHNSpP>; Tue, 14 Aug 2001 14:45:15 -0400
Received: from [199.29.68.123] ([199.29.68.123]:38405 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S270676AbRHNSo4>;
	Tue, 14 Aug 2001 14:44:56 -0400
X-WM-Posted-At: MailAndNews.com; Tue, 14 Aug 01 14:42:07 -0400
Message-ID: <001901c124f0$9026d6e0$c405a33e@brekoo.noip.com>
From: "Marc Brekoo" <m_brekoo@mailandnews.com>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI & Promise Ultra 100 controller ???
Date: Tue, 14 Aug 2001 20:37:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm having the following problem on my new Athlon-box. Whenever I compile a
kernel with ACPI-support and boot it, the system just dies when probing the
drives
connected to the Promise PCI-card. Note that it just dies, no oopses, no
messages; the only thing that responds is the reset-button :(

I've tested the same ACPI-enabled kernel without the IDE-controller, and it
works just beautifully. I've incuded the dmesg-output from this test-run.

Kernel versions 2.4.7 and 2.4.8-ac2 show the same behaviour. What could be
causing this?

Thanks in advance,
Marc Brekoo.


dmesg-output:

Linux version 2.4.8 (root@athene.brekoo.no-ip.com) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-85)) #3 Tue Aug 14 16:28:02 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01442000)
Kernel command line: auto BOOT_IMAGE=linux ro root=341
BOOT_FILE=/boot/new/vmlinuz
Initializing CPU#0
Detected 1328.052 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2647.65 BogoMIPS
Memory: 255424k/262080k available (1062k kernel code, 6268k reserved, 416k
data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb160, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
ACPI: Core Subsystem version [20010615]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2, throttling states: 2
Power Button: found
Power Button: found
Sleep Button: found
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(18)
parport0: assign_addrs: aa5500ff(18)
parport0: cpp_daisy: aa5500ff(18)
parport0: assign_addrs: aa5500ff(18)
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 34098H4 M, ATA DISK drive
hdb: Maxtor 82160D2, ATA DISK drive
hdc: QUANTUM Bigfoot TX6.0AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80023104 sectors (40972 MB) w/2048KiB Cache, CHS=4981/255/63, UDMA(100)
hdb: 4123980 sectors (2111 MB) w/256KiB Cache, CHS=1022/64/63, UDMA(33)
hdc: 11773755 sectors (6028 MB) w/69KiB Cache, CHS=12459/15/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
 hdb: hdb1
 hdc: hdc1                               // <==== With the card, system dies
here
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.18
PCI: Found IRQ 11 for device 00:09.0
IRQ routing conflict for 00:07.5, have irq 9, want irq 11
eth0: RealTek RTL8139 Fast Ethernet at 0xd0806000, 00:50:bf:32:50:b0, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 1076344k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 16:13:52 Aug 14 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:07.2
IRQ routing conflict for 00:07.2, have irq 10, want irq 9
IRQ routing conflict for 00:07.3, have irq 10, want irq 9
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:07.3
IRQ routing conflict for 00:07.2, have irq 10, want irq 9
IRQ routing conflict for 00:07.3, have irq 10, want irq 9
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.6, 11 Aug 2001 on ide1(22,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

