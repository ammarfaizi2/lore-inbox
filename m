Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTKYDMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTKYDMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:12:24 -0500
Received: from palrel10.hp.com ([156.153.255.245]:46824 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261988AbTKYDL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:11:58 -0500
Date: Mon, 24 Nov 2003 19:11:56 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Hinds <dhinds@sonic.net>, linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125031156.GA4243@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031124162628.A32213@sonic.net> <20031125004942.GA3002@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241804560.1599@home.osdl.org> <20031125023319.GA3819@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241845200.1599@home.osdl.org> <Pine.LNX.4.58.0311241851480.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311241851480.1599@home.osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 06:52:39PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 24 Nov 2003, Linus Torvalds wrote:
> >
> > Can you do a "dump_pirq"?
> 
> Oh, and a "lspci -vvxxx" as root too? Along with info on the machine?
> 
> 		Linus

	Don't waste too much time on that, it might be hopeless. I
personally don't believe that the kernel code will ever get it right,
so I'm really looking at adding some override for this specific
situation.

	Jean

---------------------------------------------------------------------
Interrupt routing table found at address 0xfdf30:
  Version 1.0, size 0x00b0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x8086 device 0x122e

Device 00:10.0 (slot 1): PCI bridge
  INTA: link 0x61, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTB: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTC: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTD: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Device 00:11.0 (slot 2): USB Controller
  INTA: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTB: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTC: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTD: link 0x61, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Device 00:12.0 (slot 3): Ethernet controller
  INTA: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTB: link 0x61, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTC: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTD: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Device 00:13.0 (slot 4): CardBus bridge
  INTA: link 0x61, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTB: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTC: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTD: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Device 00:00.0 (slot 0): Host bridge

Device 00:07.0 (slot 0): ISA bridge
  INTA: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTB: link 0x61, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTC: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTD: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Device 00:01.0 (slot 0): PCI bridge

Device 01:00.0 (slot 33): VGA compatible controller
  INTA: link 0x62, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]
  INTB: link 0x63, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Device 00:08.0 (slot 0): SCSI storage controller
  INTA: link 0x60, irq mask 0x5af8 [3,4,5,6,7,9,11,12,14]

Interrupt router at 00:07.0: Intel 82371AB PIIX4/PIIX4E PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 9
  PIRQ2 (link 0x61): irq 9
  PIRQ3 (link 0x62): irq 9
  PIRQ4 (link 0x63): irq 9
  Serial IRQ: [disabled] [quiet] [frame=21] [pulse=4]
  Level mask: 0x0200 [9]
---------------------------------------------------------------------
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 8c 01 00 fa 00 00 00 09 03 10 11 00 00 11 11 11
60: 10 10 20 20 20 20 20 20 00 03 68 01 a0 8a 00 00
70: 20 1f 0a 38 22 00 17 00 23 05 94 00 10 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 02 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 00 00 00 00 30 00 00 00 00 00 00 00 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c ff ff 61 00 00 00
d0: 00 00 00 00 00 00 00 80 0c 00 00 00 00 00 00 00
e0: d4 b6 ff e3 91 3e 00 80 2c d3 f7 cf 9d 3e 00 00
f0: 40 01 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-
if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: fe000000-febfffff
        Prefetchable memory behind bridge: f6000000-f6ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 00 20 02 03 00 04 06 00 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 f0 00 a0 22
20: 00 fe b0 fe 00 f6 f0 f6 00 00 00 00 00 00 00 00
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

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 10 71 0f 01 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 70 01
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 09 09 09 09 10 00 00 00 00 f2 80 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 45 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Maste
r])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcd0 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: d1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 a1 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI
])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at fce0 [disabled] [size=32]
00: 86 80 12 71 00 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00
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
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 14 00 00 02 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 81 21 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:08.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
        Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at f800 [disabled] [size=256]
        Region 1: Memory at fedff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 04 90 78 80 16 00 90 02 01 00 00 01 08 40 00 00
10: 01 f8 00 00 00 f0 df fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 04 90 80 78
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 08
40: a0 15 00 80 a0 15 00 80 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-i
f 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: fdf00000-fdffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3h
ot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
00: 11 10 24 00 07 00 90 02 03 00 04 06 08 40 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 44 71 71 80 22
20: f0 fd f0 fd f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 00
40: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 3e 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 01
e0: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fedfe000 (32-bit, non-prefetchable) [disabled] [size
=4K]
00: 45 10 61 c8 10 00 80 02 10 10 03 0c 08 40 00 00
10: 00 e0 df fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 10 61 c8
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 01 26 00 30 33 33 33 00 00 00 00 00 00 00 00
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

00:12.0 Ethernet controller: Hewlett-Packard Company J2585B
        Subsystem: Hewlett-Packard Company J2585B DeskDirect 10/100VG NIC
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at f400 [size=256]
        Region 1: Memory at fedfc000 (32-bit, non-prefetchable) [disabled] [size
=8K]
00: 3c 10 31 10 15 00 80 02 00 00 00 02 08 40 00 00
10: 01 f4 00 00 00 c0 df fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 41 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 08 20
40: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

00:13.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001
00: 80 11 75 04 07 00 10 02 80 00 07 06 00 a8 02 00
10: 00 00 00 10 dc 00 00 02 00 03 06 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 00 01 00 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 03 00 00 63 04 63 04 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 0a fe
e0: 00 40 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] A
GP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 2125
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=1 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 2b 10 01 10 87 00 90 02 01 00 00 03 00 40 00 00
10: 08 00 00 f6 00 80 bf fe 00 00 00 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 25 21
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 00 00
40: a9 91 07 40 08 3c 00 00 00 00 59 00 00 00 00 00
50: 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 f0 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 10 00 01 02 00 01 00 00 00 00 00 00 00 00

02:04.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c875
 (rev 26)
        Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (4250ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 7800 [size=256]
        Region 1: Memory at fdfff800 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=256K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 00 10 0f 00 17 00 10 02 26 00 00 01 08 40 00 00
10: 01 78 00 00 00 f8 ff fd 00 e0 ff fd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 11 40
40: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: c0 00 00 00 00 00 00 0f 00 00 05 00 80 00 08 02
90: 00 00 00 00 00 ff ff ff 00 f0 31 60 00 00 00 00
a0: 00 00 00 e2 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 81 70 0e 00 00 00 00 f7 00 00 00
d0: 01 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 23 73 50 10 79 cb 2c 1b 06 0b 21 41 7a 1b 66 cb
f0: 75 46 94 3c 9b ff e1 84 02 04 41 0b fa 76 fb f8

02:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (
rev 36)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote power Adapte
r
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (6000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 7ce0 [size=32]
        Region 1: Memory at fdfff400 (32-bit, non-prefetchable) [size=32]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA PME(D0+,D1+,D2+,D3h
ot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 22 10 00 20 07 00 90 02 36 00 00 02 00 40 00 00
10: e1 7c 00 00 00 f4 ff fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 6e 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 18 18
40: 01 00 11 ff 00 20 00 14 00 00 00 00 00 00 00 00
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

---------------------------------------------------------------------
