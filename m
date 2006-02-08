Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWBHS2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWBHS2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWBHS2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:28:51 -0500
Received: from math.ut.ee ([193.40.36.2]:11422 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1030397AbWBHS2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:28:51 -0500
Date: Wed, 8 Feb 2006 20:28:38 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139324653.18391.41.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602082024010.21660@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor> 
 <1139310335.18391.2.camel@localhost.localdomain>  <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
  <1139312330.18391.14.camel@localhost.localdomain>
 <1139324653.18391.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new kind of crash on ALi chipset laptop (Toshiba Satellite 1800), 
lspci below. I could not use netconsole on this laptop since yenta is 
initialized after netconsole and so my cardbus NIC is not usable for 
netconsole. I captured the details using a digital camera, in 2 
different vga resolutions (to see different parts of it):

http://www.cs.ut.ee/~mroos/alicrash1.png
http://www.cs.ut.ee/~mroos/alicrash2.png

lspci details of the laptop:

0000:00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
 	Latency: 0
 	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: [b0] AGP version 2.0
 		Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 	Capabilities: [a4] Power Management version 1
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 44 16 07 00 10 a2 01 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00
40: 1d 1f 0d 00 3d 10 04 14 00 20 2c 45 00 20 20 00
50: 00 00 00 00 3b 10 04 2f 00 30 00 00 00 20 20 ff
60: 82 cc 00 00 00 00 00 00 6f 8c 00 91 40 04 19 05
70: 8b 8b 94 14 00 00 00 00 00 a2 b7 57 00 08 03 02
80: 00 00 53 b7 31 88 8f f0 20 02 00 00 00 00 78 00
90: 15 00 f5 49 00 00 00 00 08 00 00 00 f8 ae 00 00
a0: 34 ee 01 00 01 00 01 00 00 00 00 00 00 00 00 00
b0: 02 a4 20 00 07 02 00 1b 00 00 00 00 08 00 37 01
c0: 10 00 13 10 00 00 00 f0 c0 68 00 c0 00 00 00 00
d0: 67 c0 60 cf 00 b0 65 1e 00 00 00 80 81 81 89 00
e0: 00 60 20 00 00 00 b8 40 00 00 08 00 00 00 28 31
f0: 00 80 00 3c 80 07 80 07 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff
 	Memory behind bridge: f7f00000-fdffffff
 	Prefetchable memory behind bridge: 28000000-280fffff
 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
00: b9 10 47 52 07 00 00 04 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
20: f0 f7 f0 fd 00 28 00 28 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
 	Subsystem: Toshiba America Info Systems: Unknown device 0004
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
 	Interrupt: pin A routed to IRQ 11
 	Region 0: Memory at f7eff000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [60] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 07 00 90 02 03 10 03 0c 08 40 00 00
10: 00 f0 ef f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 04 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 15 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 c0 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if f0)
 	Subsystem: Toshiba America Info Systems: Unknown device 0004
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (500ns min, 1000ns max)
 	Interrupt: pin A routed to IRQ 255
 	Region 4: I/O ports at eff0 [size=16]
 	Capabilities: [60] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c3 f0 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: f1 ef 00 00 00 00 00 00 00 00 00 00 79 11 04 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 02 04
40: 06 00 00 7f 00 00 00 00 00 02 23 c9 00 80 ba 1a
50: 03 00 00 89 01 01 0a 0a 02 31 31 00 02 31 31 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 01)
 	Subsystem: Toshiba America Info Systems: Unknown device 0001
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
 	Latency: 64 (500ns min, 6000ns max)
 	Interrupt: pin A routed to IRQ 11
 	Region 0: I/O ports at 1000 [size=256]
 	Region 1: Memory at 28100000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [dc] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 51 54 07 00 90 c2 01 00 01 04 00 40 00 00
10: 01 10 00 00 00 00 10 28 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 ff 01 02 18
40: 00 00 00 00 aa 00 08 e2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 e6
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
 	Subsystem: Toshiba America Info Systems: Unknown device 0004
 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Capabilities: [a0] Power Management version 1
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 04 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 07 12 0b c0 1d 00 00 07 99 00 00 90 00 00 ed 03
50: 00 00 00 00 70 00 02 00 7c 00 00 00 00 00 00 04
60: 60 21 00 80 00 00 00 00 00 00 00 00 00 64 00 00
70: 91 00 2f 00 09 1f 81 50 aa 42 01 20 31 00 00 11
80: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 e1 02 00 80 00 80 72 c3 06 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
 	Subsystem: Toshiba America Info Systems: Unknown device 0001
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 44 08 00 00 80 23 01 28 00 0c 30 00 00 00 13
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 80 00 00 00 00 00 08 f3 77 10 32 bf 06 10 00
80: 37 82 1a 13 00 00 00 00 06 02 00 00 00 00 00 44
90: 00 aa 00 00 00 00 00 4d f8 ff 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 08 0c 00 b2 00 b0 00 00 00
b0: 00 8c 00 1c 00 c9 62 00 70 04 00 00 00 00 00 80
c0: 1a 10 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 46 00 00 00 00 02 00 00 00 00 00 0c 00 00 00
e0: 00 ee 00 ef 01 00 01 00 00 00 00 00 00 00 00 00
f0: 01 00 20 7e 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus Bridge with ZV Support (rev 32)
 	Subsystem: Toshiba America Info Systems: Unknown device 0001
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 168
 	Interrupt: pin A routed to IRQ 11
 	Region 0: Memory at 28101000 (32-bit, non-prefetchable) [size=4K]
 	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
 	Memory window 0: 20000000-21fff000 (prefetchable)
 	Memory window 1: 22000000-23fff000
 	I/O window 0: 00001400-000014ff
 	I/O window 1: 00001800-000018ff
 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
 	16-bit legacy interface ports at 0001
00: 79 11 17 06 07 00 90 04 32 00 07 06 00 a8 82 00
10: 00 10 10 28 80 00 80 04 00 02 05 00 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 14 00 00
30: fc 14 00 00 00 18 00 00 fc 18 00 00 ff 01 80 05
40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 01 00 00 00 80 00 00 00 00 00 00 00 00 01
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: d0 10 00 86 00 00 00 0c 00 80 00 00 00 d1 00 00
b0: cf 3f 3f 3f 20 10 08 0a 00 01 01 10 00 3f 02 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00

0000:00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus Bridge with ZV Support (rev 32)
 	Subsystem: Toshiba America Info Systems: Unknown device 0001
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 168
 	Interrupt: pin B routed to IRQ 11
 	Region 0: Memory at 28102000 (32-bit, non-prefetchable) [size=4K]
 	Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
 	Memory window 0: 24000000-25fff000 (prefetchable)
 	Memory window 1: 26000000-27fff000
 	I/O window 0: 00001c00-00001cff
 	I/O window 1: 00002000-000020ff
 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
 	16-bit legacy interface ports at 0001
00: 79 11 17 06 07 00 90 04 32 00 07 06 00 a8 82 00
10: 00 20 10 28 80 00 80 04 00 06 09 00 00 00 00 24
20: 00 f0 ff 25 00 00 00 26 00 f0 ff 27 00 1c 00 00
30: fc 1c 00 00 00 20 00 00 fc 20 00 00 ff 02 00 05
40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 01 00 00 00 80 00 00 00 00 00 00 00 00 01
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: d0 20 00 86 00 00 00 0c 00 00 00 00 00 d1 00 00
b0: cf 3f 3f 3f 20 10 08 0a 00 01 01 10 00 3f 02 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00

0000:01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 82) (prog-if 00 [VGA])
 	Subsystem: Toshiba America Info Systems: Unknown device 0001
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 8
 	Interrupt: pin A routed to IRQ 11
 	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
 	Region 1: Memory at fbc00000 (32-bit, non-prefetchable) [size=4M]
 	Region 2: Memory at f8000000 (32-bit, non-prefetchable) [size=32M]
 	Region 3: Memory at f7ff8000 (32-bit, non-prefetchable) [size=32K]
 	Expansion ROM at 28000000 [disabled] [size=64K]
 	Capabilities: [80] AGP version 2.0
 		Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 	Capabilities: [90] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 20 88 07 00 30 02 82 00 00 03 00 08 00 00
10: 00 00 00 fc 00 00 c0 fb 00 00 00 f8 00 80 ff f7
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 90 20 00 07 02 00 20 00 00 00 00 00 00 00 00
90: 01 00 22 06 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
 	Subsystem: Billionton Systems Inc LNR-100 Family 10/100 Base-TX Ethernet
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 64 (8000ns min, 16000ns max)
 	Interrupt: pin A routed to IRQ 11
 	Region 0: I/O ports at 1c00 [size=256]
 	Region 1: Memory at 26000000 (32-bit, non-prefetchable) [size=512]
 	Capabilities: [50] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 1c 00 00 00 00 00 26 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 01 00 00 cb 14 00 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 76 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



-- 
Meelis Roos (mroos@linux.ee)
