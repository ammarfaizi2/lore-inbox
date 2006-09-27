Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWI0RvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWI0RvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbWI0RvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:51:11 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:18876 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S1030497AbWI0RvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:51:09 -0400
Subject: forcedeth - WOL
From: Martin Filip <bugtraq@smoula.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SGb/Zido1EhQgGmEZcCz"
Date: Wed, 27 Sep 2006 19:50:41 +0200
Message-Id: <1159379441.9024.7.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SGb/Zido1EhQgGmEZcCz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi to LKML,

I'm experiencing some troubles with WOL with my nForce NIC.
The problem is simple - after setting WOL mode to magic packet my PC
won't wake up. I've noticed there were some changes about this in new
kernel, but no luck for me.

I'm using 2.6.18 kernel, vanilla. I've tried this with Windows Vista RC1
(build 5600) and WOL works correctly. My NIC is integrated on MSI K8N
Neo4-FI

Is there any way how can I help with developement of this feature?

 # lspci -v
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller
(rev a3)
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: 66MHz, fast devsel, IRQ 11
        I/O ports at fc00 [size=3D32]
        I/O ports at 4c00 [size=3D64]
        I/O ports at 4c40 [size=3D64]
        Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
(prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
        Memory at fe02f000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
(prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
        Memory at feb00000 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a
[Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at e000 [size=3D16]
        Capabilities: [44] Power Management version 2

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
(rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        I/O ports at 09f0 [size=3D8]
        I/O ports at 0bf0 [size=3D4]
        I/O ports at 0970 [size=3D8]
        I/O ports at 0b70 [size=3D4]
        I/O ports at cc00 [size=3D16]
        Memory at fe02b000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
(rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
        I/O ports at 09e0 [size=3D8]
        I/O ports at 0be0 [size=3D4]
        I/O ports at 0960 [size=3D8]
        I/O ports at 0b60 [size=3D4]
        I/O ports at b800 [size=3D16]
        Memory at fe02a000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
(prog-if 01 [Subtractive decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fde00000-fdefffff
        Prefetchable memory behind bridge: fdf00000-fdffffff

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: Micro-Star International Co., Ltd. Unknown device
7125
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        Memory at fe029000 (32-bit, non-prefetchable) [size=3D4K]
        I/O ports at b400 [size=3D8]
        Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fdd00000-fddfffff
        Prefetchable memory behind bridge:
00000000fdc00000-00000000fdc00000
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=3D0/1 Enable+
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D=
0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fdb00000-fdbfffff
        Prefetchable memory behind bridge:
00000000fda00000-00000000fda00000
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=3D0/1 Enable+
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D=
0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: fd900000-fd9fffff
        Prefetchable memory behind bridge:
00000000fd800000-00000000fd800000
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=3D0/1 Enable+
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D=
0
        I/O behind bridge: 00006000-00006fff
        Memory behind bridge: f4000000-fbffffff
        Prefetchable memory behind bridge:
00000000d0000000-00000000dff00000
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=3D0/1 Enable+
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Flags: fast devsel

01:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 32, IRQ 58
        I/O ports at ac00 [size=3D32]
        Capabilities: [dc] Power Management version 1

01:08.1 Input device controller: Creative Labs SB Live! Game Port (rev
06)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at a800 [size=3D8]
        Capabilities: [dc] Power Management version 1

05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce
6600] (rev a2) (prog-if 00 [VGA])
        Flags: bus master, fast devsel, latency 0, IRQ 58
        Memory at f4000000 (32-bit, non-prefetchable) [size=3D64M]
        Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
        Memory at fa000000 (64-bit, non-prefetchable) [size=3D16M]
        [virtual] Expansion ROM at f8000000 [disabled] [size=3D128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+
Queue=3D0/0 Enable-
        Capabilities: [78] Express Endpoint IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [128] Power Budgeting

--=20
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net
www: http://www.smoula.net

 _________________________________________=20
/ BOFH Excuse #230: Lusers learning curve \
\ appears to be fractal                   /
 -----------------------------------------=20
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

--=-SGb/Zido1EhQgGmEZcCz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Toto je =?UTF-8?Q?digit=C3=A1ln=C4=9B?=
	=?ISO-8859-1?Q?_podepsan=E1?= =?UTF-8?Q?_=C4=8D=C3=A1st?=
	=?ISO-8859-1?Q?_zpr=E1vy?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGrnxzvp9bBLJ9XMRApnKAJ9Ochk7Xk4bsL3+UOQEIydhWTkL6wCfdyou
eEPGFaaQh87J1TGOJksy7us=
=2TaD
-----END PGP SIGNATURE-----

--=-SGb/Zido1EhQgGmEZcCz--

