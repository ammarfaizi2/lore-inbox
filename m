Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSFXCd2>; Sun, 23 Jun 2002 22:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSFXCd2>; Sun, 23 Jun 2002 22:33:28 -0400
Received: from TK212017087078.teleweb.at ([212.17.87.78]:7111 "EHLO elch.elche")
	by vger.kernel.org with ESMTP id <S317232AbSFXCdP>;
	Sun, 23 Jun 2002 22:33:15 -0400
Date: Mon, 24 Jun 2002 04:19:45 +0200
From: Armin Obersteiner <armin@xos.net>
To: neomagic@XFree86.Org, vortex@scyld.com
Subject: Re: neomagic 256AV/3com 3c575_cb problem
Message-ID: <20020624041945.A30907@elch.elche>
References: <20020624041632.A30594@elch.elche>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20020624041632.A30594@elch.elche>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi!

sorry forgot lspci:
 
> this goes to both neomagic an vortex mailing list, because without starting X
> i don't have problems, but the problems are with then network card ...
> (and it worked, some releases back ...)
> 
> hardware: sony vaio F350, neomagic 256AV 2.5MB, 3com 575 pcmcia card
> software: linux 2.4.19-pre10/linux 2.4.18, pcmcia-cs-3.1.33/pcmcia-cs-3.1.34,
>           xfree86-4.2.0
> distibution: gentoo 1.2 (compiled *everything*)/suse 8.0
> (items seperated with / mean i tried it with BOTH versions)
> 
> problem: when i start x (X or X -probeonly) i get PCI errors with my network card (pcmcia)
>          it seems to be the fault of the pci probing, its possibly an irq conflict
> 
> question: can it be really the pci probing? can i disable the probing?
>           how to force the networkcard/gfx-chip to a certain irq?
> 
> info: 
>  * worked the last time with suse 7.3 (xfree86-4.0.2 or 4.1.0, pcmcia-3.1.29, linux 2.4.10)
>  * starting sound does not interfere in any way (neomagic 256 AV has sound too)
>  * it worked once, but i could not reproduce it (i beleive for once the networkcard
>    was not on irq9 (shared), which ist the irq of the neomagic)
>  * current start order: pcmcia, sound, network, X
>  
> attached: xfree86 config, /var/log/messges, XF86 start log, /proc/interrupts, dmesg

Ciao,
	Armin

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at <unassigned> (32-bit, prefetchable) [size=64M]

00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: medium devsel
	I/O ports at fcc0 [disabled] [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:08.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 20) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 8040
	Flags: medium devsel, IRQ 9
	Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
	Memory at fed00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

00:08.1 Multimedia audio controller: Neomagic Corporation [MagicMedia 256AV Audio] (rev 20)
	Subsystem: Sony Corporation: Unknown device 8041
	Flags: medium devsel, IRQ 9
	Memory at fe000000 (32-bit, prefetchable) [size=4M]
	Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

00:09.0 FireWire (IEEE 1394): Sony Corporation CXD1947Q i.LINK Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 8043
	Flags: medium devsel, IRQ 9
	Memory at fe7ffc00 (32-bit, non-prefetchable) [disabled] [size=512]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8042
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8042
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 60000000-60021000
	I/O window 0: 00000200-0000027f
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001


--17pEHd4RhPHOinZp--
