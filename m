Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSLBIsz>; Mon, 2 Dec 2002 03:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSLBIsy>; Mon, 2 Dec 2002 03:48:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265727AbSLBIsy>;
	Mon, 2 Dec 2002 03:48:54 -0500
Date: Mon, 2 Dec 2002 09:56:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
Message-ID: <20021202085610.GU16942@suse.de>
References: <200212012155.30534.m.c.p@wolk-project.de> <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com> <20021202081524.GQ16942@suse.de> <3DEB1F2C.E03517D7@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEB1F2C.E03517D7@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > On Sun, Dec 01 2002, Rik van Riel wrote:
> > > > So, here my patch proposal. Ontop of 2.4.20-rmap15a.
> > >
> > > Looks good, now lets test it.  If the patch is as needed as you
> > > say we should push it to marcelo ;)
> > 
> > Yes lets for heavens sake not fix the problem, merge the hack.
> 
> If it fails to find a merge or insert the current 2.4 elevator
> will stick a read at the far end of the request queue.  That's
> quite arbitrary, and is the worst possible thing to do with it.
> 
> read-latency2 will put the read a tunable distance from the head.
> Add a few embellishments to avoid permanent writer starvation,
> and that's basically all it does.

I just think that the design of the thing is ugly. It's clamped on to
the current elevator instead of redoing the core based on the principles
of read-starvation that it introduces (this is the only good thing that
has come out of the patch).

> So rather than just keeping on calling it a "hack" could you please
> describe what is actually wrong with the idea?

I've never said that the idea is wrong, it's the solution that is an
ugly hack.

-- 
Jens Axboe

