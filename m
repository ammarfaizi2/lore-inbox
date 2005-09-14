Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVINRKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVINRKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVINRKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:10:23 -0400
Received: from mail.rktmb.org ([83.143.18.13]:19889 "EHLO mail.rktmb.org")
	by vger.kernel.org with ESMTP id S1751220AbVINRKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:10:22 -0400
Subject: Re: RTL8139, the final patch ?
From: Rakotomandimby Mihamina 
	<mihamina.rakotomandimby@etu.univ-orleans.fr>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, Nick Warne <nick@linicks.net>
In-Reply-To: <87pss8cf2z.fsf@devron.myhome.or.jp>
References: <200508202153.17837.nick@linicks.net>
	 <200508202317.46937.nick@linicks.net>  <87pss8cf2z.fsf@devron.myhome.or.jp>
Content-Type: multipart/mixed; boundary="=-z3FM2bMhauwtNKRP1SZb"
Date: Wed, 14 Sep 2005 19:16:07 +0200
Message-Id: <1126718168.2339.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z3FM2bMhauwtNKRP1SZb
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable


> Rakotomandimby, can you try attached patch?

I tried.=20

> It would solve the problem

No: (/var/log/message)

Sep 14 18:37:01 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 14 18:37:02 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 14 18:37:02 kernel: NETDEV WATCHDOG: eth0: transmit timed out

I still have to desactivate acpi to have network.

> And please send dmesg, lspci -vvvxxx, cat /proc/interrupts,=20

Attached.

> 8259A.pl,

root-localhost>>>>./8259A.pl
irq 0: 00, edge
irq 1: 00, edge
irq 2: 00, edge
irq 3: 00, edge
irq 4: 00, edge
irq 5: 00, edge
irq 6: 00, edge
irq 7: 00, edge
irq 8: 0c, edge
irq 9: 0c, edge
irq 10: 0c, level
irq 11: 0c, level
irq 12: 0c, edge
irq 13: 0c, edge
irq 14: 0c, edge
irq 15: 0c, edge

>  mptable.

What's that?
(Not found)

> In some cases, we may be able to add workaround. But we need to find
> the cause of problem before it.

Well, my computer is a notebook (CompaQ R4000), with a very restricted
set of settings in the BIOS. I cannot deactivate what Nick Warne told.
Desactivate acpi on a notebook is a bit frustrating :-)
The only solution would be to apply the patch.=20

I apologize for the delay, but now, if you suggest me a patch I will
apply it immediately.

--=20
Administration & Formation =E0 l'administration
de serveurs d=E9di=E9s:
http://www.google.fr/search?q=3Daspo+infogerance+serveur

--=-z3FM2bMhauwtNKRP1SZb
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
00: 02 10 50 59 06 00 20 22 00 00 00 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 42 20 04 00
50: 3c 10 85 30 00 00 00 00 00 00 00 00 00 00 00 00
60: b7 00 00 00 1f 7e 00 00 00 00 00 00 24 00 73 06
70: e0 08 00 00 00 00 00 00 a8 61 00 00 00 00 00 10
80: 3f 4b 00 01 94 10 00 03 20 00 00 00 12 21 00 10
90: 00 00 00 38 0c 8f 0c f0 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 08 a0 80 01 60 00 11 11 d0 00 00 00
d0: 25 05 25 00 02 00 00 00 00 00 00 00 00 00 00 00
e0: 10 00 00 00 03 0a 17 80 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 80 80 00 00 00 00 00 00 00 48 01

00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: b0100000-b01fffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
	Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [44] HyperTransport: MSI Mapping
	Capabilities: [b0] #0d [0000]
00: 02 10 3f 5a 07 00 30 02 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 91 91 20 22
20: 10 b0 10 b0 01 c0 f1 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 0c 00
40: 00 00 00 00 08 b0 03 a8 00 00 00 00 3c 10 85 30
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d 00 00 00 3c 10 85 30 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 PCI bridge: ATI Technologies Inc: Unknown device 5a36 (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Root Port (Slot-) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 247
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [b0] #0d [0000]
	Capabilities: [b8] HyperTransport: MSI Mapping
00: 02 10 36 5a 04 00 10 00 00 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 01 01 00 00
20: 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 04 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 80 41 00 20 00 00 00
60: 10 08 00 00 11 0c 00 f7 00 00 01 11 00 00 00 00
70: c0 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 b0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d b8 00 00 02 10 50 59 08 00 03 a8 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4374 (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc: Unknown device 4374
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
00: 02 10 74 43 17 00 b0 02 00 10 03 0c 10 40 80 00
10: 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 74 43
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0b 01 00 00
40: 80 ff 00 00 00 00 00 00 00 00 00 00 10 00 00 00
50: 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4375 (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc: Unknown device 4375
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
00: 02 10 75 43 17 00 b0 02 00 10 03 0c 10 40 00 00
10: 00 10 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 75 43
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0b 01 00 00
40: 80 ff 00 00 00 00 00 00 00 00 00 00 10 00 00 00
50: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4373 (prog-if 20 [EHCI])
	Subsystem: ATI Technologies Inc: Unknown device 4373
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
00: 02 10 73 43 17 00 b0 02 00 20 03 0c 10 40 00 00
10: 00 20 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 73 43
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 00 00
40: 80 ff 00 00 00 00 00 00 00 00 00 00 10 00 00 00
50: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 00 00 00 20 00 00 00 20 00 00 00 20 00 00
70: 00 20 00 00 00 20 00 00 00 20 00 00 00 20 00 00
80: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 05 00 00 00 00 00 00 00 00 00 00 00 01 d0 02 7e
e0: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: I/O ports at 8400 [size=16]
	Region 1: Memory at b0003000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [b0] HyperTransport: MSI Mapping
00: 02 10 72 43 03 00 30 02 10 00 05 0c 00 00 80 00
10: 01 84 00 00 00 30 00 b0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00
40: d0 b3 00 00 00 00 00 00 0f ff 00 00 00 00 00 00
50: ff 03 00 00 ff 01 00 00 00 00 00 00 00 00 00 00
60: 01 00 04 00 bf b9 de 8f 00 90 00 00 20 00 00 00
70: 00 00 00 00 08 00 c0 fe ff 4f 00 00 00 00 00 00
80: 0f 01 00 00 00 00 00 00 00 00 00 00 8c 00 00 80
90: 01 84 00 00 fb de ff 00 00 00 00 00 00 00 00 00
a0: 00 00 ff ff ff ff 00 00 00 0f 03 00 d0 6a 00 6d
b0: 08 00 02 a8 00 00 00 00 00 00 00 00 f0 0f 00 00
c0: 12 24 49 12 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: d8 0c 00 00 7f 08 00 00 00 00 00 00 00 00 00 00

00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI (prog-if 8a [Master SecP PriP])
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 8410 [size=16]
	Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
00: 02 10 76 43 05 00 30 02 00 8a 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 11 84 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 70 00 00 00 00 00 00 00 ff 01 00 00
40: 99 20 20 20 ff 20 20 20 00 00 74 74 00 00 00 00
50: 00 00 00 00 01 00 05 00 00 00 00 00 00 00 00 00
60: 00 00 40 01 10 2c 46 18 01 00 00 00 ff ff 0f 00
70: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 02 10 77 43 0f 00 20 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 04 00 00 00 ff ff ff ff 87 ff 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 20 e0 00 00 0e 00 0f 00 f8 ff ff ff
70: 67 45 23 01 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 03 a8 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4371 (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=64
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: b0200000-b02fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
00: 02 10 71 43 07 00 a0 02 00 01 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 00 03 04 40 a1 a1 80 22
20: 20 b0 20 b0 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 26 00 3c ff 00 00 00 00 00 03 21 f0 00 00 00 00
50: 01 00 00 00 08 00 03 a8 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 06
e0: 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown device 4370 (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min), Cache Line Size 08
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at b0003400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
00: 02 10 70 43 17 00 30 04 01 00 01 04 08 40 80 00
10: 00 34 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 02 00
40: 05 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
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

00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 01) (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at b0003800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
00: 02 10 78 43 13 00 30 04 01 00 03 07 08 40 80 00
10: 00 38 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 02 00
40: 05 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
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

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 00 00 e4 00 00 00 0f cc 20 0f 1c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 05 35 80 02 00 00 00
90: 78 01 70 01 00 00 ff 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 3f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 03 00 d0 00 00 f8 ff 00 03 00 c0 00 80 ff cf 00
b0: 03 0a 00 00 00 0b 00 00 03 00 40 00 00 ff bf 00
c0: 00 00 00 00 00 00 00 00 13 10 00 00 00 f0 0f 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 30 02 ec 7f 10 00 b8 7f 74 02 fd fb
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 01 00 00 01 01 00 00 02 01 00 00 03
50: 00 00 20 00 00 00 20 00 00 00 20 00 00 00 20 00
60: 00 fe e0 00 00 fe e0 00 00 fe e0 00 00 fe e0 00
70: 00 00 20 00 00 00 20 00 00 00 20 00 00 00 20 00
80: 44 00 00 00 00 00 00 00 35 33 72 13 30 0a 00 00
90: 00 ce 0c 0e 06 08 5b 0e 00 00 00 00 f0 0f 01 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 9d 22 4c 66 11 00 00 00 3c 09 00 00 19 02 15 00
c0: 00 80 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: b9 d2 eb bf 8d aa 1e 57 59 40 7f 6b 54 b6 d7 df
e0: 4f ea ff fc 95 4e 9f 6e 92 f2 3a 3f 52 2d d3 26
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 00 00 02 00 00 00 00 00 00 00 00
50: 40 14 84 66 49 00 00 00 00 00 00 00 c0 ff 7b af
60: 5b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 32 51 21 40 70 50 00 2a 00 08 18 21 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 00 00 00 00 c6 43 00 00 f0 02 3d 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 02 07 0d 00 00 00 00 00 25 25 25 00
e0: 00 00 00 00 20 11 60 14 19 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5955 (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at b0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 55 59 07 02 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 c0 01 90 00 00 00 00 10 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
50: 01 00 02 06 00 00 00 00 02 50 20 00 30 02 00 4f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 12fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at b0200000 (32-bit, non-prefetchable) [size=8K]
00: e4 14 20 43 06 00 00 00 03 00 80 02 00 40 00 00
10: 00 00 20 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 fa 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00
40: 01 00 c2 07 00 40 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 10 00 18 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:04.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 20
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at b0202000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
	Memory window 0: 40000000-403ff000 (prefetchable)
	Memory window 1: 40400000-407ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 56 ac 07 00 10 02 00 00 07 06 20 a8 02 00
10: 00 20 20 b0 a0 00 00 02 03 04 07 b0 00 00 00 40
20: 00 f0 3f 40 00 00 40 40 00 f0 7f 40 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0a 01 c0 05
40: 3c 10 85 30 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 d0 c0 08 00 00 00 00 00 00 00 00 02 1c c0 01
90: c0 00 44 40 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 12 fe 00 00 c0 00 05 00 00 00 0f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 3085
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at b0203000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 82 10 00 00 02 00 40 00 00
10: 01 a0 00 00 00 30 20 b0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 85 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40
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


--=-z3FM2bMhauwtNKRP1SZb
Content-Disposition: attachment; filename=interrupts.txt
Content-Type: text/plain; name=interrupts.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

           CPU0       
  0:     750548          XT-PIC  timer
  1:         11          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 10:       6126          XT-PIC  yenta, eth0
 11:       6141          XT-PIC  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
 12:        207          XT-PIC  i8042
 14:      66687          XT-PIC  ide0
 15:       6266          XT-PIC  ide1
NMI:          0 
ERR:          7

--=-z3FM2bMhauwtNKRP1SZb
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.12-1.1450_FC4.mihamina (mihamina@fctmp) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 Wed Sep 14 15:32:02 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037ef0000 (usable)
 BIOS-e820: 0000000037ef0000 - 0000000037eff000 (ACPI data)
 BIOS-e820: 0000000037eff000 - 0000000037f00000 (ACPI NVS)
 BIOS-e820: 0000000037f00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
894MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 229104
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225008 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7df0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x37ef9532
ACPI: FADT (v001 HP     Piranha  0x06040000 ATI  0x000f4240) @ 0x37efee48
ACPI: MCFG (v001 ATI    Piranha  0x06040000 LOHR 0x0000005f) @ 0x37efeebc
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x37efeef8
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x37efefa6
ACPI: DSDT (v001     HP     3085 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/  rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=c0458000 soft=c0457000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1795.384 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 902952k/916416k available (2516k kernel code, 12892k reserved, 692k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3538.94 BogoMIPS (lpj=1769472)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 128K (64 bytes/line)
CPU: After all inits, caps: 078bf3ff e3d3fbff 00000000 00000010 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Sempron(tm) Processor 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c00)
checking if image is initramfs... it is
Freeing initrd memory: 1082k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd84c, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10 11), disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 26)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB4_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
    ACPI-0362: *** Error: Looking up [\_SB_.PCI0.LPC0.LNK4] in namespace, AE_NOT_FOUND
search_node c17ddfa0 start_node c17ddfa0 return_node 00000000
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.P2P_._PRT] (Node c17ddfa0), AE_NOT_FOUND
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
spurious 8259A interrupt: IRQ7.
pnp: 00:07: ioport range 0x1080-0x1080 has been reserved
pnp: 00:07: ioport range 0x220-0x22f has been reserved
pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1126724357.189:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key C4A74D4C4DA9A86E
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: 0000:00:04.0 has unsupported PM cap regs version (3)
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[5a36:1002] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (41 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:14.6 disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8410-0x8417, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8418-0x841f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS424040M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-L532R, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1739KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
 LID KBC0 MSE0  PB4  P2P ELAN 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 184k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x23a0b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
floppy0: no floppy controllers found
8139too Fast Ethernet driver (Disable NAPI) 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:03:06.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xa000, 00:0f:b0:6e:d6:67, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_timer_new
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_timer_new
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
snd_atiixp: Unknown symbol snd_ac97_pcm_close
snd_atiixp: Unknown symbol snd_ac97_resume
snd_atiixp: Unknown symbol snd_pcm_new
snd_atiixp: Unknown symbol snd_pcm_limit_hw_rates
snd_atiixp: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_atiixp: Unknown symbol snd_ac97_pcm_open
snd_atiixp: Unknown symbol snd_pcm_stop
snd_atiixp: Unknown symbol snd_pcm_format_physical_width
snd_atiixp: Unknown symbol snd_ac97_update_bits
snd_atiixp: Unknown symbol snd_ac97_mixer
snd_atiixp: Unknown symbol snd_ac97_bus
snd_atiixp: Unknown symbol snd_ac97_suspend
snd_atiixp: Unknown symbol snd_pcm_lib_malloc_pages
snd_atiixp: Unknown symbol snd_pcm_lib_ioctl
snd_atiixp: Unknown symbol snd_pcm_lib_free_pages
snd_atiixp: Unknown symbol snd_pcm_set_ops
snd_atiixp: Unknown symbol snd_ac97_get_short_name
snd_atiixp: Unknown symbol snd_pcm_suspend_all
snd_atiixp: Unknown symbol snd_ac97_pcm_assign
snd_atiixp: Unknown symbol snd_pcm_hw_constraint_integer
snd_atiixp: Unknown symbol snd_pcm_period_elapsed
snd_atiixp: Unknown symbol snd_pcm_hw_constraint_step
snd_atiixp: Unknown symbol snd_ac97_tune_hardware
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_timer_new
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_timer_new
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
snd_atiixp: Unknown symbol snd_ac97_pcm_close
snd_atiixp: Unknown symbol snd_ac97_resume
snd_atiixp: Unknown symbol snd_pcm_new
snd_atiixp: Unknown symbol snd_pcm_limit_hw_rates
snd_atiixp: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_atiixp: Unknown symbol snd_ac97_pcm_open
snd_atiixp: Unknown symbol snd_pcm_stop
snd_atiixp: Unknown symbol snd_pcm_format_physical_width
snd_atiixp: Unknown symbol snd_ac97_update_bits
snd_atiixp: Unknown symbol snd_ac97_mixer
snd_atiixp: Unknown symbol snd_ac97_bus
snd_atiixp: Unknown symbol snd_ac97_suspend
snd_atiixp: Unknown symbol snd_pcm_lib_malloc_pages
snd_atiixp: Unknown symbol snd_pcm_lib_ioctl
snd_atiixp: Unknown symbol snd_pcm_lib_free_pages
snd_atiixp: Unknown symbol snd_pcm_set_ops
snd_atiixp: Unknown symbol snd_ac97_get_short_name
snd_atiixp: Unknown symbol snd_pcm_suspend_all
snd_atiixp: Unknown symbol snd_ac97_pcm_assign
snd_atiixp: Unknown symbol snd_pcm_hw_constraint_integer
snd_atiixp: Unknown symbol snd_pcm_period_elapsed
snd_atiixp: Unknown symbol snd_pcm_hw_constraint_step
snd_atiixp: Unknown symbol snd_ac97_tune_hardware
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 11, io mem 0xb0002000
ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 11, io mem 0xb0000000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 11, io mem 0xb0001000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt 0000:03:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:03:04.0 [103c:3085]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:04.0, mfunc 0x01c01c02, devctl 0x44
Yenta TI: socket 0000:03:04.0 probing PCI interrupt failed, trying to fix
usb 2-3: new low speed USB device using ohci_hcd and address 2
Yenta TI: socket 0000:03:04.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x04f8, PCI irq 0
Socket status: 30000007
input: USB HID v1.11 Keyboard [C&C Technology Inc. HID Keyboard/Mouse PS/2 to USB Translator] on usb-0000:00:13.0-3
input: USB HID v1.11 Mouse [C&C Technology Inc. HID Keyboard/Mouse PS/2 to USB Translator] on usb-0000:00:13.0-3
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03e6a40(lo)
IPv6 over IPv4 tunneling driver
ACPI: AC Adapter [ACAD] (on-line)
Using generic hotkey driver
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: Using generic hotkey driver
toshiba_acpi: Using generic hotkey driver
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
EXT3 FS on hda7, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2096440k swap on /dev/hda5.  Priority:-1 extents:1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a05a. (queue head)
eth0:  Tx descriptor 1 is 0008a156.
eth0:  Tx descriptor 2 is 0008a04e.
eth0:  Tx descriptor 3 is 0008a046.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a156. (queue head)
eth0:  Tx descriptor 1 is 0008a046.
eth0:  Tx descriptor 2 is 0008a156.
eth0:  Tx descriptor 3 is 0008a046.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a156. (queue head)
eth0:  Tx descriptor 1 is 0008a156.
eth0:  Tx descriptor 2 is 0008a156.
eth0:  Tx descriptor 3 is 0008a156.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
i2c /dev entries driver
lp: driver loaded but no devices found

--=-z3FM2bMhauwtNKRP1SZb--

