Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273726AbRIQWeQ>; Mon, 17 Sep 2001 18:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273722AbRIQWdY>; Mon, 17 Sep 2001 18:33:24 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:56583 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S273735AbRIQWc7>;
	Mon, 17 Sep 2001 18:32:59 -0400
Date: Mon, 17 Sep 2001 23:33:17 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Subject: IRQ detection and VIA chipset..
Message-ID: <Pine.LNX.4.32.0109172329160.18122-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


okay I've looked on the list archives and can see reports but not much in
the way of happy finishes..

attached are my dmesg and lspci -v.. it is a 2.4.9-ac10 just my own
initials to distinguish different modules and stuff... it does something
similiar with 2.4.3-20mdk gives

PCI: Found IRQ 5 for device 00:0a.0
IRQ routing conflict in pirq table for device 00:0a.0

I've tried both PNP Bios on and off and also ACPI on and off (just in
case).. so should I do the DEBUG define stuff in pci-irq.c or has this
been resolved and I'm doing something wrong..

Regards,
	Dave.
p.s. can't get me VAX to boot until I get second netcard working :-)

Linux version 2.4.9-ac10-da2 (root@asimov) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release / Linux-Mandrake 8.0)) #1 Sun Sep 16 22:37:19 IST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: BOOT_IMAGE=linux ro root=308
Initializing CPU#0
Detected 400.922 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 62732k/65536k available (722k kernel code, 2416k reserved, 179k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 09
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41597kB/13865kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x6400-0x6407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x6408-0x640f, BIOS settings: hdc:pio, hdd:DMA
hda: IBM-DTTA-351680, ATA DISK drive
hdd: CRD-8400B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=2055/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 > hda4
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 72256k swap-space (priority -1)
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16C PnP'
isapnp: 1 Plug & Play card detected total
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=0x3f0 key=0x87 devid=fc devrev=21 oldid=8c
Winbond chip type 83877TF
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 5 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 11, want irq 5
eth0: RealTek RTL-8029 found at 0x6c00, IRQ 11, 00:C0:DF:EE:29:59.
PCI: Found IRQ 10 for device 00:0b.0
eth1: RealTek RTL-8029 found at 0x7000, IRQ 10, 00:C0:DF:EE:0D:B8.
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative ViBRA16C PnP detected
sb: ISAPnP reports 'Creative ViBRA16C PnP' at i/o 0x220, irq 7, dma 1, 5
SB 4.13 detected OK (220)
sb: 1 Soundblaster PnP card(s) found.
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0x6800, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: :USB Universal Host Controller Interface driver
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 5 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 11, want irq 5
eth0: RealTek RTL-8029 found at 0x6c00, IRQ 11, 00:C0:DF:EE:29:59.
PCI: Found IRQ 10 for device 00:0b.0
eth1: RealTek RTL-8029 found at 0x7000, IRQ 10, 00:C0:DF:EE:0D:B8.


lspci -v:


00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Flags: bus master, medium devsel, latency 16
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e4000000-e7ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 6400 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 6800 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Flags: medium devsel

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Flags: medium devsel, IRQ 11
	I/O ports at 6c00 [size=32]

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Flags: medium devsel, IRQ 10
	I/O ports at 7000 [size=32]

01:00.0 VGA compatible controller: 3DLabs Permedia II 2D+3D (rev 01) (prog-if 00 [VGA])
	Subsystem: Unknown device 484c:4133
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
	Memory at e6000000 (32-bit, non-prefetchable) [size=128K]
	Memory at e5800000 (32-bit, non-prefetchable) [size=8M]
	Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>



-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


