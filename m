Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbRESGy5>; Sat, 19 May 2001 02:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbRESGyh>; Sat, 19 May 2001 02:54:37 -0400
Received: from www.wen-online.de ([212.223.88.39]:40970 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261668AbRESGyd>;
	Sat, 19 May 2001 02:54:33 -0400
Date: Sat, 19 May 2001 08:45:57 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.21.0105182310580.5531-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0105190705550.491-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Rik van Riel wrote:

> On Fri, 18 May 2001, Stephen C. Tweedie wrote:
> > On Fri, May 18, 2001 at 07:44:39PM -0300, Rik van Riel wrote:
> >
> > > This is the core of why we cannot (IMHO) have a discussion
> > > of whether a patch introducing new VM tunables can go in:
> > > there is no clear overview of exactly what would need to be
> > > tunable and how it would help.
> >
> > It's worse than that.  The workload on most typical systems is not
> > static.  The VM *must* be able to cope with dynamic workloads.  You
> > might twiddle all the knobs on your system to make your database run
> > faster, but end up in such a situation that the next time a mail flood
> > arrives for sendmail, the whole box locks up because the VM can no
> > longer adapt.
>
> That's another problem, indeed ;)
>
> Ingo, Mike, please keep this in mind when designing
> tunables or deciding which test you want to run today
> in order to look how the VM is performing.

I've bent your code up a bit.  I've not yet been tempted to replace
any of it with a knob ;-)  There is a little piece I'd like to see
thrown away though.. the loop in refill_inactive does nothing good.

The test I prefer is a good one for the area of vm performance I'm
most interested in.  It doesn't cover the full vm spectrum by any
means.  I don't have a setup (any) good for testing mondo network or
IO stuff.  I test a simple 'job one size to large' scenario.  Yes,
it's limited test coverage.. it's still legitimate.

Perhaps when you're evaluating vm performance, you should try my
simple test once in a while. :) I'll bet you a bogobeer right here
and now that when 2.4.5 hits the street you're going to be queried
by the big-busy-box folks wrt swap volume.

> Basic rule for VM: once you start swapping, you cannot
> win;  All you can do is make sure no situation loses
> really badly and most situations perform reasonably.

I disagree with that.  I've seen a heavily swapping box run like
a scaulded ass ape many times.

	Warsteiner,

	-Mike

