Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRDMUHY>; Fri, 13 Apr 2001 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDMUHF>; Fri, 13 Apr 2001 16:07:05 -0400
Received: from ns0.petreley.net ([64.170.109.178]:20358 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S131638AbRDMUHB>;
	Fri, 13 Apr 2001 16:07:01 -0400
Date: Fri, 13 Apr 2001 13:06:48 -0700
From: Nicholas Petreley <nicholas@petreley.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: usb-uhci.c problems in latest kernels?
Message-ID: <20010413130647.A965@petreley.com>
Mail-Followup-To: Nicholas Petreley <nicholas@petreley.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel 2.4.3 and 2.4.3-ac5, mobo is ASUS A7V with
BIOS 1007.  I use usb-uhci. 

I've been getting a ton of these messages (below) lately
when I move my MS optical mouse.  Sometimes it settles down
and stops for a long while, but I can make the messages
start up again simply by lifting the mouse for a moment and
then set it down (lifting it up turns off/down the LED for
a moment and then turns it back on/up when you set down the
mouse - I'm guessing this probably initiates some sort of
reset, but I have no idea how these mice work).  It doesn't
help to change to another MS optical mouse - the same
errors occur.  These messages only started up since
switching to 2.4.3 from the 2.4.2 series. 

The other uchi driver has worse problems.  When I switch to
another computer using my MiniView KVM switch, the uchi
driver stops responding completely and the whole system
freezes when I come back, requiring a reboot.  In case
you're wondering, I get the interrupt messages even when I
remove the KVM switch and hook up the keyboard and mouse
directly to the computer, so it's not the hub that's
causing the problem.

Here is a sample of the messages:

usb-uhci.c: interrupt, status 3, frame# 1876
usb-uhci.c: interrupt, status 3, frame# 1084
usb-uhci.c: interrupt, status 3, frame# 1116
usb-uhci.c: interrupt, status 3, frame# 1532
usb-uhci.c: interrupt, status 3, frame# 796
usb-uhci.c: interrupt, status 3, frame# 1068
usb-uhci.c: interrupt, status 3, frame# 1836
usb-uhci.c: interrupt, status 3, frame# 1964
usb-uhci.c: interrupt, status 3, frame# 1476
usb-uhci.c: interrupt, status 3, frame# 1500
usb-uhci.c: interrupt, status 3, frame# 1524
usb-uhci.c: interrupt, status 3, frame# 1548
usb-uhci.c: interrupt, status 3, frame# 1572
usb-uhci.c: interrupt, status 3, frame# 2036
usb-uhci.c: interrupt, status 3, frame# 12
usb-uhci.c: interrupt, status 3, frame# 588
usb-uhci.c: interrupt, status 3, frame# 612

Here's /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 7.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 7.
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd01f].
  Bus  0, device   4, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
      IRQ 9.
  Bus  0, device  10, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xd5800000 [0xd5800fff].
      I/O at 0xa400 [0xa43f].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd50fffff].
  Bus  0, device  12, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 3).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xa000 [0xa01f].
  Bus  0, device  12, function  1:
    Input device controller: Creative Labs SB Live! (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0x9800 [0x9807].
  Bus  0, device  13, function  0:
    SCSI storage controller: Adaptec AIC-7881U (rev 0).
      IRQ 7.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0x9400 [0x94ff].
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd4800fff].
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0x9000 [0x9007].
      I/O at 0x8800 [0x8803].
      I/O at 0x8400 [0x8407].
      I/O at 0x8000 [0x8003].
      I/O at 0x7800 [0x783f].
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd401ffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 (rev 161).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].


here's dmesg

Linux version 2.4.3 (root@beaver) (gcc version 2.95.3 20010315 (Debian release)) #5 Mon Apr 2 11:18:08 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=2106 acpi=off apm=on
Initializing CPU#0
Detected 1008.998 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 2011.95 BogoMIPS
Memory: 255272k/262064k available (1201k kernel code, 6400k reserved, 419k data, 176k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Probing PCI hardware
PCI: Bus master Pipeline request disabled
PCI: Disabled enhanced CPU to PCI writes
PCI: Bursting cornercase bug worked around
PCI: Post Write Fail set to Retry
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 11 for device 00:0c.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169616kB/56538kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 92049U6, ATA DISK drive
hdb: WDC AC313000R, ATA DISK drive
hdc: DVD-ROM BDV212B, ATAPI CD/DVD-ROM drive
hde: Maxtor 54098H8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x8802 on irq 10
hda: 40026672 sectors (20494 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(66)
hdb: 25429824 sectors (13020 MB) w/512KiB Cache, CHS=1582/255/63, (U)DMA
hde: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63, UDMA(100)
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 >
 hde: [PTBL] [4982/255/63] hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xe4000000
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
mice: PS/2 mouse device common for all mice
ACPI: Disabled
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 21:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding Swap: 530104k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 3 for device 00:0a.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:02:B3:0B:CA:AB, IRQ 3.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Creative EMU10K1 PCI Audio Driver, version 0.7, 12:29:12 Apr  2 2001
PCI: Enabling device 00:0c.0 (0004 -> 0005)
PCI: Found IRQ 11 for device 00:0c.0
emu10k1: EMU10K1 rev 3 model 0x21 found, IO at 0xa000-0xa01f, IRQ 11
usb-uhci.c: $Revision: 1.251 $ time 12:29:16 Apr  2 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 7 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 7
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 7 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 7
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usb_mouse
usb.c: registered new driver keyboard
hub.c: USB new device connect on bus2/2, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: USB new device connect on bus2/2/1, assigned device number 3
SCSI subsystem driver Revision: 1.00
usb.c: USB device 3 (vend/prod 0x781/0x2) is not claimed by any active driver.
hub.c: USB new device connect on bus1/2/2, assigned device number 3
usb-uhci.c: interrupt, status 3, frame# 1248
mouse0: PS/2 mouse device for input0
input0: Microsoft Microsoft IntelliMouse® Explorer on usb1:3.0
hub.c: USB new device connect on bus1/2/3, assigned device number 4
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: USB new device connect on bus1/2/3/1, assigned device number 5
keybdev.c: Adding keyboard: input1
input1:  Microsoft Natural Keyboard Pro on on usb1:5.0
reiserfs: checking transaction log (device 21:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25

The device not claimed by any active driver is a SanDisk CF
reader.  The problem continues to occur even if I remove
it.

Any ideas?  Suggestions?  Predictions on who will win the
world series this year?  

-Nick


-- 
**********************************************************
Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
nicholas@petreley.com - http://www.petreley.com - Eph 6:12
**********************************************************
.
