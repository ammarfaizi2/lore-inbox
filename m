Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTDHJhV (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbTDHJhV (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:37:21 -0400
Received: from cibs9.sns.it ([192.167.206.29]:23558 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S261165AbTDHJhT (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:37:19 -0400
Date: Tue, 8 Apr 2003 11:48:55 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: reiserFS problem switching from 2.5.66/67 to 2.4.20
Message-ID: <Pine.LNX.4.43.0304081142480.8816-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
After running for a while kernel 2.5.66 and then for some hour 2.5.67
I rebboted my desktop with kernel 2.4.20.

during mount of reiserFS filesystem i GOT those messages:

Apr  8 11:40:07 Blackdeath kernel: transaction
Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 4
encountered, ignoring transaction
Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 11
encountered, ignoring transaction
Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 4
encountered, ignoring transaction
Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 4
encountered, ignoring transaction
Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 11
encountered, ignoring transaction

this is just a few, I got hundreds of them.

When I boot with kernel 2.5.67 those messages disapperar, and come back
with kernel 2.4.20.

The desktop is a Pentium 933Mhz 256KB cache with 512 MB RAM 133Mhz.
The Mother board has an i810 chipset.
I have two ATA disks connetected running at ATA66; a Maxtor 32049H2 as hda and a
WDC WD200BB-60CVB0 as hdc. TBQ is not enabled in kernel 2.5.66/67


BlackDeath:{root}:~>lspci -v
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
        I/O ports at 2000 [size=256]
        I/O ports at 2400 [size=64]

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management
NIC
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at 1000 [size=128]
        Memory at 40000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2


Hope this helps

Luigi

