Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTEDWHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEDWHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 18:07:21 -0400
Received: from dnvrdslgw14poolC198.dnvr.uswest.net ([63.228.86.198]:37974 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id S261678AbTEDWHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 18:07:20 -0400
Date: Sun, 4 May 2003 16:19:34 -0600 (MDT)
From: Benson Chow <blc@q.dyndns.org>
To: "David J. M. Karlsen" <david@davidkarlsen.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: v4l bttv bt878 PCI on VIA KT133 chipset crashes?
In-Reply-To: <3EB58465.1070902@davidkarlsen.com>
Message-ID: <Pine.LNX.4.44.0305041615230.24101-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

I've subsequently found out that the via KT133 sucks, and there's not much
that can be done.

I replaced it with a (somewhat newer Via) P4X333 chipset motherboard
(difference CPU of course) and the driver works perfectly fine.

I've heard that the KT133 and a lot of via's older chipsets cannot handle
multiple busmasters on PCI transactions properly.  I suspect disabling DMA
on the harddrive may fix the problem, but I have not looked into this
possibility as I got the new machine.

Hope this enlightens...

-bc

On Sun, 4 May 2003, David J. M. Karlsen wrote:

> Date: Sun, 04 May 2003 23:21:41 +0200
> From: David J. M. Karlsen <david@davidkarlsen.com>
> To: Benson Chow <blc@q.dyndns.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: v4l bttv bt878 PCI on VIA KT133 chipset crashes?
>
> Benson Chow wrote:
> > Just wonderring.
> >
> > I'm getting weird crashes with running the bttv driver that comes with
> > 2.4.20 (0.7.96?) with a bt878 card.  I can record fine from it, can change
> > channels, etc. - Great.  Except if I keep on starting and stopping
> > mencoder (opening and closing /dev/video), it usually works for a few
> > times from a fresh reboot just fine, but after 5 times (and it's random,
> > it may not start till after 20 times) it *seems* other parts of kernel
> > space gets badly corrupted.  My kswapd oopses and dies.  Processes
> > cause oopses for no reason.  The oopses tend to occur in disk i/o
> > routines, not in the bttv driver for some reason, and after the corruption
> > (?) occurs, all processes can and will die.  The machine eventually goes
> > down hard needing a jab at the case  Not exactly a graceful shutdown!  The
> > machine seems to work fine if I never use the video capture card, even
> > thrashing disk and flooding the PCI network card seems to work fine.
> I had problems with 2.4.20 with the same hardware and using the program
> zapping for viewing. My box just froze. I thought maybe it was caused by
> sharing interrupts - but the machine hasn't frozen yet when I switched
> over to using xawtv instead.

[ system information deleted ]

WARNING: All HTML emails get deleted.  DO NOT SEND HTML MAIL.

