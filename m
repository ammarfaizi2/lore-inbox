Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbTCZNc4>; Wed, 26 Mar 2003 08:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbTCZNc4>; Wed, 26 Mar 2003 08:32:56 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:37926 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S261684AbTCZNcy> convert rfc822-to-8bit; Wed, 26 Mar 2003 08:32:54 -0500
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.66 double display
Date: Wed, 26 Mar 2003 14:47:06 +0100
User-Agent: KMail/1.5
References: <200303260012.51560.dreher@math.tu-freiberg.de>
In-Reply-To: <200303260012.51560.dreher@math.tu-freiberg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261447.06889.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mittwoch, 26. März 2003 00:12 wrote Michael Dreher:
> Hello all,
>
> I tried 2.5.66 now, and X is unusable. Everything is displayed twice.
> There is a vertical split in the middle, and the right half is
> identical to the left half. For instance, I have two half
> login prompts of kdm. I attach my .config.
>
> Will try 2.5.65 next.

I tried, and 2.5.65 is fine.


> /sbin/lspci -v gives
>
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
>         Subsystem: VIA Technologies, Inc. VT8367 [KT266]
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Memory at e0000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [a0] AGP version 2.0
>         Capabilities: [c0] Power Management version 2
>
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if
> 00 [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000c000-0000cfff
>         Memory behind bridge: e8000000-e80fffff
>         Prefetchable memory behind bridge: e4000000-e7ffffff
>         Capabilities: [80] Power Management version 2
>
> 00:06.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:06.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 5
>         I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:06.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104
> (rev 51) (prog-if 20)
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 7
>         Memory at e8111000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [80] Power Management version 2
>
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
> (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at d800 [size=256]
>         Memory at e8110000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [50] Power Management version 2
>
> 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
>         Subsystem: VIA Technologies, Inc.: Unknown device 3147
>         Flags: bus master, stepping, medium devsel, latency 0
>         Capabilities: [c0] Power Management version 2
>
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc. Bus Master IDE
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         I/O ports at dc00 [size=16]
>         Capabilities: [c0] Power Management version 2
>
> 00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 7
>         I/O ports at e000 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 7
>         I/O ports at e400 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
> Controller (rev 40)
>         Subsystem: AOPEN Inc.: Unknown device 01ae
>         Flags: medium devsel, IRQ 5
>         I/O ports at e800 [size=256]
>         Capabilities: [c0] Power Management version 2
>
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro
> TF (prog-if 00 [VGA])
>         Subsystem: Unknown device 1787:0100
>         Flags: bus master, stepping, 66Mhz, medium devsel, latency 32,
> IRQ 11
>         Memory at e4000000 (32-bit, prefetchable) [size=64M]
>         I/O ports at c000 [size=256]
>         Memory at e8020000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [50] AGP version 2.0
>         Capabilities: [5c] Power Management version 2

-- 
----------------------------------------------------------------------
Michael Dreher
Fakultät für Mathematik und Informatik
TU Bergakademie Freiberg, Agricolastraße 1, 09596 Freiberg
Fon: ++49-3731-393493  ++49-3731-200643  ++49-163-4756064
Fax: ++49-3731-393442
http://michael-dreher.gmxhome.de
----------------------------------------------------------------------

