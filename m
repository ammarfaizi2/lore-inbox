Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBDLjm>; Sun, 4 Feb 2001 06:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBDLjc>; Sun, 4 Feb 2001 06:39:32 -0500
Received: from pD90403FC.dip.t-dialin.net ([217.4.3.252]:54544 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S129036AbRBDLjX>;
	Sun, 4 Feb 2001 06:39:23 -0500
Date: Sun, 4 Feb 2001 12:40:41 +0100
From: hjb@pro-linux.de
Message-Id: <200102041140.f14BefR18479@mandel.hjb.de>
To: chromi@cyberspace.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: d-link dfe-530 tx (bug-report)
In-Reply-To: <l03130328b6a2de0ec77b@[192.168.239.105]>
In-Reply-To: <l03130328b6a2de0ec77b@[192.168.239.105]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>This sounds every much like it's related to the problems we're having with
>the card not initialising on reboot from Windows.
>
>What's the bets we're looking at a new revision of the chip which VIA
>haven't (publically) released documentation for yet?  I'd say they're
>pretty high...

I had the same problem yesterday. I don't have any Windows crap in my
network, the affected machine hasn't rebooted in a week, and my card is
not new. There may be another problem.

via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 10 for device 00:0a.0
eth0: VIA VT3043 Rhine at 0xd800, 00:40:05:a4:3d:84, IRQ 10.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.

Kernel 2.4.1-pre9. I loaded the module like this:
insmod via-rhine options=28

00:0a.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev 06)
        Subsystem: Elecom Co Ltd: Unknown device 1420
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (29500ns min, 38000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800 [size=128]
        Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]

I wonder about the subsystem: Unknown device. It's the first time I see
this (lspci 2.1.8).

BTW why do I have to "strings /sbin/lspci" to find out its version?

Regards,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
