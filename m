Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTIKQDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTIKQDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:03:33 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:12476 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261351AbTIKQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:01:45 -0400
X-Mailer: exmh version 2.5+CL 07/13/2001 with nmh-1.0.4
From: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>
X-emacs-edited: yes
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Omnibook PCMCIA slots unusable after suspend. 
In-reply-to: Your message of "Wed, 10 Sep 2003 23:45:38 BST."
             <20030910234538.S30046@flint.arm.linux.org.uk> 
X-Face: H#SM:U1U-/6#NN83s6?Die557~]Dfifz~-|V:wSKGL6T-|!qk{U4/M7+k5Py!-{q=2Q/%0@
        E29yc_kQC&^
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Thu, 11 Sep 2003 17:01:30 +0100
Message-ID: <23461.1063296090@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-09-10 at 23:45BST Russell King wrote:
> On Wed, Sep 10, 2003 at 10:22:32PM +0100, Jon Fairbairn wrote:
> > In short: I'm using an HP Ombibook 800CT, have started using
> > a Carbus PCMCIA network card and am losing the card after
> > suspends.
> 
> I'm only interested in the 2.6.0-test5 results.

OK. Pause for recompilation... 

> Please run lspci -vvb twice - once when you have just booted
> the machine, and once when you resume.

The following is done without unloading the modules round
the suspend.

Before:
------
00:00.0 Host bridge: VLSI Technology Inc 82C535 (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:01.0 PCI bridge: VLSI Technology Inc 82C534 [Eagle] (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00004000-00007fff
	Memory behind bridge: 20000000-2fffffff
	Prefetchable memory behind bridge: 30000000-3fffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset+ FastB2B-

00:02.0 Class ff00: VLSI Technology Inc 82C532 (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:03.0 VGA compatible controller: Neomagic Corporation NM2070 [MagicGraph 128] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at c0000000 (32-bit, prefetchable)

00:04.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 000e6000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00008000-000080ff
	I/O window 1: 00008400-000084ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at 000e7000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00008800-000088ff
	I/O window 1: 00008c00-00008cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:06.0 IRDA controller: VLSI Technology Inc 82C147 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1000 [disabled]

02:00.0 Ethernet controller: Linksys Fast Ethernet 10/100 (rev 11)
	Subsystem: Netgear FA511 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 8000
	Region 1: Memory at 10400000 (32-bit, non-prefetchable)
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

------
After:
------

00:00.0 Host bridge: VLSI Technology Inc 82C535 (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:01.0 PCI bridge: VLSI Technology Inc 82C534 [Eagle] (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00004000-00007fff
	Memory behind bridge: 20000000-2fffffff
	Prefetchable memory behind bridge: 30000000-3fffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset+ FastB2B-

00:02.0 Class ff00: VLSI Technology Inc 82C532 (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:03.0 VGA compatible controller: Neomagic Corporation NM2070 [MagicGraph 128] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at c0000000 (32-bit, prefetchable)

00:04.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 000e6000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00008000-000080ff
	I/O window 1: 00008400-000084ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at 000e7000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00008800-000088ff
	I/O window 1: 00008c00-00008cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:06.0 IRDA controller: VLSI Technology Inc 82C147 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1000 [disabled]

02:00.0 Class ffff: Linksys Fast Ethernet 10/100 (rev ff) (prog-if ff)
	!!! Unknown header type 7f

------

So there's a Reset- v a Reset+ there.

Curiously, the output after a suspend on mains is the same
(says diff) as the output after a suspend on battery, even
though the former doesn't stop it working while the latter
does.


> > ...
> > Sep  6 23:23:55 graffito kernel: Socket status: 2a035c8a
> 
> It looks like the cardbus controller configuration wasn't correctly
> restored.

Indeed, though it always seems to give the same dodgy looking
status.

> -- 
> Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
> Linux kernel maintainer of:
>   2.6 ARM Linux   - http://www.arm.linux.org.uk/

Wish I still had an ARM...
-- 
Jón Fairbairn


