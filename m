Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTCEKKb>; Wed, 5 Mar 2003 05:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTCEKKb>; Wed, 5 Mar 2003 05:10:31 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:41107 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264984AbTCEKKa>; Wed, 5 Mar 2003 05:10:30 -0500
Date: Wed, 5 Mar 2003 10:20:57 +0000 (GMT)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@quaratino
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM / OOM troubles in 2.4.20-ck4 (-aa VM)
In-Reply-To: <200303051127.33140.kernel@kolivas.org>
Message-ID: <Pine.GSO.4.50.0303051018110.5801-100000@quaratino>
References: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino>
 <200303051127.33140.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Our dual Athlon server with 512Mb RAM / 1.2Gb swap, and not particularly
> > heavily loaded, lasted 81 days with 2.4.20-ck1 under RH8.0, and then
> > succumbed with these errors:
> >
> >   VM error: killing process wineserver
> >    _alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> >
> > This time, it only lasted _3 days_ with -ck4 before the same thing
> > happened.
>
> My first guess would be wine. There are all sorts of leaks in that.

It's actually CodeWeavers Wine if it makes any difference!

> I'm not aware of any memory leak / vm problems with -ck although that may be
> possible. However ck4 does not have the OOM killer enabled so it's not that
> in action; you simply have run out of memory and it can't allocate any more.
> Have you tried without the aa vm addons in ck? Does this happen with vanilla
> 2.4.20? -ck is a very different branch.

Thanks - I'm being a bit thick here, because everyone's right, it's
obviously a userspace problem. The machine is now running plain
2.4.21-pre5, so we'll see what happens....

PS - thanks for your work on -ck, Con! It runs beautifully on my home
machine, which isn't tortured by Wine ;-)

Cheers
Alastair                            .-=-.
__________________________________,'     `.
                                           \   www.mrc-bsu.cam.ac.uk
Alastair Stevens, Systems Management Team   \       01223 330383
MRC Biostatistics Unit, Cambridge UK         `=.......................
