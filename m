Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRIUJVU>; Fri, 21 Sep 2001 05:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272835AbRIUJVK>; Fri, 21 Sep 2001 05:21:10 -0400
Received: from zeus.eurotux.com ([194.38.142.74]:55448 "HELO zeus.eurotux.com")
	by vger.kernel.org with SMTP id <S272737AbRIUJVF>;
	Fri, 21 Sep 2001 05:21:05 -0400
Message-ID: <3BAB140E.3E42DF27@eurotux.com>
Date: Fri, 21 Sep 2001 10:18:54 +0000
From: Ricardo Manuel Oliveira <rmo@eurotux.com>
Organization: Eurotux =?iso-8859-1?Q?Inform=E1tica?=, SA
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intel 82815 VGA
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi everyone.

 Problem with i815EM chipset (in ASUS M1000 laptop series) -
the display blinks *VERY* frequently - seems to blink for
every disk access or so.
 I've tried the Intel XFCom XFree86 driver AND recompiling
the agpgart kernel module to no avail. Intel's kernel module
fails compilation on any 2.4.x kernel, missing MAP_NR
definition.

 Anyone gone through the same situation? Patches to agpgart,
available anywhere?


 lspci -v output:

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset
Host Bridge and Memory Controller Hub (rev 11)
        Subsystem: Asustek Computer, Inc.: Unknown device
1402
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f205]

00:02.0 VGA compatible controller: Intel Corporation 82815
CGC [Chipset Graphics Controller]  (rev 11) (prog-if 00
[VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device
1402
        Flags: bus master, 66Mhz, medium devsel, latency 0,
IRQ 11
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Memory at f7800000 (32-bit, non-prefetchable)
[size=512K]
        Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448
(rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f7000000-f77fffff
00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c
(rev 03)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device
244a (rev 03) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device
1402
        Flags: bus master, medium devsel, latency 0
        I/O ports at b800 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino
2) Chipset USB (Hub A) (rev 03) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device
1402
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b400 [size=32]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino
2) Chipset USB (Hub B) (rev 03) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device
1402
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b000 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation:
Unknown device 2445 (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device
1463
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]

00:1f.6 Modem: Intel Corporation: Unknown device 2446 (rev
03) (prog-if 00 [Generic])
        Subsystem: Asustek Computer, Inc.: Unknown device
1466
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]

01:07.0 CardBus bridge: Texas Instruments PCI4410 PC card
Cardbus Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device
1464
        Flags: bus master, medium devsel, latency 168, IRQ
11
        Memory at f7001000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=01, secondary=02, subordinate=02,
sec-latency=176
        Memory window 0: f7400000-f77ff000 (prefetchable)
        I/O window 0: 0000d000-0000d0ff
        I/O window 1: 0000d400-0000d4ff
        16-bit legacy interface ports at 0001

01:07.1 FireWire (IEEE 1394): Texas Instruments: Unknown
device 8017 (rev 02) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device
1467
        Flags: medium devsel, IRQ 9
        Memory at f7002000 (32-bit, non-prefetchable)
[disabled] [size=2K]
        Memory at f7004000 (32-bit, non-prefetchable)
[disabled] [size=16K]
        Capabilities: [44] Power Management version 1

01:08.0 Ethernet controller: Intel Corporation 82820 820
(Camino 2) Chipset Ethernet (rev 03)
        Subsystem: Intel Corporation: Unknown device 3013
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at f7000000 (32-bit, non-prefetchable)
[size=4K]
        I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 2


 Thanks
 Ricardo Oliveira.


----
Ricardo Manuel Oliveira
Eurotux Informática, SA
Tel: +351 253257395 // +351 919475934
Fax: +351 253257396
