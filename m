Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130492AbRBWEHG>; Thu, 22 Feb 2001 23:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRBWEGr>; Thu, 22 Feb 2001 23:06:47 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:46341 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S131183AbRBWEGh>;
	Thu, 22 Feb 2001 23:06:37 -0500
Message-Id: <200102230406.VAA454821@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: Your article in linux.dev.kernel of Thu, 22 Feb 2001 19:40:03 PST.
In-Reply-To: <200102220719.AAA398825@ibg.colorado.edu> <000201c09d0c$d53a73c0$25040a0a@zeusinc.com> <200102230340.TAA19644@penguin.transmeta.com> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Thu, 22 Feb 2001 21:06:29 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Thu, 22 Feb 2001 19:40:03 PST, you write:
>Can you do a full "lspci -vvxxx" (as root) both on a working and a
>non-working setup, and send the two files to the kernel list and cc to
>me?

No problem, the listings are below.  Both listings were done on a
freshly booted system.  The only difference in system states was that
the i82365 modules had loaded.  The "broken" listing was done after a
power-off boot into 2.4.2, and the "working" listing was done after a
power-on boot to 2.4.2 from 2.2.17.  If any additional information
would be helpful, just ask.

------Working lspci -vvxxx in 2.4.2

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c 02 00 ff 00 00 00 09 03 10 11 11 00 10 13 11
60: 00 00 10 20 28 28 28 28 00 00 00 00 00 a0 00 00
70: 20 1f 0a 78 a0 01 07 01 26 1c dc 00 10 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 02 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 11 13 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c 80 01 18 00 00 00
d0: 00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00
e0: 4c ad ff bb 8a 3e 00 80 2c d3 f7 cf 9d 3e 00 00
f0: 40 01 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4000000-f40fffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 00 20 02 03 00 04 06 00 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 20 20 a0 22
20: 00 f4 00 f4 00 f8 f0 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
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

00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 68000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 00 00 68 a0 00 00 02 00 02 05 20 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 c0 07
40: c0 14 11 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 b0 44 20 00 00 00 00 00 00 00 00 02 1c 02 01
90: c0 82 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 11 00 00 00 0f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 68001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 10 00 68 a0 00 00 02 00 06 09 20 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 c0 07
40: c0 14 11 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 b0 44 20 00 00 00 00 00 00 00 00 02 1c 02 01
90: c0 82 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 11 00 00 00 0f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 f3 04
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 80 80 05 d0 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 06 00 01 70 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 25 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1080 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 a3 00 80 00 00 00 00 01 00 02 00 00 00 00 00
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
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1060 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 86 80 13 71 03 00 80 02 03 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 0f ff bf 2f 21 3a 00 00 00 10 00 02
50: 00 50 1d 00 c0 c1 ff 0f 57 80 00 02 00 00 00 80
60: 80 00 c0 62 00 00 00 98 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 01 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5d 12 78 19 01 00 90 02 10 00 01 04 00 40 00 00
10: 01 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 14 11 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18
40: 7f 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 c0 01 00 00 00 00 02 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 22 76 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x (rev 02) (prog-if 00 [VGA])
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 46 4c 87 02 b0 02 02 00 00 03 08 42 00 00
10: 08 00 00 f8 01 20 00 00 00 00 00 f4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 14 11 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 5c 20 00 03 02 00 1f 00 02 00 00 01 00 02 06
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

------Broken lspci -vvxxx in 2.4.2

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c 02 00 ff 00 00 00 09 03 10 11 11 00 10 13 11
60: 00 00 10 20 28 28 28 28 00 00 00 00 00 a0 00 00
70: 20 1f 0a 78 a0 01 07 01 26 1c dc 00 10 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 02 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 76 13 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c 80 01 18 00 00 00
d0: 00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00
e0: 4c ad ff bb 8a 3e 00 80 2c d3 f7 cf 9d 3e 00 00
f0: 40 01 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4000000-f40fffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 00 20 02 03 00 04 06 00 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 20 20 a0 22
20: 00 f4 00 f4 00 f8 f0 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
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

00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 13ff0000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 00 00 82 00
10: 00 00 ff 13 a0 00 00 02 00 02 05 20 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 c0 03
40: c0 14 11 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 20 00 00 00 00 00 00 00 00 02 1c 02 01
90: c0 82 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 10 00 00 00 0f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 13ff1000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 00 00 82 00
10: 00 10 ff 13 a0 00 00 02 00 06 09 20 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 c0 03
40: c0 14 11 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 20 00 00 00 00 00 00 00 00 02 1c 02 01
90: c0 82 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 10 00 00 00 0f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 f3 04
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 80 80 05 d0 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 06 00 01 70 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 25 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1080 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 a3 00 80 00 00 00 00 01 00 02 00 00 00 00 00
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
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1060 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 86 80 13 71 03 00 80 02 03 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 0f ff bf 2f 21 3a 00 00 00 10 00 02
50: 00 50 1d 00 c0 c1 ff 0f 57 80 00 02 00 00 00 80
60: 80 00 c0 62 00 00 00 98 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 01 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5d 12 78 19 01 00 90 02 10 00 01 04 00 40 00 00
10: 01 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 14 11 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18
40: 7f 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 c0 01 00 00 00 00 02 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 22 76 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x (rev 02) (prog-if 00 [VGA])
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 46 4c 87 02 b0 02 02 00 00 03 08 42 00 00
10: 08 00 00 f8 01 20 00 00 00 00 00 f4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 14 11 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 5c 20 00 03 02 00 1f 00 02 00 00 01 00 02 06
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

