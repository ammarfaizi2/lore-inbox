Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSFGRLC>; Fri, 7 Jun 2002 13:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317311AbSFGRLB>; Fri, 7 Jun 2002 13:11:01 -0400
Received: from ns.broadjump.com ([12.39.176.252]:12957 "EHLO macross")
	by vger.kernel.org with ESMTP id <S316475AbSFGRLA> convert rfc822-to-8bit;
	Fri, 7 Jun 2002 13:11:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Tyan S2464 (K7 SMP) + EMU10K1 hardlocks
Date: Fri, 7 Jun 2002 12:10:55 -0500
Message-ID: <97B71B827DFB2B448A73EC00E5DA0EE605E04A@logos.inhouse.broadjump.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Tyan S2464 (K7 SMP) + EMU10K1 hardlocks
thread-index: AcIORkj6h0bujzkGRnKSHHLm3OGjzw==
From: "Chris Fuller" <cfuller@broadjump.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've established by now that the problem is definitely not with the
Linux kernel, but there was a discussion here about this very issue last
August, and I haven't found a reference to it anywhere else, so please
help if you can. :)

I'm seeing hardlocks in various 2.4 kernels (10, 18, 19-pre8, all SMP):
  mobo=Tyan S2464 (K7 Thunderbird) SMP
  NVidia GeForce4 AGP
  SBLive! Platinum 5.1
  Two 40G IDE hard drives

I can reproduce at will (Unreal Tournament aggrivates it), but it can
happen at any time.  It even locked up in the BIOS Setup(!) at one
point.  Last August, Eric S. Raymond started these threads which seem to
be the same problem:
  Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
  S2464 (K7 Thunder) hangs -- some lessons learned

First trying the things I usually try to regain system stability, then
based on what I learned from the above threads, I have found that even
doing *all* of the following does not correct the issue for me:
  nosmp or pulled 2nd CPU
  ide=nodma
  disableapic or noapic
  apm=off
  additional cooling
  memory swap
  video card swap, both pci and agp, both 3dfx and nvidia
  "Use PCI Interrupt Entries in MP Table" -> "yes"
  No emu10k1 driver at all

Yanking the sound card completely out of the machine makes the hardlock
go away, but the card works flawlessly in my Abit K7 system.

Am I forgetting to try something?

Does anybody have any further advice on this?

Does anyone know if it's the motherboard or the card that's actually
doing something wrong, so I can know whom to yell at and/or avoid in the
future?

crf
