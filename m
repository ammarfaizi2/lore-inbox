Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281493AbRKHJ2v>; Thu, 8 Nov 2001 04:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281486AbRKHJ2l>; Thu, 8 Nov 2001 04:28:41 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:15327 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S281491AbRKHJ2g>;
	Thu, 8 Nov 2001 04:28:36 -0500
Date: Thu, 8 Nov 2001 09:28:08 +0000 (GMT)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: My 3c980 is misdetected
Message-ID: <Pine.LNX.4.21.0111080916480.20023-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More NIC-related queries,

Under the 2.4.13 kernel, the 3c59x.o driver misdetects my 3c980 as a 3c982
(the dual port version of what I assume is the same card):

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xdc00. Vers LK1.1.16

Here is the output of lspci -v:

00:09.0 Ethernet controller: 3Com Corporation: Unknown device 9805 (rev 78)
        Subsystem: 3Com Corporation: Unknown device 1000
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at dc00 [size=128]
        Memory at db000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

It all seems to work fine, but I was wondering if this might cause a
hiccup anywhere? 2.2.19 identified my card correctly, and I have some
earlier 3c980 models in another box still running 2.2.19, which get
detected correctly too:

00:0a.0 Class 0200: 10b7:9800
        Subsystem: 10b7:9800
        Flags: bus master, medium devsel, latency 32, IRQ 17
        I/O ports at d880
        Memory at efffaf80 (32-bit, non-prefetchable)
        Expansion ROM at effc0000 [disabled]
        Capabilities: [dc] Power Management version 1

Cheers

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy."

