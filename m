Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSLJAtC>; Mon, 9 Dec 2002 19:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266407AbSLJAtC>; Mon, 9 Dec 2002 19:49:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51983 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261914AbSLJAtB>; Mon, 9 Dec 2002 19:49:01 -0500
Date: Mon, 9 Dec 2002 19:55:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Peter Waechtler <pwaechtler@mac.com>
cc: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, wrona@mat.uni.torun.pl
Subject: Re: POSIX message queues, 2.5.50
In-Reply-To: <1039390666.19736.1.camel@picklock>
Message-ID: <Pine.LNX.3.96.1021209194238.9066B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Dec 2002, Peter Waechtler wrote:

> On Sun, 2002-12-08 at 18:38, Krzysztof Benedyczak wrote:
> > On Fri, 6 Dec 2002, Peter Waechtler wrote:
> > >
> > > >  - our implementation does support priority scheduling which is omitted in
> > > > Peter's version (meaning that if many processes wait e.g. for a message
> > > > _random_ one will get it). It is important because developers could rely
> > > > on this feature - and it is as I think the most difficult part of
> > > > implementation
> > >
> > > Well, can you give an realistic and sensible example where an app design
> > > really takes advantage on this?
> > >
> > > If I've got a thread pool listening on the queue, I _expect_ non
> > > predictability on which thread gets which message:
> > 
> > But someone could. When you implement POSIX message queues you have to
> > follow the standard and not write something similar to it.
> > Even if you mention in docs that your mqueues aren't strictly POSIX,
> > someone can miss it and end up with hard to explain "bug" in his program.
> > BTW as your implementation will act randomly I can't see how you will
> > handle multiple readers (maybe except some trivial cases).
> > 
> 
> Just iterating over and over again does not produce the truth.
> It's not "random" - it's highly deterministic: the longest waiter
> will be woken up.

I think your original post saying you expect non-predictability is/was
very misleading. I think you meant the application can't make assumptions
based on knowing which thread will be scheduled next, but even then the
truth is that if it is always deterministic then assumptions could be
legitimately be made. 

If it was random then a thread could wait forever, and Murphy's law says
it would happen most of the time:-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

