Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318669AbSHAIvt>; Thu, 1 Aug 2002 04:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318670AbSHAIvt>; Thu, 1 Aug 2002 04:51:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20352 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318669AbSHAIvs>;
	Thu, 1 Aug 2002 04:51:48 -0400
Date: Thu, 1 Aug 2002 10:51:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020801085152.GC1096@suse.de>
References: <20020726120248.GI14839@suse.de> <Pine.LNX.3.96.1020730132645.4849B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020730132645.4849B-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30 2002, Bill Davidsen wrote:
> On Fri, 26 Jul 2002, Jens Axboe wrote:
> > Finally, I've done some testing on it. No testing on whether this really
> > works well in real life (that's what I want testers to do), and no
> > testing on benchmark performance changes etc. What I have done is
> > beat-up testing, making sure it works without corrupting your data. I'm
> > fairly confident that does. Most testing was on SCSI (naturally),
> > however IDE has also been tested briefly.
> 
> First, great job on the explanation, it went right in my folder for "when
> the docs are clear" explanations.

Thanks :-)

> Now a request, if someone is running a database app and tests this I'd
> love to see the results. I expect things like LMbench to show more threads
> ending at the same time, but will it help a reall app?

Note that the deadline i/o scheduler only considers deadlines on
individual requests so far, so there's no real guarentee that process X,
Y, and Z will receive equal share of the bandwidth. This is something
I'm thinking about, though.

My testing does seem to indicate that the deadline scheduler is fairer
than the linus scheduler, but ymmv.

> I bet it was tested briefly on IDE, my last use of IDE a week or so ago
> lasted until I did "make dep" and the output went all over every attached
> drive :-( Still, nice to know it will work if IDE makes it into 2.5.

:/

I'll say that 2.5.29 IDE did work fine for the testing I did with the
deadline scheduler, at least it survived a dbench 64 (that's about the
testing it got).

-- 
Jens Axboe

