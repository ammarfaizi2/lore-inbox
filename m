Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbRFBWAQ>; Sat, 2 Jun 2001 18:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRFBWAG>; Sat, 2 Jun 2001 18:00:06 -0400
Received: from green.nl.gxn.net ([62.100.30.36]:3219 "EHLO green.nl.gxn.net")
	by vger.kernel.org with ESMTP id <S261741AbRFBWAA>;
	Sat, 2 Jun 2001 18:00:00 -0400
Message-Id: <m156JR5-000lhIC@green.nl.gxn.net>
Content-Type: text/plain; charset=US-ASCII
From: Koos Vriezen <j.jvriezen@freeler.nl>
Reply-To: j.jvriezen@freeler.nl
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.5.ac6: more Via irq fixes
Date: Sun, 3 Jun 2001 00:00:52 +0200
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In case you didn't know, the patch doesn't solve interrup conflicts on 
VIA Apollo MVP3 chipsets. Box runs fine though.

Regards,

Koos Vriezen

Some outputs:

$ cat /proc/interrupts
           CPU0
  0:     482219          XT-PIC  timer
  1:       2771          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       3158          XT-PIC  soundblaster
  9:         53          XT-PIC  bttv
 10:       2276          XT-PIC  eth0
 12:      48097          XT-PIC  PS/2 Mouse
 14:      18781          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0

$ dmesg

Linux version 2.4.5-ac6 (root@xwing) (gcc version 2.95.3 20010315 (release)) 
#4 Sat Jun 2 22:31:38 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=301
Initializing CPU#0
Detected 298.822 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 596.37 BogoMIPS
Memory: 191448k/196608k available (844k kernel code, 4772k reserved, 200k 
data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008001bf 808009bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 808009bf 00000000 00000000
CPU:     After generic, caps: 008001bf 808009bf 00000000 00000000
CPU:             Common caps: 008001bf 808009bf 00000000 00000000
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb290, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
PnP: PNP BIOS installation structure at 0xc00fbe40
PnP: PNP BIOS version 1.0, entry at f0000:be68, dseg at f0000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 127061kB/42353kB, 384 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL EX6.4A, ATA DISK drive
hdc: CD-ROM 36X/AKU, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=784/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k freed
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lirc_serial: auto-detected active low receiver
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Assigned IRQ 10 for device 00:08.0
eth0: RealTek RTL-8029 found at 0xe800, IRQ 10, 00:40:05:6B:CF:E0.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.57 loaded
bttv: using 2 buffers with 1040k (2080k total) for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 10 for device 00:0a.0
IRQ routing conflict in pirq table for device 00:0a.0
IRQ routing conflict in pirq table for device 00:0a.1
bttv0: Bt878 (rev 2) at 00:0a.0, irq: 9, latency: 32, memory: 0xe7000000
bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
bttv0: model: BT878(Hauppauge new (bt878)) [insmod option]
bttv0: Hauppauge msp34xx: reset line init
i2c-algo-bit.o: Adapter: bt848 #0 scl: 1  sda: 1 -- testing...
i2c-algo-bit.o:1 scl: 1  sda: 0 
i2c-algo-bit.o:2 scl: 1  sda: 1 
i2c-algo-bit.o:3 scl: 0  sda: 1 
i2c-algo-bit.o:4 scl: 1  sda: 1 
i2c-algo-bit.o: bt848 #0 passed test.
bttv0: Hauppauge eeprom: model=61334, tuner=Philips FM1216 (5), radio=yes
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3410D-B4, has NICAM support
msp3410: daemon started
bttv0: i2c attach [MSP3410D-B4]
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
tuner: chip found @ 0x61
bttv0: i2c attach [Philips PAL]
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 PnP detected
sb: ISAPnP reports 'Creative SB AWE64 PnP' at i/o 0x220, irq 5, dma 1, 5
SB 4.16 detected OK (220)
sb: 1 Soundblaster PnP card(s) found.
bttv0: PLL: 28636363 => 35468950 ... ok

$ /sbin/lspci -vv 

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo 
VP] (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at e000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at e400 [size=32]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=32]

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e7001000 (32-bit, prefetchable) [size=4K]

01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) 
Riva128 (rev 10) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V330
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at e5000000 [disabled] [size=4M]
	Capabilities: <available only to root>

