Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319086AbSH1Wcl>; Wed, 28 Aug 2002 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSH1Wck>; Wed, 28 Aug 2002 18:32:40 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:32484 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S319086AbSH1Wc0>; Wed, 28 Aug 2002 18:32:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Subject: ide-scsi on ide-2.4.20-pre4-ac2
Date: Thu, 29 Aug 2002 00:36:49 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020828223226Z319086-685+38604@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Andre,

I want to confirm that using ide-scsi with the latest ide-patch from Andre 
now works!! just burned a cd and then read the whole disk back to hd without 
any errors!!

	Rudmer

some system info:

messages on loading scsi-modules:
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 23.D
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray

output of /proc/ide/sis:

SiS 5513 Ultra 100 chipset
--------------- Primary Channel ---------------- Secondary Channel 
-------------
Channel Status: On 	 	 	 	 On 
Operation Mode: Compatible 	 	 	 Compatible 
Cable Type:     80 pins 	 	 	 40 pins
Prefetch Count: 512 	 	 	 	 512
Drive 0:        Postwrite Enabled 	 	 Postwrite Disabled
                Prefetch  Enabled 	 	 Prefetch  Disabled
                UDMA Enabled 	 	 	 UDMA Disabled
                UDMA Cycle Time    2 CLK 	 UDMA Cycle Time    Reserved
                Data Active Time   3 PCICLK 	 Data Active Time   3 PCICLK
                Data Recovery Time 1 PCICLK 	 Data Recovery Time 1 PCICLK
Drive 1:        Postwrite Disabled 	 	 Postwrite Disabled
                Prefetch  Disabled 	 	 Prefetch  Disabled
                UDMA Disabled 	 	 	 UDMA Disabled
                UDMA Cycle Time    Reserved 	 UDMA Cycle Time    Reserved
                Data Active Time   8 PCICLK 	 Data Active Time   8 PCICLK
                Data Recovery Time 12 PCICLK 	 Data Recovery Time 12 PCICLK


output of lspci -vvv:
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=32M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: cee00000-cfefffff
        Prefetchable memory behind bridge: ccc00000-cecfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at ff00 [size=16]

00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=32]

00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Ethernet controller: Winbond Electronics Corp W89C940
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=32]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 
01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at cd000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at cf000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at cfee0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


output of scripts/ver_linux:

Linux gandalf 2.4.20-pre4-ac2 #1 Wed Aug 28 15:00:43 CEST 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11q
mount                  2.11q
modutils               2.4.16
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         sg nls_iso8859-1 ide-scsi sr_mod scsi_mod cdrom isofs 
zlib_inflate

