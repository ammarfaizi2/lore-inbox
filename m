Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTEJUw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTEJUw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:52:26 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:59107 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264501AbTEJUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:52:18 -0400
Date: Sat, 10 May 2003 17:04:56 -0400
From: Mace Moneta <mmoneta@optonline.net>
Subject: [bug] 2.4.21-rc2 kernel panic USB sched.c:564
To: linux-kernel@vger.kernel.org
Reply-to: mmoneta@optonline.net
Message-id: <1052600695.12657.4.camel@optonline.net>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: multipart/signed; boundary="=-dBQFs3yT564jlCA0O0uG";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dBQFs3yT564jlCA0O0uG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

When Attempting to sync a Handspring Visor (PalmOS USB device), I
sometimes (about 1 time out of 4) get the following panic. =20

--

Scheduling in interrupt
kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0117811>]    Tainted: PF
EFLAGS: 00010286
eax: 00000018   ebx: d8c90ce0   ecx: dd1ba000   edx: dd1bbf7c
esi: c02b6000   edi: d8c90ce8   epb: c02b7d7c   esp: c02b7d54
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Dc02b7000)=20
Stack: c024d76a de13d980 dfca2680 e1da294f c02b6000 00000000 01a6010b d8c90=
ce0
       c02b6000 d8c90ce8 c02b7d84 c0107c4a 00000001 c02b6000 d8c90ce8 d8c90=
ce8
       d8c90c88 d8c90ce0 d8c90c00 ffffffea c0107da4 d8c90ce0 d8c90c00 fffff=
fed
Call Trace:    [<e1da294f>] [<c0107c4a>] [<c0107da4>] [<e3235a73>] [<e3235c=
08>]
  [<c0176122>] [<c0177ded>] [<c0176bc7>] [<c0185623>] [<c0184925>] [<e1c45b=
10>]
 =20
...

Code: 0f 0b 34 02 62 d7 24 c0 e9 09 fd ff ff 0f 0b 2d 02 62 d7 24
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--


# lspci -vvv
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge =
(rev 04)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4
                Command: RQ=3D0 SBA- AGP+ 64bit- FW- Rate=3Dx4
=20
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (r=
ev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fd000000-fdffffff
        Prefetchable memory behind bridge: d7f00000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
=20
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog=
-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at efe0 [size=3D32]
=20
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog=
-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 7
        Region 4: I/O ports at ef80 [size=3D32]
=20
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog=
-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 6
        Region 4: I/O ports at 1000 [size=3D32]
=20
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 0=
0 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D=
64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fce00000-fcefffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
=20
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
=20
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [=
Master SecP PriP])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 6
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at cfa0 [size=3D16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]
=20
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (r=
ev 02)
        Subsystem: Toshiba America Info Systems: Unknown device 0002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1400 [size=3D256]
        Region 1: I/O ports at 1040 [size=3D64]
=20
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Ge=
neric])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1800 [size=3D256]
        Region 1: I/O ports at 1080 [size=3D128]
=20
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 Go=
] (rev a3) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M=
]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
        Region 2: Memory at d7f80000 (32-bit, prefetchable) [size=3D512K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=3D31 SBA- 64bit- FW+ Rate=3Dx1,x2,x4
                Command: RQ=3D31 SBA- AGP+ 64bit- FW- Rate=3Dx4
=20
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000=
 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: [virtual] Memory at 20000800 (32-bit, non-prefetchable) [=
size=3D2K]
        Region 1: [virtual] Memory at 20004000 (32-bit, non-prefetchable) [=
size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D55mA PME(D0+,D1+,D=
2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=20
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) E=
thernet Controller (rev 42)
        Subsystem: Toshiba America Info Systems EtherExpress PRO/100 VE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at fceff000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at df40 [size=3D64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-
=20
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus=
 Bridge with ZV Support (rev 32)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=3D4K]
        Bus: primary=3D02, secondary=3D04, subordinate=3D04, sec-latency=3D=
0
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrit=
e+
        16-bit legacy interface ports at 0001
=20
02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus=
 Bridge with ZV Support (rev 32)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 20002000 (32-bit, non-prefetchable) [size=3D4K]
        Bus: primary=3D02, secondary=3D05, subordinate=3D05, sec-latency=3D=
0
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrit=
e+
        16-bit legacy interface ports at 0001
=20
02:0c.0 System peripheral: Toshiba America Info Systems TC6371AF SmartMedia=
 Controller (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 20000400 (32-bit, non-prefetchable) [disabled] =
[size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=3D0 DScale=3D0 PME-
=20
02:0d.0 System peripheral: Toshiba America Info Systems SD TypA Controller =
(rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 20000600 (32-bit, non-prefetchable) [disabled] =
[size=3D512]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=3D0 DScale=3D0 PME-
=20


--=-dBQFs3yT564jlCA0O0uG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+vWl3eRnU1Q3hpXYRAgOuAJ9VMzx+BSooaHmkQ7gJmMxxx4+FkACgqL45
91S/ARUZkGoGD0KiWJGJ+8I=
=WMVz
-----END PGP SIGNATURE-----

--=-dBQFs3yT564jlCA0O0uG--

