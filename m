Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264090AbRFYLfh>; Mon, 25 Jun 2001 07:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264288AbRFYLfR>; Mon, 25 Jun 2001 07:35:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27408 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264090AbRFYLfP>; Mon, 25 Jun 2001 07:35:15 -0400
Date: Mon, 25 Jun 2001 13:33:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, Jens Axboe <axboe@suse.de>,
        Mike Galbraith <mikeg@wen-online.de>,
        Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
Message-ID: <20010625133349.B21253@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca> <20010623012550.B415@pelks01.extern.uni-tuebingen.de> <01062307104500.00430@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <01062307104500.00430@starship>; from phillips@bonn-fries.net on Sat, Jun 23, 2001 at 07:10:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'd like that too, but what about sync writes?  As things stand now,
> > > > there is no option but to spin the disk back up.  To get around this
> > > > we'd have to change the basic behavior of the block device and
> > > > that's doable, but it's an entirely different proposition than the
> > > > little patch above.
> > >
> > > I don't care as much about sync writes. They don't seem to happen very
> > > often on my boxes.
> >
> > syslog and some editors are the most common users of sync writes. vim,
> > e.g., per default keeps fsync()ing its swapfile. Tweaking the configuration
> > of these apps, this can be prevented fairly easy though. Changing sync
> > semantics for this matter on the other hand seems pretty awkward to me. I'd
> > expect an application calling fsync() to have good reason for having its
> > data flushed to disk _now_, no matter what state the disk happens to be in.
> > If it hasn't, fix the app, not the kernel.
> 
> But apps shouldn't have to know about the special requirements of
> laptops.  

If app does fsync(), it hopefully knows what it is doing. [Random apps
should not really do sync even on normal systems -- it hurts
performance.]
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
