Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271356AbTHDB6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 21:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTHDB6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 21:58:40 -0400
Received: from net28ip52nit.parklink.com ([192.204.28.52]:8838 "EHLO
	okcomputer") by vger.kernel.org with ESMTP id S271356AbTHDB62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 21:58:28 -0400
Subject: Yenta init freezes Pavilion
From: Pat Rondon <pat@thepatsite.com>
Reply-To: pat@thepatsite.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4JyJU7qhEH5iVf5JMpj+"
Message-Id: <1059962307.3774.18.camel@okcomputer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 21:58:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4JyJU7qhEH5iVf5JMpj+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

  Please bear with me, I'm not very familiar with submitting problem
reports.
  When booting my HP Pavilion zt1145 (see below), the system freezes
once it gets to checking the cardbus status:

Yenta IRQ list 0000, PCI irq11
Socket status: 30000006

  This is with pci=3Dnoacpi acpi=3Doff.  Without those options, it'll
typically freeze a little later in the boot process, well before init.=20
The laptop boots fine without Yenta support compiled in.

The following was collected when booting from 2.4.20.

Output from lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133]
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
-
FW- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- FW- Rate=3Dx4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: 90000000-9fffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:04.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e200 [size=3D256]
	Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min, 63750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f0000800 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: I/O ports at e300 [size=3D128]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 Communication controller: ESS Technology ES2838/2839 SuperLink
Modem (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e380 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D55mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME+

00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge]
(rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1100 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1e) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 1200 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1e) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 1300 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.4 Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
AC97 Audio Controller (rev 40)
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at e000 [size=3D256]
	Region 1: I/O ports at e100 [size=3D4]
	Region 2: I/O ports at e104 [size=3D4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: S3 Inc. 86C380 [ProSavageDDR K4M266]
(rev 02) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=3D512K]
	Region 1: Memory at 90000000 (32-bit, prefetchable) [size=3D128M]
	Expansion ROM at 000c0000 [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GART64- HTrans- 64bit=
-
FW- AGP3- Rate=3Dx4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3Dx4

Output from /proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0efeffff : System RAM
  00100000-00274268 : Kernel code
  00274269-002ccbff : Kernel data
0eff0000-0effffbf : ACPI Tables
0effffc0-0effffff : ACPI Non-volatile Storage
10000000-10000fff : PCI device 1524:1410
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
60000000-60000fff : card services
90000000-9fffffff : PCI Bus #01
  90000000-97ffffff : PCI device 5333:8d01
a0000000-a3ffffff : PCI device 1106:0605
e0000000-efffffff : PCI Bus #01
  e0000000-e007ffff : PCI device 5333:8d01
f0000000-f00000ff : PCI device 10ec:8139
  f0000000-f00000ff : 8139too
f0000800-f0000fff : PCI device 1106:3044
fff80000-ffffffff : reserved

Output from /proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1100-110f : PCI device 1106:0571
  1100-1107 : ide0
  1108-110f : ide1
1200-121f : PCI device 1106:3038
  1200-121f : usb-uhci
1300-131f : PCI device 1106:3038
  1300-131f : usb-uhci
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
c000-dfff : PCI Bus #01
e000-e0ff : PCI device 1106:3058
  e000-e0ff : VIA686A
e100-e103 : PCI device 1106:3058
e104-e107 : PCI device 1106:3058
e200-e2ff : PCI device 10ec:8139
  e200-e2ff : 8139too
e300-e37f : PCI device 1106:3044
e380-e38f : PCI device 125d:2838

Sorry if this is too much or too little information.  Please let me know
of anything I can do to help.  I'll be trying previous kernels to see if
I can narrow down where this problem began occurring.

--=-4JyJU7qhEH5iVf5JMpj+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Lb3CruzBsw43EvgRAknPAJ9iZsZNKGRFThACJFxLphirAghxtQCggkZU
Pkgy/53vrwGdEgHgPk19db0=
=YzbQ
-----END PGP SIGNATURE-----

--=-4JyJU7qhEH5iVf5JMpj+--

