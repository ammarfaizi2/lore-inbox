Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRAaNHE>; Wed, 31 Jan 2001 08:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAaNGz>; Wed, 31 Jan 2001 08:06:55 -0500
Received: from getafix.lostland.net ([216.29.29.27]:62216 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S129716AbRAaNGh>; Wed, 31 Jan 2001 08:06:37 -0500
Date: Wed, 31 Jan 2001 08:06:19 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Matthew Gabeler-Lee <msg2@po.cwru.edu>
cc: Prasanna P Subash <psubash@turbolinux.com>, John Jasen <jjasen1@umbc.edu>,
        <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.LNX.4.32.0101302104360.9417-100000@cheetah.STUDENT.cwru.edu>
Message-ID: <Pine.BSO.4.30.0101310728000.1103-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jan 2001, Matthew Gabeler-Lee wrote:

> On Tue, 30 Jan 2001, adrian wrote:
>
> >    I have a bt848 based video capture card, and get near the same results:
> > 2.4.0-test10 through 2.4.1 all lock when i2c registers the device.  The
> > card has its own interrupt.  With 2.2.18, the card initialized and the
> > kernel continued to boot.  Interesting.
>
> 2 questions:
> What card in particular do you have?
> What version of the bttv drivers were you using in 2.4.0-test10?
> It comes with 0.7.38; did you patch it to a higher version?
>
> --
> 	-Matt
>

The card is a video only capture that came with a camera (and has a
connector to power that camera next to the video connector).  Hauppauge is
silkscreened on the PCB, along with Axiom Design.  I didn't buy it, so all
I have to go off of is what's on the card.  So here's all of it.

Sticker on back: 58051 REV A 231383
On Bt chip: Bt848kpf video decoder 255 9637

As far as the bttv driver version, I've always used the ones that came
originally with that kernel version.

This is what lspci says:
00:0f.0 Multimedia video controller: Brooktree Corporation Bt848 (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 40 max, 64 set
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at eddfe000 (32-bit, prefetchable)

A cat of /proc/pci reports REV 17 instead of 11.

Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
