Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261252AbRETSD0>; Sun, 20 May 2001 14:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbRETSDQ>; Sun, 20 May 2001 14:03:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:16649 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261252AbRETSDG>;
	Sun, 20 May 2001 14:03:06 -0400
Date: Sun, 20 May 2001 19:58:39 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <8766ew16fn.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.33.0105201943510.1635-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2001, Zlatko Calusic wrote:

> Mike Galbraith <mikeg@wen-online.de> writes:
>
> > Hi,
> >
> > On Fri, 18 May 2001, Stephen C. Tweedie wrote:
> >
> > > That's the main problem with static parameters.  The problem you are
> > > trying to solve is fundamentally dynamic in most cases (which is also
> > > why magic numbers tend to suck in the VM.)
> >
> > Magic numbers might be sucking some performance right now ;-)
> >
> [snip]
>
> I like your patch, it improves performance somewhat and makes things
> more smooth and also code is simpler.

Thanks for the feedback.  Positive is nice.. as is negative.

> Anyway, 2.4.5-pre3 is quite debalanced and it has even broken some
> things that were working properly before. For instance, swapoff now
> deadlocks the machine (even with your patch applied).

I haven't run into that.

> Unfortunately, I have failed to pinpoint the exact problem, but I'm
> confident that kernel goes in some kind of loop (99% system time, just
> before deadlock). Anybody has some guidelines how to debug kernel if
> you're running X?

Serial console and kdb or kgdb if you have two machines.. or uml?

> Also in all recent kernels, if the machine is swapping, swap cache
> grows without limits and is hard to recycle, but then again that is
> a known problem.

This one bugs me.  I do not see that and can't understand why.

	-Mike

