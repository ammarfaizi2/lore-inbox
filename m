Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTE1JaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTE1JaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:30:24 -0400
Received: from cibs9.sns.it ([192.167.206.29]:61964 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263987AbTE1JaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:30:22 -0400
Date: Wed, 28 May 2003 11:43:36 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: strange clock fastness with 2.5.70 and chipset i810
Message-ID: <Pine.LNX.4.43.0305281127330.14588-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I just upgraded on a test pc to kernel 2.5.70.
with this kernel the system clock has become e lot faster (the
same happens with 2.5.69 too), so what the system thinks to be a second,
is more or le 0,6 real seconds.

setting HZ to 100 slows down a little, so a system second is almost 0,8 real
seconds.

going back to 2.5.66 or 2.4.20 solves the problem.

please note that I am testing 2.5.70 also on Serverworks chipset on SMP and
on VIA 686a and AMD chipsets, but just on i810 I have this problem.

server is a PIII 933Mhz 256KB chache, 512MB RAM 133Mhz
chipset is an i810:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 0034
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 16
        Memory at 44000000 (32-bit, prefetchable) [size=64M]
        Memory at 40300000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 40000000-402fffff

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corp. 82801AA IDE
        Flags: bus master, medium devsel, latency 0
        I/O ports at 2460 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801AA USB
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at 2440 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device b1bf
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 2000 [size=256]
        I/O ports at 2400 [size=64]


kernel is 2.5.70 compiled with gcc 3.3 and binutils 2.14.90.0.2,
2.5.69 was compiled with gcc 3.2.3 but the problem was present anyway.

hope this helps

Luigi

