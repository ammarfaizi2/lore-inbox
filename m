Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSAQDYc>; Wed, 16 Jan 2002 22:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288141AbSAQDYX>; Wed, 16 Jan 2002 22:24:23 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:37383 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288149AbSAQDYE>; Wed, 16 Jan 2002 22:24:04 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Jan 2002 19:30:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: bread() seems reading bogus data ...
Message-ID: <Pine.LNX.4.40.0201161920530.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

it seems that __bread() read wrong data on my disk resulting in a ext2
magic of 0x8001 ?!?, reading from /dev/hda5 03:05
Below is reported a dmesg from my machine when booted with 2.5.2
Are you able to guess something or do i need to drill more ?




- Davide





Linux version 2.5.2-mqo1 (root@blue1.dev.mcafeelabs.com) (gcc version 3.0.3) #12 Wed Jan 16 09:49:54 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.5.2-mqo1 ro root=305 BOOT_FILE=/boot/vmlinuz-2.5.2-mqo1
Initializing CPU#0
Detected 999.554 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 255896k/262144k available (1229k kernel code, 5860k reserved, 341k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb350, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.32
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI slot 00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD205BA, ATA DISK drive
hdb: CD-ROM 50X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=2495/255/63
hdb: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:14.0
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:02:B3:11:E5:92, IRQ 11.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 32M @ 0xd4000000
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
PCI: Sharing IRQ 11 with 00:14.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:07.3
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:14.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 530104k swap-space (priority -1)
NFS: NFSv3 not supported.
nfs warning: mount version older than kernel


