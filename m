Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285453AbRLSUPK>; Wed, 19 Dec 2001 15:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285456AbRLSUPC>; Wed, 19 Dec 2001 15:15:02 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:51976 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285453AbRLSUOq>;
	Wed, 19 Dec 2001 15:14:46 -0500
Date: Mon, 10 Dec 2001 11:49:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: linux-kernel@vger.kernel.org, John Clemens <john@deater.net>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011210114936.A125@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org> <1007760235.10687.0.camel@localhost.localdomain> <20011209000451.A117@elf.ucw.cz> <1007928167.17061.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1007928167.17061.2.camel@localhost.localdomain>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > So I investigated a little more, and maestro3 soundcard is also hooked
> > at irq 11 -- with this *very* cruel hack it works for me (at least
> > playback).
> 
> What IRQ did the maestro think it was on previously? 

It thought it had 5. But it does not have 11, either :-(. But usb
interrupt is common enough so that sound just works.

> Could you send me a
> "lspci -vvvxxx" and "dump_pirq"? I'd like to compare it to mine.

I do not have dump_pirq handy.

lspci attached.
								Pavel

> I'd be curious to see if the last patch I posted (the "honor irq masks"
> patch) fixes one or both of your problems.

I'll take a look.

-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=delme

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 47 16 07 00 10 a2 04 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00
40: 11 2f 0f 03 1a 10 04 2f 00 20 04 00 00 20 20 00
50: 01 00 00 00 05 10 04 2f 00 20 00 00 00 20 20 ff
60: c1 4b 30 85 00 70 00 00 0c 70 72 d9 40 22 19 05
70: 8b 8b 8b 8b 00 00 00 00 40 c0 77 47 04 18 03 03
80: 31 07 53 b7 31 07 10 e1 00 01 00 00 00 00 00 00
90: 15 40 50 81 00 00 00 00 08 00 00 00 d0 ae 00 00
a0: 30 80 01 00 01 00 01 06 00 00 00 00 00 00 00 00
b0: 02 a4 20 00 13 02 00 1b 00 00 00 00 08 00 20 00
c0: 00 00 13 10 00 00 00 f0 80 68 00 c0 00 00 00 00
d0: 07 f0 45 ff 00 b1 6b 15 00 00 00 80 81 81 80 00
e0: 00 2c 23 b9 40 00 00 00 00 00 18 00 00 07 00 00
f0: 00 80 00 42 00 06 80 03 00 01 01 47 00 00 00 00

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ea100000-efffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: b9 10 47 52 1f 00 00 04 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
20: 10 ea f0 ef f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
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

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fff70000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 08 10 00 00
10: 00 00 f7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 1f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 04 a8 82 00
10: 00 00 00 10 a0 00 00 02 00 02 05 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: 3c 10 18 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 20 00 00 00 00 00 00 00 00 22 1b 9c 00
90: c0 83 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 14 08 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 04 a8 82 00
10: 00 10 00 10 a0 00 00 02 00 06 09 b0 00 00 c0 10
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 0b 01 c0 05
40: 3c 10 18 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 b0 44 20 00 00 00 00 00 00 00 00 22 1b 9c 00
90: c0 83 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 14 08 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 40 00 00 04 00 22 00 0a 7b 00 31 00 04 00 00
50: 00 02 00 00 3f 00 00 00 00 4f 01 40 00 00 00 00
60: 00 00 00 00 a5 00 00 00 00 00 00 ff 01 22 e0 0f
70: 01 81 00 00 00 2f 45 28 f7 77 00 00 f8 02 00 00
80: f6 63 0a 10 02 07 00 00 f7 00 00 20 00 00 00 00
90: 00 00 00 00 00 00 00 b2 47 00 b0 9c b0 04 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00
b0: 00 84 00 00 04 0a 03 00 60 14 00 00 00 00 00 00
c0: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 06 04 00 00 00 00 00 00 00 40 00 00 00 00 00
e0: 00 80 40 80 01 00 01 06 00 00 00 00 00 00 00 00
f0: 03 00 20 1e 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 13 08 ea 5d 02 00 03 99 00 00 00 00 00 cd 03
50: 00 00 00 00 02 00 02 01 5c 00 00 00 00 00 e0 f0
60: 42 31 00 00 00 00 00 00 00 00 00 00 05 64 25 00
70: d2 00 2b 00 09 1f 81 48 00 00 80 02 21 00 00 11
80: 07 00 33 01 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 06 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5d 12 88 19 05 00 90 02 12 00 01 04 00 40 80 00
10: 01 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 02 18
40: 7f 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 40 00 40 0a 00 00 00 00 00 01 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 22 76 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1800 [disabled] [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5d 12 89 19 00 00 90 02 12 00 80 07 00 00 80 00
10: 01 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00
40: 7f 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 40 00 40 0a 00 00 00 00 00 01 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 a2 f6 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c3 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 02 04
40: 06 00 00 7a 00 00 00 00 00 02 20 c1 00 00 ba 3a
50: 00 00 00 89 0a 00 08 00 00 31 31 00 00 31 31 00
60: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet Adapter (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 13 11 16 12 17 00 90 02 11 00 00 02 08 40 00 00
10: 01 1c 00 00 00 10 00 ea 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 42 22
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 ff ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 17 13 81 09 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/XP (rev 63) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at ea400000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at ec000000 (32-bit, non-prefetchable) [size=32M]
	Region 3: Memory at ea100000 (32-bit, non-prefetchable) [size=32K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 10 99 07 00 30 02 63 00 00 03 00 40 00 00
10: 00 00 00 ee 00 00 40 ea 00 00 00 ec 00 00 10 ea
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
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


--FL5UXtIhxfXey3p5--
