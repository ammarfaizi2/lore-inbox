Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132926AbRASRrZ>; Fri, 19 Jan 2001 12:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbRASRrP>; Fri, 19 Jan 2001 12:47:15 -0500
Received: from [63.109.146.2] ([63.109.146.2]:33012 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S131921AbRASRrH>;
	Fri, 19 Jan 2001 12:47:07 -0500
Message-ID: <4461B4112BDB2A4FB5635DE1995874320223D6@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Bill Nottingham'" <notting@redhat.com>, linux-kernel@vger.kernel.org
Subject: RE: Is there a Crystal 4299 sound driver?
Date: Fri, 19 Jan 2001 09:47:00 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Nottingham said:

>Torrey Hoffman (torrey.hoffman@myrio.com) said: 
>> Does anyone know of a driver for the Crystal 4299 sound chip?
>
>It's not something there's one particular sound driver for (it's just
>an ac97 codec chip, as you saw). Most likely you want to use something
>like the i810_audio or via82cxxx_audio drivers. What does lspci say
>on your machine?

Here's an lspci -v dump.  The machine is a set top box, pretty much a
standard PC, but with hardware parts that are rarely seen in normal 
desktops.  (The graphics card, ethernet card, and MPEG decoder chip
all required non-standard Linux and X 4.0.2 drivers to work.)

--------------------------------------------------

00:00.0 Class 0600: 8086:7120 (rev 03)
	Flags: bus master, fast devsel, latency 0

00:1e.0 Class 0604: 8086:2418 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc000000-fdffffff

00:1f.0 Class 0601: 8086:2410 (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 Class 0101: 8086:2411 (rev 02) (prog-if 80 [Master])
	Subsystem: 8086:2411
	Flags: bus master, medium devsel, latency 0
	I/O ports at 1c00

00:1f.2 Class 0c03: 8086:2412 (rev 02)
	Subsystem: 8086:2412
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1400

00:1f.3 Class 0c05: 8086:2413 (rev 02)
	Subsystem: 8086:2413
	Flags: medium devsel, IRQ 5
	I/O ports at 1800

00:1f.5 Class 0401: 8086:2415 (rev 02)
	Subsystem: 110a:0051
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 1000
	I/O ports at 2000

01:06.0 Class 0300: 10ea:5000 (rev 03)
	Subsystem: 0280:7000
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable)
	I/O ports at 3000

01:07.0 Class 0200: 8086:1229 (rev 08)
	Subsystem: 8086:000c
	Flags: bus master, medium devsel, latency 66, IRQ 5
	Memory at fc300000 (32-bit, non-prefetchable)
	I/O ports at 3400
	Memory at fc000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

01:08.0 Class 0200: 100b:0020
	Subsystem: 110a:005b
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 3800
	Memory at fc301000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

01:09.0 Class 0480: 1105:8400 (rev 01)
	Subsystem: 1105:00ff
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fc100000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 1

01:0a.0 Class 0480: 1105:8400 (rev 01)
	Subsystem: 1105:00ff
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at fc200000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 1

--- end -----------------------------------

Torrey Hoffman
torrey.hoffman@myrio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
