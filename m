Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264262AbRFOHgO>; Fri, 15 Jun 2001 03:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264264AbRFOHgF>; Fri, 15 Jun 2001 03:36:05 -0400
Received: from interprise.de ([195.143.115.18]:35686 "EHLO
	iplanet.interprise.de") by vger.kernel.org with ESMTP
	id <S264262AbRFOHfq>; Fri, 15 Jun 2001 03:35:46 -0400
Message-ID: <3B29BAA1.720A55E7@gauss-interprise.com>
Date: Fri, 15 Jun 2001 09:34:57 +0200
From: Stefan Kuhr <stefan.kuhr@gauss-interprise.com>
Organization: Gauss Interprise AG
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CD-ROM on third IDE channel masks interrupts
Content-Type: multipart/mixed;
 boundary="------------28165AC6D1E7AEE4021D64A7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------28165AC6D1E7AEE4021D64A7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi,

I have the following problem with kernels 2.4.X:

I have a Dell Lattitude C600 Notebook with C/Dock II docking station.
In the media bay I installed an additional second hard disk.

When docked I would like to use the CD-ROM in the bay of the docking
station.
But when the CD-ROM is in the bay, I cannot use the ethernet card and
SCSI controller
of the docking station anymore, because as far as I can tell, the CD-ROM
on IDE channel 2
masks the IRQ for the the other two device.

So far I had no success playing with the interrupt allocation.

My system:

Dell Lattitude C 600, 
C/Dock II docking station

Output ver_linux:
 
Linux gonzo 2.4.5 #4 Die Jun 12 10:03:53 CEST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1343073 Mai 11 16:50
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         parport_pc lp parport mousedev input usb-uhci
usbcore ipv6 ds yenta_socket pcmcia_core 3c59x

I append the boot messages and pci setup.

Thanks for any help.

Stefan
--------------28165AC6D1E7AEE4021D64A7
Content-Type: text/plain; charset=us-ascii;
 name="pci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.txt"

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd000000-feffffff
	Prefetchable memory behind bridge: f4000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:03.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Dell Computer Corporation: Unknown device 00b1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Dell Computer Corporation: Unknown device 00b1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 0860 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00b1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at f9ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-0000ffff
	Memory behind bridge: fb000000-fcffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Mobility M3 AGP 2x (rev 02) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00b1
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at ec00 [size=256]
	Region 2: Memory at fdffc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 IDE interface: CMD Technology Inc PCI0646 (rev 07) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: CMD Technology Inc PCI0646
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at fcf8 [size=8]
	Region 1: I/O ports at fcf0 [size=4]
	Region 2: I/O ports at fce0 [size=8]
	Region 3: I/O ports at fcd8 [size=4]
	Region 4: I/O ports at fcc0 [size=16]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

02:07.0 SCSI storage controller: Adaptec AIC-7880U (rev 02)
	Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f800 [size=256]
	Region 1: Memory at fbfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fc000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 00a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at fc00 [size=128]
	Region 1: Memory at fbffec00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fc000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
	Subsystem: Xircom Cardbus Ethernet 10/100
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at 20800000 (32-bit, non-prefetchable) [size=2K]
	Region 2: Memory at 20800800 (32-bit, non-prefetchable) [size=2K]
	Expansion ROM at 20400000 [size=16K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
	Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1080 [size=8]
	Region 1: Memory at 20801000 (32-bit, non-prefetchable) [size=2K]
	Region 2: Memory at 20801800 (32-bit, non-prefetchable) [size=2K]
	Expansion ROM at 20404000 [size=16K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


--------------28165AC6D1E7AEE4021D64A7
Content-Type: text/plain; charset=us-ascii;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Cannot find map file.
No module symbols loaded.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.4.5 (root@gonzo) (gcc version 2.95.3 20010315 (SuSE)) #4 Die Jun 12 10:03:53 CEST 2001
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
<4> BIOS-e820: 000000001ffec000 - 000000001fff0000 (reserved)
<4> BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
<4>Scan SMP from c0000000 for 1024 bytes.
<4>Scan SMP from c009fc00 for 1024 bytes.
<4>Scan SMP from c00f0000 for 65536 bytes.
<4>Scan SMP from c009fc00 for 4096 bytes.
<4>On node 0 totalpages: 131052
<4>zone(0): 4096 pages.
<4>zone(1): 126956 pages.
<4>zone(2): 0 pages.
<4>mapped APIC to ffffe000 (01884000)
<4>Kernel command line: auto BOOT_IMAGE=lx245-1-kuhr ro root=305 BOOT_FILE=/boot/vmlinuz_245-1 SCHEME=kuhr 
<6>Initializing CPU#0
<4>Detected 701.605 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1399.19 BogoMIPS
<4>Memory: 512028k/524208k available (1512k kernel code, 11792k reserved, 546k data, 248k init, 0k highmem)
<4>Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
<7>CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
<4>CPU: Intel Pentium III (Coppermine) stepping 06
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<4>PCI: PCI BIOS revision 2.10 entry at 0xfc13e, last bus=2
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<3>Unknown bridge resource 2: assuming transparent
<6>PCI: Discovered primary peer bus 08 [IRQ]
<6>PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
<3>  got res[20000000:20000fff] for resource 0 of Texas Instruments PCI1420
<3>  got res[20001000:20001fff] for resource 0 of Texas Instruments PCI1420 (#2)
<6>Limiting direct PCI/PCI transfers.
<4>isapnp: Scanning for PnP cards...
<4>isapnp: No Plug & Play device found
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
<4>Starting kswapd v1.8
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05a (2001-03-20) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>Real Time Clock Driver v1.10d
<4>block: queued sectors max/low 340309kB/209237kB, 1024 slots per queue
<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PIIX4: IDE controller on PCI bus 00 dev 39
<4>PIIX4: chipset revision 1
<4>PIIX4: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
<4>CMD646: IDE controller on PCI bus 02 dev 28
<4>CMD646: chipset revision 7
<4>CMD646: chipset revision 0x07, UltraDMA Capable
<4>CMD646: 100%% native mode on irq 10
<4>    ide2: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdg:pio, hdh:pio
<4>hda: IBM-DJSA-220, ATA DISK drive
<4>hdc: HITACHI_DK23BA-20, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2432/255/63, UDMA(33)
<6>hdc: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
<6>Partition check:
<6> hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
<6> hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 >
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>loop: loaded (max 8 devices)
<6>SCSI subsystem driver Revision: 1.00
<3>request_module[scsi_hostadapter]: Root fs not mounted
<3>request_module[scsi_hostadapter]: Root fs not mounted
<3>request_module[scsi_hostadapter]: Root fs not mounted
<6>linear personality registered
<6>raid5 personality registered
<6>raid5: measuring checksumming speed
<4>   8regs     :  1163.200 MB/sec
<4>   32regs    :   878.800 MB/sec
<4>   pIII_sse  :  1424.000 MB/sec
<4>   pII_mmx   :  1588.400 MB/sec
<4>   p5_mmx    :  1656.400 MB/sec
<4>raid5: using function: pIII_sse (1424.000 MB/sec)
<6>md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<5>ACPI: APM is already active, exiting
<4>md.c: sizeof(mdp_super_t) = 4096
<6>autodetecting RAID arrays
<4>autorun ...
<4>... autorun DONE.
<6>LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
<4>lvm -- Driver successfully initialized
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 4096 buckets, 32Kbytes
<4>TCP: Hash tables configured (established 32768 bind 32768)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<5>RAMDISK: Compressed image found at block 0
<4>Freeing initrd memory: 464k freed
<4>VFS: Mounted root (ext2 filesystem).
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>change_root: old root has d_count=2
<5>Trying to unmount old root ... okay
<4>Freeing unused kernel memory: 248k freed
<4>lvm -- lvm_chr_ioctl: unknown command 4004fe0a
<4>lvm -- lvm_chr_ioctl: unknown command 4004fe0a
<4>lvm -- lvm_chr_ioctl: unknown command 4004fe0a
<4>lvm -- lvm_chr_ioctl: unknown command 4004fe0a
<4>lvm -- lvm_chr_ioctl: unknown command 4004fe0a
<6>Adding Swap: 1052248k swap-space (priority -1)
<4>reiserfs: checking transaction log (device 3a:04) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:05) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:00) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:03) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:06) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:01) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:02) ...
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--------------28165AC6D1E7AEE4021D64A7--

