Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTDVUs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTDVUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:46:43 -0400
Received: from area9.server-home.net ([62.208.70.38]:54026 "EHLO AREA-9")
	by vger.kernel.org with ESMTP id S263849AbTDVUpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:45:20 -0400
Date: Tue, 22 Apr 2003 22:57:21 +0200
From: Walter Hofmann <nforce2-030422223536-fcf8@secretlab.mine.nu>
To: linux-kernel@vger.kernel.org
Subject: nforce2 IDE DMA stopped working (2.4.21-rc1)
Message-ID: <20030422205721.GA1123@secretlab.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 91D7 2B68 786F 7A3D 18FF E168 EAF4 8754
X-GPG-Key: http://search.keyserver.net:11371/pks/lookup?search=0xDE547385&op=index
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 22 Apr 2003 20:54:10.0031 (UTC) FILETIME=[5288FFF0:01C30911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.20 I could enable DMA using "hdparm -d1 /dev/hda", but with 
2.4.21-rc1 I get "HDIO_SET_DMA failed: Operation not permitted".
This is with a nForce2 chipset.

BTW: What does "hda: host protected area => 1" mean?

Walter Hofmann



"lspci -vv" output (excerpts): 

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
        Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
        Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-


00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

Boot messages:

Linux version 2.4.21-rc1 (root@gimli) (gcc version 3.2.3 20030415 
(Debian prerelease)) #2 Die Apr 22 20:30:09 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=303
Found and enabled local APIC!
Initializing CPU#0
Detected 2079.555 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4141.87 BogoMIPS
Memory: 256656k/262080k available (1402k kernel code, 5040k reserved, 
458k data, 100k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2600+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2079.6311 MHz.
..... host bus clock speed is 332.7409 MHz.
cpu: 0, clocks: 3327409, slice: 1663704
CPU0<T0:3327408,T1:1663696,D:8,S:1663704,C:3327409>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb500, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
hda: WDC WD1200BB-00CAA1, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-R5002, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63
Partition check:
 hda: hda1 hda2 < hda5 > hda3
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 100k freed
spurious 8259A interrupt: IRQ7.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 524280k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Real Time Clock Driver v1.10e
PCI: Setting latency timer of device 00:04.0 to 64
Intel 810 + AC97 Audio, version 0.24, 20:30:26 Apr 22 2003
PCI: Setting latency timer of device 00:06.0 to 64
i810: NVIDIA nForce Audio found at IO 0xb400 and 0xb000, MEM 0x0000 and 
0x0000, IRQ 12
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value = 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
Linux video capture interface: v1.00
i2c-core.o: i2c core module
saa7130/34: v4l2 driver version 0.2.7 loaded
saa7134[0]: found at 01:08.0, rev: 1, irq: 3, latency: 32, mmio: 
0xe6010000
saa7134[0]: subsystem: 1131:fe01, board: Medion 5044 [card=9,insmod 
option]
i2c-core.o: adapter saa7134[0] registered as adapter 0.
saa7134[0]: i2c eeprom 00: 31 11 01 fe 08 20 1c 55 43 43 a9 1c 55 43 43 
a9
saa7134[0]: i2c eeprom 10: ff ff 00 00 ff ff ff ff ff ff ff ff ff ff ff 
ff
saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff
i2c-core.o: driver i2c TV tuner driver registered.
tuner: probing saa7134[0] i2c adapter [id=0x90000]
tuner: chip found @ 0xc0
tuner(bttv): type forced to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) 
[insmod]
tuner: type already set (38)
i2c-core.o: client [Philips PAL/SECAM multi (FM1216M] registered to 
adapter [saa7134[0]](pos. 0).
i2c-core.o: driver i2c tda9887 driver registered.
tda9887: probing saa7134[0] i2c adapter [id=0x90000]
tda9887: chip found @ 0x86
tuner: type already set (38)
i2c-core.o: client [tda9887] registered to adapter [saa7134[0]](pos. 1).
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
hdc: attached ide-cdrom driver.
hdc: ATAPI 48X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-cd: ignoring drive hdd
SCSI subsystem driver Revision: 1.00
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R5002  Rev: 1031
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: No IRQ known for interrupt pin A of device 00:02.0. Please try 
using pci=biosirq.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xd08db000, IRQ 5
usb-ohci.c: usb-00:02.1, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 00:02.1-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x1241/0x1122) is not claimed by any 
active driver.
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002  on loop(7,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on loop(7,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
saa7134[0]/audio: audio carrier scan failed, using 5.500 MHz [default]
PCI: Setting latency timer of device 00:02.2 to 64
ehci-hcd 00:02.2: PCI device 10de:0068 (nVidia Corporation)
ehci-hcd 00:02.2: irq 12, pci mem d08f9000
usb.c: new USB bus registered, assigned bus number 2
PCI: 00:02.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:02.2 PCI cache line size corrected to 64.
ehci-hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 20:30:39 Apr 22 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: USB disconnect on device 00:02.1-2 address 2
hub.c: new USB device 00:02.1-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x1241/0x1122) is not claimed by any 
active driver.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [1241:1122] on usb1:3.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers

