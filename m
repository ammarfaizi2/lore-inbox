Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSHGBMG>; Tue, 6 Aug 2002 21:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHGBMF>; Tue, 6 Aug 2002 21:12:05 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10768 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316614AbSHGBME>; Tue, 6 Aug 2002 21:12:04 -0400
Date: Tue, 6 Aug 2002 21:09:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <Pine.LNX.4.44L.0208060957220.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020806205643.9199C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Rik van Riel wrote:

> On Mon, 5 Aug 2002, Bill Davidsen wrote:
> 
> > > Here are some dbench numbers, from the "for what it's worth" department.
> >
> > Call me an optimist, but after all the reliability problems we had win the
> > 2.5 series, I sort of hoped it would be better in performance, not
> > increasingly worse. Am I misreading this? Can we fall back to the faster
> > 2.4 code :-(
> 
> Dbench is at its best when half (or more) of the dbench processes
> are stuck semi-infinitely in __get_request_wait and the others can
> operate in RAM without ever touching the disk.
> 
> In effect, if you want the best dbench throughput you should make
> the system completely unsuitable for real world applications ;)

I assumed that the posted results were apples and apples. That may not be
the case. If this was one kernel tuned for dbench and one for something
else, then the information content is pretty low, to me at least. But if
it is both tuned or both stock, then I would hope 2.5 would be better. If
the text said that and I read past it, I apologise.
 
> There are a few things that are good for both real world performance
> and dbench performance, but those are easily dwarved by random factors
> like IO scheduling, timeslice length, etc...

I confess to being a kernel junkie when I have the time, I have run into
the limitation of 19 boot stanzas in LILO :-( I have a case statement in
rc.local to tune -aa VM, stock, and -ac rmap a little differently, since
this machine is fairly fast and has bigish memory (2GB this week) and
getting several ISO images in RAM and then having bdflush kick them out is
bad. Looking forward to the io scheduler.

I like to see 2.4.19 vs. 2.5.{29+} both tuned and untuned, but I have no
days off in the next ten. By then there will be more new stuff, but the
fast machine will be several area codes away, perhaps one of the people
who like to do benchmarks might be too curious to wait.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

