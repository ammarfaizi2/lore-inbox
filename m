Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290576AbSARBtu>; Thu, 17 Jan 2002 20:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290577AbSARBtn>; Thu, 17 Jan 2002 20:49:43 -0500
Received: from [208.29.163.248] ([208.29.163.248]:30173 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290576AbSARBtf>; Thu, 17 Jan 2002 20:49:35 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 17 Jan 2002 17:49:12 -0800 (PST)
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <3C476D51.2070303@candelatech.com>
Message-ID: <Pine.LNX.4.40.0201171733460.26448-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Ben Greear wrote:

> You're not using a PCI extender/riser card, are you?

Yes, (it's in a 2u rackmount case). it's a low right-angle extender

> What motherboard?

happens on at least two different ones, I'll have to get the exact model
numbers tomorrow. One is a 6 month old Athlon t-bird 1.2GHz and the other
is a 3 week old 1.4GHz Athlon XP

> By lockup, how hard is it?  Will the reset button work quickly?
> After 5 or so seconds?

hard, magic sysreq doesn't work, reset doesn't work at all, power shuts
down after 4-5 seconds


> You should probably send an lspci -vv and the interesting parts from
> dmesg (or /var/log/messages)...

I put in the full dmesg for 2.4.5-pre1 and 2.4.17 (just in case there's
other relevent stuff, with a tailored kernel it's fairly small) and one
copy of lspci -vv (same on both versions)

here is 2.4.5-pre1
Linux version 2.4.5-pre1 (root@dlang) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #11 Mon May 14 07:25:00 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01804000)
Kernel command line: BOOT_IMAGE=linux-orig ro root=302 hdc=scsi
ide_setup: hdc=scsi
Initializing CPU#0
Detected 1401.758 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2798.38 BogoMIPS
Memory: 513364k/524224k available (1296k kernel code, 10472k reserved, 423k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
parport_pc: Via 686A parallel port disabled in BIOS
pty: 2048 Unix98 ptys configured
lp: driver loaded but no devices found
block: queued sectors max/low 341202kB/210130kB, 1024 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: IC35L040AVER07-0, ATA DISK drive
hdd: CD-W28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Linux Tulip driver version 0.9.14e (April 20, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
02:04.0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xd000, 00:80:C8:B9:C5:55, IRQ 7.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
02:05.0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xd400, 00:80:C8:B9:C5:56, IRQ 5.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
02:06.0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0xd800, 00:80:C8:B9:C5:57, IRQ 10.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
02:07.0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0xdc00, 00:80:C8:B9:C5:58, IRQ 11.
Universal TUN/TAP device driver 1.3 (C)1999-2000 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W28E           Rev: 1.1A
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (4095 buckets, 32760 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 2048248k swap-space (priority -1)


here is 2.4.17
Linux version 2.4.17 (root@dlang) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Fri Jan 11 08:56:43 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.17.ipc ro root=302 hdd=scsi
ide_setup: hdd=scsi
Initializing CPU#0
Detected 1401.731 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2798.38 BogoMIPS
Memory: 513224k/524224k available (1409k kernel code, 10612k reserved, 442k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
Starting kswapd
Journalled Block Device driver loaded
parport_pc: Via 686A parallel port disabled in BIOS
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp: driver loaded but no devices found
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: IC35L040AVER07-0, ATA DISK drive
hdd: CD-W28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xd000, 00:80:C8:B9:C5:55, IRQ 7.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xd400, 00:80:C8:B9:C5:56, IRQ 5.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0xd800, 00:80:C8:B9:C5:57, IRQ 10.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0xdc00, 00:80:C8:B9:C5:58, IRQ 11.
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W28E           Rev: 1.1A
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (4095 buckets, 32760 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 2048248k swap-space (priority -1)

and here is lspci -vv (same on both versions)

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d9000000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at ec00 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: d4000000-d6ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device a702
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at e000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d8ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:05.0 VGA compatible controller: Trident Microsystems Blade 3D PCI/AGP (rev 3a) (prog-if 00 [VGA])
	Subsystem: Trident Microsystems Blade 3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at d000 [size=128]
	Region 1: Memory at d8000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d400 [size=128]
	Region 1: Memory at d8001000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=128]
	Region 1: Memory at d8002000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: D-Link System Inc: Unknown device 1112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=128]
	Region 1: Memory at d8003000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]


let me know if you need anything else

David Lang

> David Lang wrote:
>
> > as I have not received any response directly I am sending this to the full
> > list for help.
> >
> > David Lang
> >
> > ---------- Forwarded message ----------
> > Date: Mon, 14 Jan 2002 15:10:42 -0800 (PST)
> > From: David Lang <dlang@diginsite.com>
> > To: Jeff Garzik <jgarzik@mandrakesoft.com>
> > Subject: Tulip driver bug in 2.4.17
> >
> > I am running a dlink DFE-570TX quad card that works fine with the 0.9.14
> > driver in 2.4.8, but with the 2.4.15-pre9 driver in 2.4.14-2.4.17 I run
> > into a bug when trying to use all the interfaces.
> >
> > if I use eth3 alone it works
> > if I use eth0, eth1, eth2 it works
> > if I use eth0, eth1, eth3 it locks up immediatly following the ifconfig,
> > locking up to the point that the magic sysreq stuff doesn't work!
> >
> > if I work the other direction and ifconfig eth3, eth2, eth1, eth0 I get a
> > shell prompt back after the last ifconfig before it locks up.
> >
> > I posted this friday on sourceforge, but looking today at the activity
> > there it doesn't look like it's in use much now so I'm sending this
> > directly to you. If there is any other place I should send it or any
> > additional tests I should perform, please let me know (I have 50 of these
> > cards either in production or headed there soon :-)
> >
> > David Lang
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
