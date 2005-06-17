Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVFQSln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVFQSln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVFQSln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:41:43 -0400
Received: from mta1.lbl.gov ([128.3.41.24]:57826 "EHLO mta1.lbl.gov")
	by vger.kernel.org with ESMTP id S262051AbVFQSl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:41:28 -0400
Subject: system hangs with no warning or errors
From: Charles Leggett <CGLeggett@lbl.gov>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-70+82Tfg5UBHdHqkBVTQ"
Organization: Lawrence Berkeley National Laboratory
Date: Fri, 17 Jun 2005 11:40:17 -0700
Message-Id: <1119033617.4663.90.camel@annwm.lbl.gov>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-70+82Tfg5UBHdHqkBVTQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


I'm running a dual opteron, debian unstable based system, which hangs
at random intervals with no errors being written to any of the log=20
files. I'm currently using a 64 bit kernel 2.6.11-rc5, but I've seen
this behaviour with a series of kernels since 2.6.9. Sometimes the
system sometimes runs for several weeks between hangs, and sometimes
hangs twice in a day. When it hangs, the screen freezes, and is
completely unresponsive to all keyboard/mouse input, and will not
respond to pings over the network. It is not an X problem.

I was previously running CentOS with a 2.4.21 kenel for several months,
and experienced no problems, so I don't think it is a hardware problem.

I know that this is a very anemic bug report, I'm sorry I can't offer
any more information. Any suggestions for things to look for, what
to instrument to get more detailed information, or things to try are
welcome.

Below is a dump of lspci -v:

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev
07) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D=
64
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: ff200000-ff3fffff
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev
05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
        Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE
(rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0 [size=3D16]

0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev
02)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
        Flags: medium devsel, IRQ 9
        I/O ports at b400 [size=3D32]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
        Flags: medium devsel

0000:00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD]
AMD-8111 AC97 Audio (rev 03)
        Subsystem: Tyan Computer: Unknown device 2885
        Flags: bus master, medium devsel, latency 64, IRQ 177
        I/O ports at b800 [size=3D256]
        I/O ports at bc00 [size=3D64]

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
64
        Memory behind bridge: ff100000-ff1fffff
        Prefetchable memory behind bridge:
00000000de900000-00000000de900000
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev
01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
        Flags: bus master, medium devsel, latency 0
        Memory at ff4fe000 (64-bit, non-prefetchable) [size=3D4K]

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev
01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
        Flags: bus master, medium devsel, latency 0
        Memory at ff4ff000 (64-bit, non-prefetchable) [size=3D4K]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5703X Gigabit Ethernet (rev 02)
        Subsystem: Tyan Computer: Unknown device 2885
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 169
        Memory at ff1f0000 (64-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at ff1e0000 [disabled] [size=3D64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=3D0/3 Enable-

0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at ff3fd000 (32-bit, non-prefetchable) [size=3D4K]

0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at ff3fe000 (32-bit, non-prefetchable) [size=3D4K]

0000:03:0b.0 Unknown mass storage controller: Silicon Image, Inc.
(formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA
Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI
3114 [SATALink/SATARaid] Serial ATA Controller
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 177
        I/O ports at ac00 [size=3D8]
        I/O ports at a800 [size=3D4]
        I/O ports at a400 [size=3D8]
        I/O ports at a000 [size=3D4]
        I/O ports at 9c00 [size=3D16]
        Memory at ff3ffc00 (32-bit, non-prefetchable) [size=3D1K]
        Expansion ROM at ff300000 [disabled] [size=3D512K]
        Capabilities: [60] Power Management version 2

0000:03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Tyan Computer: Unknown device 2885
        Flags: bus master, medium devsel, latency 64, IRQ 185
        Memory at ff3ff000 (32-bit, non-prefetchable) [size=3D2K]
        Memory at ff3f8000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2

0000:04:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System
Controller (rev 13)
        Subsystem: Advanced Micro Devices [AMD] AMD-8151 System
Controller
        Flags: bus master, medium devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [a0] AGP version 3.0
        Capabilities: [c0] #08 [0060]

0000:04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP
Bridge (rev 13) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=3D04, secondary=3D05, subordinate=3D05, sec-latency=3D=
64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: deb00000-eeafffff

0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV280
[Radeon 9200] (rev 01) (prog-if 00 [VGA])
        Subsystem: Unknown device 17ee:2801
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
        Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
        I/O ports at c800 [size=3D256]
        Memory at ff5f0000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at ff5c0000 [disabled] [size=3D128K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2



---------------------------------------------------------------------------=
--

		thanks in advance, Charles Leggett

--=-70+82Tfg5UBHdHqkBVTQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCsxkRkeLSePHVp2IRAkn8AJ44KgHy+DowOAbMw8f/Yvc5ULTZFQCfUQ6j
0ZbH7Agqn0/fird1Qef/l2w=
=KA//
-----END PGP SIGNATURE-----

--=-70+82Tfg5UBHdHqkBVTQ--

