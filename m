Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVAMNCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVAMNCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVAMNCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:02:40 -0500
Received: from gsc-game.kiev.ua ([62.244.14.42]:59862 "EHLO
	redhat.gsc-game.kiev.ua") by vger.kernel.org with ESMTP
	id S261611AbVAMNC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:02:29 -0500
X-Privacy-Violation: The copy of this message was sent to <mailspy@gsc-game.kiev.ua> due to business requirements
Message-ID: <000f01c4f970$202f4a40$e310f43e@manowar>
Reply-To: "Serguei I. Ivantsov" <manowar@gsc-game.kiev.ua>
From: "Serguei I. Ivantsov" <manowar@gsc-game.kiev.ua>
To: <linux-kernel@vger.kernel.org>
Subject: Can't make D-Link DFE-580TX 4 port Server Adapter working - problems with PCI?
Date: Thu, 13 Jan 2005 15:02:24 +0200
Organization: GSC Game World
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1218
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1218
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I browse the Internet with this problem. There is a lot of people with the
same , but no solutions.

My config:

Fedora Core 3. Linux 2.6.10.
VIA KM400/AMD Athlon XP 1700+/256MB/onboard VIA RhineII/PCI D-Link
DFE-580TX/USB off/AC97 off

cut from
dmesg: ---------------------------------------------------------------------
---------------------------------------------
..
sundance.c:v1.01+LK1.09a 10-Jul-2003  Written by Donald Becker
  http://www.scyld.com/network/sundance.html
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
eth1: D-Link DFE-580TX 4 port Server Adapter at 0xcf804000,
6f:ef:6f:ef:6f:ef, IRQ 11.
eth1: No MII transceiver found, aborting.  ASIC status f000ef6f
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 7 (level, low) -> IRQ 7
eth1: D-Link DFE-580TX 4 port Server Adapter at 0xcf804000,
6f:ef:6f:ef:6f:ef, IRQ 7.
eth1: No MII transceiver found, aborting.  ASIC status f000ef6f
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
eth1: D-Link DFE-580TX 4 port Server Adapter at 0xcf804000,
6f:ef:6f:ef:6f:ef, IRQ 10.
eth1: No MII transceiver found, aborting.  ASIC status f000ef6f
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
eth1: D-Link DFE-580TX 4 port Server Adapter at 0xcf804000,
6f:ef:6f:ef:6f:ef, IRQ 10.
eth1: No MII transceiver found, aborting.  ASIC status f000ef6f
..
cut from
lspci:----------------------------------------------------------------------
-----------------------------------------------
..
00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400/A] Chipset Host
Bridge
 Subsystem: VIA Technologies, Inc. VT8378 [KM400/A] Chipset Host Bridge
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
 Latency: 8
 Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
 Capabilities: [80] AGP version 3.5
  Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
  Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 Capabilities: [c0] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00
[Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 Memory behind bridge: ea000000-ebffffff
 Prefetchable memory behind bridge: e4000000-e7ffffff
 Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ <SERR- <PERR+
 BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 Capabilities: [80] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal
decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32, Cache Line Size 08
 Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
 I/O behind bridge: 0000d000-0000dfff
 Memory behind bridge: ec000000-ec0fffff
 Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
  Bridge: PM- B3+

00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a
[Master SecP PriP])
 Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235
PIPC Bus Master IDE
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32
 Interrupt: pin A routed to IRQ 11
 Region 4: I/O ports at e000 [size=16]
 Capabilities: [c0] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800
South]
 Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 South]
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Capabilities: [c0] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
78)
 Subsystem: Micro-Star International Co., Ltd.: Unknown device 7061
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (750ns min, 2000ns max), Cache Line Size 08
 Interrupt: pin A routed to IRQ 11
 Region 0: I/O ports at e500 [size=256]
 Region 1: Memory at ec101000 (32-bit, non-prefetchable) [size=256]
 Capabilities: [40] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378 [S3
UniChrome] Integrated Video (rev 01) (prog-if 00 [VGA])
 Subsystem: Micro-Star International Co., Ltd.: Unknown device 7061
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (500ns min)
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
 Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
 Capabilities: [60] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 Capabilities: [70] AGP version 2.0
  Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
  Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:04.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
 Subsystem: D-Link System Inc DFE-580TX
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
 Interrupt: pin A routed to IRQ 11
 Region 0: I/O ports at d000 [size=128]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:05.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
 Subsystem: D-Link System Inc DFE-580TX
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
 Interrupt: pin A routed to IRQ 7
 Region 0: I/O ports at d100 [size=128]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:06.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
 Subsystem: D-Link System Inc DFE-580TX
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
 Interrupt: pin A routed to IRQ 10
 Region 0: I/O ports at d200 [size=128]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:07.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
 Subsystem: D-Link System Inc DFE-580TX
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
 Interrupt: pin A routed to IRQ 10
 Region 0: I/O ports at d300 [size=128]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

