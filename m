Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSEYRg2>; Sat, 25 May 2002 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSEYRgW>; Sat, 25 May 2002 13:36:22 -0400
Received: from waste.org ([209.173.204.2]:12416 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S314657AbSEYRgT>;
	Sat, 25 May 2002 13:36:19 -0400
Date: Sat, 25 May 2002 12:34:29 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: Karim Yaghmour <karim@opersys.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020524220002.C22643@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0205251147450.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Larry McVoy wrote:

> On Sat, May 25, 2002 at 12:48:00AM -0400, Karim Yaghmour wrote:
> > "Anything which is not part of the patent's claims is not covered by
> > the patent, and can be done by anyone anywhere anytime, without regard
> > to the patent."
>
> Sure. As long as it does not depend on the patent to work.  I don't care
> if Victor says that you have to love your mother in order to license his
> patent.  If that's what he says, those are the terms.  You are *paying*
> for the right to use the patent.  His terms are that you are 100% GPL
> all the way through.  OK, so deal with that.
>
> Eben is absolutely right - if you want to do something completely unrelated
> to the patent, which does not use any aspect of the patent, you are in the
> clear.  Unfortunately for you & Eben, that's irrelevant if what you are
> doing doesn't work without RT/Linux.  If that's true, you're using his patent
> and you have to pay his price.
>
> I really don't see the problem anyway.  FSMlabs worked long and hard to
> produce their work.  And took the time and effort to patent it.  And they
> allow you to use it for free if you are working on 100% free stuff.  That's
> pretty reasonable.

What's completely unreasonable is that they patented something they damn
well knew has existed for decades. Yes, it's a neat trick that they were
able to do it with Linux with low overhead, but people have been using
UNIX as guests atop VM layers for a long time, and guess what? They've
been doing realtime interrupt processing on those same machines. Hell,
there are half a dozen products that do this with DOS and Windows that
predate RTLinux, like iRMX. In fact, look no further than the PC on your
desk's power switch which triggers an interrupt in so-called system
management mode - effectively a real-time layer that pre-empts your OS.
This has been in laptops in some form or another since at least the
386SLC.

Same goes for this "embedded protocol objects" patent. The patent is so
vague about what it's actually patenting that it certainly runs afoul of
the zero-copy buffering scheme from the IO-Lite paper we all read a few
years ago, never mind simple readv/writev (and your own IO-doohickeys!).

Compare:

 http://appft1.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/
 netahtml/PTO/search-bool.html&r=2&f=G&l=50&co1=AND&d=PG01&s1=
 'molnar+ingo'.IN.&s2='red+hat'&OS=IN/%22molnar+ingo%22+AND
 +%22red+hat%22&RS=IN/%22molnar+ingo%22+AND+%22red+hat%22

 http://www.usenix.org/publications/library/proceedings/osdi99/
 full_papers/pai/pai.pdf

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

