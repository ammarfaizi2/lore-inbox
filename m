Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265698AbUFIIc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUFIIc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 04:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUFIIc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 04:32:26 -0400
Received: from gabber.metalab.unc.edu ([152.2.241.57]:47298 "HELO
	gabber.metalab.unc.edu") by vger.kernel.org with SMTP
	id S265698AbUFIIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 04:31:45 -0400
Date: Wed, 9 Jun 2004 10:31:42 +0200
From: Sergiusz Pawlowicz <ser@gnu.org>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: aacraid does not work on dual opteron box - 2.6.7-rc2
Message-ID: <20040609083142.GB23062@szafa>
Mail-Followup-To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux friends,
sorry for bothering you, but  current aacraid still does not
work properly on  my fresh dual opteron box  & Adaptec 2120S
RAID controler. It hungs  always after modprobing sd_mod and
disk access try.

A was googling last three days without a success - I have no
idea what can  I do to avoid problems. Did  you test aacraid
on this Adaptec controler on 64 bits & kernel 2.6.x?


1. Logs
----------------------------------------------------------

Aug  6 18:20:56 amd64 kernel: Red Hat/Adaptec aacraid driver (1.1.2-lk1 Jun 8 2004)
Aug  6 18:20:56 amd64 kernel: AAC0: kernel 4.1.4 build 7244
Aug  6 18:20:56 amd64 kernel: AAC0: monitor 4.1.4 build 7244
Aug  6 18:20:56 amd64 kernel: AAC0: bios 4.1.0 build 7244
Aug  6 18:20:56 amd64 kernel: AAC0: serial b95eecfafaf001
Aug  6 18:20:56 amd64 kernel: AAC0: 64 Bit PAE enabled
Aug  6 18:20:56 amd64 kernel: scsi0 : aacraid
Aug  6 18:20:56 amd64 kernel: Using anticipatory io scheduler
Aug  6 18:20:56 amd64 kernel: Vendor: ADAPTEC   Model: Adaptec Mirror    Rev:V1.0
Aug  6 18:20:56 amd64 kernel: Type:   Direct-Access                      ANSISCSI revision: 02
Aug  6 18:21:17 amd64 kernel: SCSI device sda: 71675392 512-byte hdwr sectors(36698 MB)
Aug  6 18:21:17 amd64 kernel: sda: Write Protect is off
Aug  6 18:21:17 amd64 kernel: SCSI device sda: drive cache: write through
Aug  6 18:21:17 amd64 kernel: /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Aug  6 18:21:17 amd64 kernel: Attached scsi removable disk sda at scsi0,channel 0, id 0, lun 0
Aug  6 18:22:32 amd64 kernel: SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
Aug  6 18:22:32 amd64 kernel: SGI XFS Quota Management subsystem
Aug  6 18:22:32 amd64 kernel: XFS: bad magic number
Aug  6 18:22:32 amd64 kernel: XFS: SB validate failed
Aug  6 18:23:06 amd64 kernel: XFS mounting filesystem sda3
Aug  6 18:25:26 amd64 kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Aug  6 18:25:26 amd64 kernel: SCSI error : <0 0 0 0> return code = 0x6000000
Aug  6 18:25:26 amd64 kernel: end_request: I/O error, dev sda, sector 43712887
Aug  6 18:25:26 amd64 kernel: xfs_force_shutdown(sda3,0x2) called from line 959 of file fs/xfs/xfs_log.c.  Return address = 0xffffffffa00ff34e


2. Hardware
----------------------------------------------------------
Dual Opteron 240
Mainboard: MSI K8D Master F
Adaptec 2120S on PCI-X 

lspci -vvv:

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: fc600000-fc6fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [c0] #08 [0086]
	Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1310
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1310
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 19
	Region 0: I/O ports at cf80 [size=32]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1310
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc900000-fc9fffff
	Prefetchable memory behind bridge: 00000000f4500000-00000000fc500000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [004a]

00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1310
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febfe000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc800000-fc8fffff
	Prefetchable memory behind bridge: 00000000f4400000-00000000f4400000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]

00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1310
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febff000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
	Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at fc8c0000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at fc8b0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] 	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0000000100000000  Data: 5a6f

01:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
	Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin B routed to IRQ 30
	Region 0: Memory at fc8e0000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at fc8d0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] 	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0000000100000000  Data: 487f

02:04.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
	Subsystem: Adaptec 2120S (Crusader)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Expansion ROM at fc9f0000 [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]

03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]

03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1310
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at b800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

3. Kernel
----------------------------------------------------------
Linux amd64 2.6.7 #1 SMP Tue Jun 8 03:21:59 CEST 2004 x86_64 0 unknown PLD Linux
= 2.6.7-0.16 (-rc2 with several patches, but not aacraid related)

my .config:
http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/kernel-amd64-smp.config?rev=1.1.2.60

compiled by gcc gcc-3.3.3 or gcc-3.4.0 - no difference


Thanks - Sergiusz
-- 
private: http://pawlowicz.name | company: http://a-k-f.com
jabber:  ser@jabber.org        | mobile:  +48  502  660860
