Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTD0JCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 05:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTD0JCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 05:02:45 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:46900 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262951AbTD0JCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 05:02:42 -0400
Subject: IRQ 0 for cardbus bridge on TP760XD - RH 8.0
From: Frederik Vanrenterghem <frederik.vanrenterghem@chello.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051434864.1003.16.camel@maui>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Apr 2003 11:14:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get my Level One WPC-0101 PCMCIA wireless network card to
work on a IBM Thinkpad 760XD. I've tried with Debian unstable, but have
now resorted to a standard install of Redhat 8.0, as that's the only
system that seems to be supported by Realtek. The kernel is 2.4.18-14.

Problem: the cardbus bridge doesn't get an IRQ assigned. According to
the output from the DOS utility that comes with Thinkpads, the IRQ for
the first bus should be 3, and for the second one it should be 9.
However, both seem to get assigned IRQ 0.

The output of lspci -vv -xxx -s devices is shown below. Does anyone know
what to do next? Is there a way to tell the PCMCIA modules which IRQ to
assign to the cardbus bridges, instead of trying to find it via the BIOS
or whatever way is being used standard?

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown
device 8180 (rev 20)
	Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8180
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 4000 [size=256]
	Region 1: Memory at 10400000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 80 81 03 00 90 02 20 00 00 02 00 00 00 00
10: 01 40 00 00 00 00 40 10 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 01 00 00 ec 10 80 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
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

00:02.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10812000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 12 ac 07 00 00 02 04 00 07 06 08 a8 82 00
10: 00 20 81 10 00 00 00 22 00 01 03 b0 00 00 00 10
20: 00 f0 3f 10 00 00 40 10 00 f0 7f 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 ff 01 80 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 20 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 82 72 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at 10811000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 12 ac 07 00 00 02 04 00 07 06 08 a8 82 00
10: 00 10 81 10 00 00 00 02 00 04 06 b0 00 00 c0 10
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 ff 02 c0 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 20 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 83 72 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-- 
Frederik Vanrenterghem <frederik.vanrenterghem@chello.be>

