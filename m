Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbSJXRnE>; Thu, 24 Oct 2002 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265572AbSJXRnE>; Thu, 24 Oct 2002 13:43:04 -0400
Received: from mout0.freenet.de ([194.97.50.131]:7854 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S265571AbSJXRnA>;
	Thu, 24 Oct 2002 13:43:00 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Ongoing problems with sis900.c in 2.4.20pre11
Date: Thu, 24 Oct 2002 19:53:06 +0200
Organization: privat
Message-ID: <ap9c23$1cb$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1035481987 1419 192.168.1.3 (24 Oct 2002 17:53:07 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

though the new bug fix for Tx timeout from Mufasa Yang in Rev 1.08.06, the 
problem is not fixed at all. The problem appeares now not quite often as 
before.


I can find the following logentries in /var/log/messages:

Oct 24 19:40:25 susi kernel: eth0: Media Link Off
Oct 24 19:40:35 susi kernel: eth0: Media Link On 100mbps full-duplex
Oct 24 19:40:36 susi kernel: eth0: Media Link Off
Oct 24 19:40:46 susi kernel: eth0: Media Link On 100mbps full-duplex
Oct 24 19:40:47 susi kernel: eth0: Media Link Off
Oct 24 19:40:57 susi kernel: eth0: Media Link On 100mbps full-duplex
Oct 24 19:40:58 susi kernel: eth0: Media Link Off
Oct 24 19:41:07 susi kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 24 19:41:07 susi kernel: eth0: Transmit timeout, status 00000004 
00000000
Oct 24 19:41:08 susi kernel: eth0: Media Link On 100mbps full-duplex
Oct 24 19:41:09 susi kernel: eth0: Media Link Off
Oct 24 19:41:18 susi kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 24 19:41:18 susi kernel: eth0: Transmit timeout, status 00000004 
00000040
Oct 24 19:41:19 susi kernel: eth0: Media Link On 100mbps full-duplex
Oct 24 19:41:20 susi kernel: eth0: Media Link Off
Oct 24 19:41:30 susi kernel: eth0: Media Link On 100mbps full-duplex


The problem occures between two sis900-cards (see lspci). You can fix it by 
restarting the network on one of the two machines (including rmmod sis900).


00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP 
System Controller
        Flags: bus master, slow devsel, latency 64
        Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [b0] AGP version 1.0

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 
[Normal decode])
        Flags: bus master, slow devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4800000-e5ffffff
        Prefetchable memory behind bridge: e7f00000-e7ffffff

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management 
Controller
        Flags: medium devsel

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev c3)
        Flags: bus master, medium devsel, latency 0

00:0a.0 Multimedia audio controller: Xilinx, Inc. RME Digi96
        Flags: slow devsel, IRQ 12
        Memory at e3000000 (32-bit, non-prefetchable) [size=16M]

00:0b.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet 
Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b800 [size=256]
        Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 1

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b400 [size=16]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 11
        Memory at e5000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at d800 [size=256]
        Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e7fe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0


I would be very happy if this very old problem could be really fixed.


Regards,
Andreas Hartmann
