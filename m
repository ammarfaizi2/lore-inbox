Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVAaDkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVAaDkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 22:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVAaDkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 22:40:25 -0500
Received: from [216.79.129.202] ([216.79.129.202]:1804 "EHLO
	se-1.us.steyla.com") by vger.kernel.org with ESMTP id S261904AbVAaDkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 22:40:07 -0500
Message-ID: <32794.216.79.129.222.1107146405.squirrel@www.steyla.com>
Date: Sun, 30 Jan 2005 23:40:05 -0500 (EST)
Subject: USB / PCMCIA not working/panic on AVERATEC 3500, second message
From: "Michaela Merz" <misch@steyla.com>
To: linux-kernel@vger.kernel.org
Reply-To: misch@steyla.com
User-Agent: SquirrelMail/1.4.0 RC2a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot the lspci output:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 741/741GX/M741 Host
(rev 03)
        Subsystem: Silicon Integrated Systems [SiS] 741/741GX/M741 Host
        Flags: bus master, medium devsel, latency 64
        Memory at f0000000 (32-bit, non-prefetchable) [size=32M]
        Capabilities: [c0] AGP version 3.5

00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 0003
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: e0000000-efffffff
        Prefetchable memory behind bridge: a0000000-afffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media
IO] (rev 25)
        Flags: bus master, medium devsel, latency 0

00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
        Flags: medium devsel, IRQ 11
        I/O ports at 1400 [disabled] [size=32]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE
Controller (A,B step)
        Flags: bus master, medium devsel, latency 128
        I/O ports at 1100 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller
(rev a0) (prog-if 00 [Generic])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 8170
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=128]
        Capabilities: [48] Power Management version 2

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 8140
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]
        Capabilities: [48] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Flags: medium devsel, IRQ 11
        Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 1e001000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
Controller (prog-if 20 [EHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 2.0 Controller
        Flags: medium devsel, IRQ 11
        Memory at 1e002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI
Fast Ethernet (rev 91)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 7
        I/O ports at e400 [size=256]
        Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

00:07.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus Reference
Card (rev 01)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 6833
        Flags: bus master, slow devsel, latency 64, IRQ 11
        Memory at f2002000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
        Subsystem: ENE Technology Inc CB1410 Cardbus Controller
        Flags: bus master, medium devsel, latency 168, IRQ 7
        Memory at 1e003000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 1e400000-1e7ff000 (prefetchable)
        Memory window 1: 1e800000-1ebff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP (prog-if 00 [VGA])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 8130
        Flags: 66Mhz, medium devsel, IRQ 10
        BIST result: 00
        Memory at a0000000 (32-bit, prefetchable) [size=128M]
        Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at c000 [size=128]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] AGP version 3.0



-- 
Steyla Technologies, Inc.
www.radiogermany.us
POT: +386-439-2286
FAX: +386-439-8521
FWD: 525452 (www.freeworlddialup.com)

