Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbTFRVZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265543AbTFRVZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:25:31 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:43279 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265542AbTFRVZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:25:06 -0400
Message-ID: <3EF0DCE1.1010207@wanadoo.fr>
Date: Wed, 18 Jun 2003 23:42:57 +0200
From: FORT David <david.fort44@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030610
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: amd76x_pm has a strange behaviour in 2.4.21
Content-Type: multipart/mixed;
 boundary="------------020309030108070107080102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020309030108070107080102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

My conf is:
2 x AMD Athlon MP 2400+
1Go Ram
MSI K7D Master Mobo
1 SCSI CDrom
and everything else IDE

My kernel:
2.4.21
skas patch(from UML but not very intrusive)
i2c-2.7.0
lm_sensors 2.7.0
Alsa 0.9.4
with ACPI, SMP and HighMem(4Go)

Everything works fine. But if i modprobe amd76x_pm the onboard sound 
card(inteli810)
stops working. If i play a sound i can hear the first buffer and then 
nothing, that's make
me think that it could be interrupt related.
The Tv cards also doesn't work but it looks like being sound related. 
Nothing is visble
in dmesg. amd76x_pm seems to work because i can see via lm_sensors that  
CPUs are 20°c
cooler.
I tryed with acpi disabled(acpi=off) but it didn't solved the problem.

IIRC the MDK kernel(kernel-enterprise-2.4.21-0.rc1.1mdk-1-1mdk) doesn't 
exibit
this behaviour.

I can perform extra test if needed(kernel are quite fast to compile ;)

-- 
%-------- -- This was sent by Djinn running Linux 2.4.21-skas -- ---------%


--------------020309030108070107080102
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

le (1562k kernel code, 15032k reserved, 509k data, 132k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 2400+ stepping 01
per-CPU timeslice cutoff: 731.38 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) MP stepping 01
Total of 2 processors activated (7982.28 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 003 03  0    0    0   0   0    1    1    71
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    79
 0d 003 03  0    0    0   0   0    1    1    81
 0e 003 03  0    0    0   0   0    1    1    89
 0f 003 03  0    0    0   0   0    1    1    91
 10 003 03  1    1    0   1   0    1    1    99
 11 003 03  1    1    0   1   0    1    1    A1
 12 003 03  1    1    0   1   0    1    1    A9
 13 003 03  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.1020 MHz.
..... host bus clock speed is 266.6806 MHz.
cpu: 0, clocks: 2666806, slice: 888935
CPU0<T0:2666800,T1:1777856,D:9,S:888935,C:2666806>
cpu: 1, clocks: 2666806, slice: 888935
CPU1<T0:2666800,T1:888928,D:2,S:888935,C:2666806>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb130, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1022/700c] at 00:00.0
PCI->APIC IRQ transform: (B0,I7,P1) -> 17
PCI->APIC IRQ transform: (B1,I5,P0) -> 17
PCI->APIC IRQ transform: (B2,I0,P3) -> 19
PCI->APIC IRQ transform: (B2,I4,P0) -> 16
PCI->APIC IRQ transform: (B2,I5,P0) -> 17
PCI->APIC IRQ transform: (B2,I5,P0) -> 17
PCI->APIC IRQ transform: (B2,I6,P0) -> 18
BIOS failed to enable PCI standards compliance, fixing this error.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:.....................................................................................................
101 Control Methods found and parsed (429 nodes total)
ACPI Namespace successfully loaded at root c0364280
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-29] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:........................................
40 Devices found: 40 _STA, 1 _INI
Completing Region and Field initialization:..............................
25/29 Regions, 5/5 Fields initialized (429 nodes total)
ACPI: Subsystem enabled
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xF2000000, mapped to 0xf880f000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD_IDE: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hdb: C/H/S=19158/16/255 from BIOS ignored
hda: IBM-DPTA-372050, ATA DISK drive
hdb: WDC WD400BB-00CCB0, ATA DISK drive
blk: queue c037e560, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c037e6ac, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD400BB-00CAA0, ATA DISK drive
hdd: TRAXDATA CDRW121032plus, ATAPI CD/DVD-ROM drive
blk: queue c037e9d4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(66)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
 /dev/ide/host0/bus0/target1/lun0: p1 p3
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [4865/255/63] p3
matroxfb_crtc2: secondary head of fb0 was registered as fb1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xfa82d000, IRQ 19
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usbdevfs: remount parameter error
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
Adding Swap: 128484k swap-space (priority -1)
hub.c: new USB device 02:00.0-4, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 02:00.0-4.1, assigned address 3
usb.c: USB device 3 (vend/prod 0x46d/0x840) is not claimed by any active driver.
hub.c: new USB device 02:00.0-4.3, assigned address 4
usb.c: USB device 4 (vend/prod 0x5a9/0x511) is not claimed by any active driver.
SCSI subsystem driver Revision: 1.00
ahc_pci:2:6:0: Host Adapter Bios disabled.  Using default SCSI device parameters
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue f7aab618, I/O limit 4095Mb (mask 0xffffffff)
Linux video capture interface: v1.00
usb.c: registered new driver ov511
ov511.c: USB OV511 video device found
ov511.c: model: Lifeview RoboCam
ov511.c: Sensor is an OV7610
ov511.c: Device at usb-02:00.0-4.3 registered to minor 0
ov511.c: v1.63 for Linux 2.4 : ov511 USB Camera Driver
  Vendor: PIONEER   Model: CD-ROM DR-U12X    Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7690218, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
bttv: driver version 0.7.104 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 02:05.0, irq: 17, latency: 32, mmio: 0xf9000000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: BT878(Pinnacle PCTV Studio/Ra) [card=39,autodetected]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=9 tuner=3 radio=no stereo=no
bttv0: using tuner=3
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc0
tuner: type set to 3 (Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF))
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video1
bttv0: registered device vbi0
hdd: attached ide-scsi driver.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TRAXDATA  Model: CDRW121032plus    Rev: LSRA
  Type:   CD-ROM                             ANSI SCSI revision: 02
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,67), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:04.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd000. Vers LK1.1.16
 00:50:04:1b:42:ee, IRQ 16
  product code 5450 rev 00.9 date 01-14-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
02:04.0: scatter/gather enabled. h/w checksums enabled
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 12x/12x xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
i2c-proc.o version 2.7.0 (20021208)
i2c-isa.o version 2.7.0 (20021208)
tuner: ignoring ISA main adapter i2c adapter [id=0x50000]
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
eeprom.o version 2.7.0 (20021208)
tuner: type already set (3)
tuner: type already set (3)
tuner: type already set (3)
tuner: type already set (3)
tuner: type already set (3)
tuner: type already set (3)
tuner: type already set (3)
tuner: type already set (3)
w83781d.o version 2.7.0 (20021208)
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
intel8x0: clocking to 48000
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 32M @ 0xf0000000
[drm] AGP 0.99 on AMD Irongate @ 0xf0000000 32MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
Processor[0]: C0 C1
Processor[1]: C0 C1
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 02:05.1, irq: 17, latency: 32, mmio: 0xf9001000
btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
amd768_rng: AMD768 system management I/O registers at 0x600.
amd768_rng hardware driver 0.1.0 loaded
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe.

--------------020309030108070107080102
Content-Type: text/plain;
 name="pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci"

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Memory at f9100000 (32-bit, prefetchable) [size=4K]
	I/O ports at ec00 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f4000000-f6ffffff
	Prefetchable memory behind bridge: f2000000-f3ffffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Flags: bus master, 66Mhz, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at e000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
	Flags: medium devsel

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-768 [Opus] Audio (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at e400 [size=256]
	I/O ports at e800 [size=64]

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f7000000-f8ffffff
	Prefetchable memory behind bridge: f9000000-f90fffff

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at f2000000 (32-bit, prefetchable) [size=32M]
	Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Memory at f5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at f8001000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at d000 [size=128]
	Memory at f8000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at f9000000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver, audio section)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at f9001000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

02:06.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at d400 [disabled] [size=256]
	Memory at f8002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>


--------------020309030108070107080102--

