Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272212AbRILWrv>; Wed, 12 Sep 2001 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272245AbRILWrb>; Wed, 12 Sep 2001 18:47:31 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:11781 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272212AbRILWr2>; Wed, 12 Sep 2001 18:47:28 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109122343.QAA20586@boojiboy.eorbit.net>
Subject: 2.4.9-ac9 APM w/Compaq 16xx laptop...
To: bmacy@macykids.net, J.A.K.Mouw@ITS.TUDelft.NL
Date: Wed, 12 Sep 2001 16:43:05 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was discussed awhile back, maybe there are answer.  

Compaq Presario 1685.
My bios supports ACPI

the roboot option  "shutdown -r" does
not work with this laptop when I compile
either APM or ACPI.  The behavior is a little
different with each one.

When my bios is set ACPI=NO, and APM is compiled in:
A 'shutdown -r' hangs after the "Restarting System" message.  
Depressing the power switch cause a power off.

When my bios is set ACPI=YES, and ACPI is compiled in:
A 'shutdown -r' hangs after the "Restarting system" message.  
Depressing the power switch causes a reboot.

I have a feeling this is ReiserFS related. 

dmesg shows:

Linux version 2.4.9-ac9 (root@oso) (gcc version 2.95.3 20010315 (release)) #1 Wed Sep 12 14:08:46 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ecc00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
 BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=linux ro root=302
Initializing CPU#0
Detected 381.177 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 760.21 BogoMIPS
Memory: 190560k/196544k available (1411k kernel code, 5596k reserved, 402k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfd8be, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 10 for device 00:0a.0
PCI: Sharing IRQ 10 with 00:0f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Compaq 12XL125 machine detected. Enabling interrupts during APM calls.
Starting kswapd v1.8
ACPI: Core Subsystem version [20010615]
ACPI: Subsystem enabled
EC: found, GPE 6
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1, throttling states: 8
AC Adapter: found
Power Button: found
Sleep Button: found
Lid Switch: found
vesafb: framebuffer at 0xfd000000, mapped to 0xcc808000, size 8128k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at c000:4d09
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: queued sectors max/low 126325kB/42108kB, 384 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0. Please try using pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MHF2043AT, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: TOSHIBA DVD-ROM SD-C2202, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8452080 sectors (4327 MB), CHS=8944/15/63, (U)DMA
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [559/240/63] hda1 hda2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: Detected Ali M1541 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
solo1: version v0.19 time 14:18:05 Sep 12 2001
PCI: Found IRQ 11 for device 00:09.0
solo1: joystick port at 0x10c1
solo1: ddma base address: 0x1060
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 00:0a.0
PCI: Sharing IRQ 10 with 00:0f.0
Intel PCIC probe: not found.
usb.c: registered new driver hub
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000010
PCI: Found IRQ 5 for device 00:14.0
usb-ohci.c: USB OHCI at membase 0xcd011000, IRQ 5
usb-ohci.c: usb-00:14.0, Acer Laboratories Inc. [ALi] M5237 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: checking transaction log (device 03:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 188960k swap-space (priority -1)
PPP Deflate Compression module registered
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 (DL10019 rev 05): io 0x300, irq 3, hw_addr 00:E0:98:09:14:CA
ttyS01 at port 0x02f8 (irq = 3) is a 16550A
eth0: found link beat
eth0: autonegotiation complete: 10baseT-HD selected
