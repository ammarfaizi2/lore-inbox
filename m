Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVLVXxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVLVXxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLVXxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:53:54 -0500
Received: from xenotime.net ([66.160.160.81]:6576 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751083AbVLVXxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:53:54 -0500
Date: Thu, 22 Dec 2005 15:53:52 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Sean <seanlkml@sympatico.ca>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <BAYC1-PASMTP04B55F85E952E6722013B5AE300@CEZ.ICE>
Message-ID: <Pine.LNX.4.58.0512221551030.3425@shark.he.net>
References: <20051222114147.GA18878@elte.hu>    <20051222035443.19a4b24e.akpm@osdl.org>
    <20051222122011.GA20789@elte.hu>    <20051222050701.41b308f9.akpm@osdl.org>
    <1135257829.2940.19.camel@laptopd505.fenrus.org>   
 <20051222054413.c1789c43.akpm@osdl.org>    <1135260709.10383.42.camel@localhost.localdomain>
    <20051222153014.22f07e60.akpm@osdl.org>    <20051222233416.GA14182@infradead.org>
 <BAYC1-PASMTP04B55F85E952E6722013B5AE300@CEZ.ICE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Sean wrote:

> On Thu, December 22, 2005 6:34 pm, Christoph Hellwig said:
> > On Thu, Dec 22, 2005 at 03:30:14PM -0800, Andrew Morton wrote:
> >> No it does not.
> >>
> >> Ingo's work has shown us two things:
> >>
> >> a) semaphores use more kernel text than they should and
> >>
> >> b) semaphores are less efficient than they could be.
> >>
> >> Fine.  Let's update the semaphore implementation to fix those things.
> >> Nobody has addressed this code in several years.  If we conclusively
> >> cannot
> >> fix these things then that's the time to start looking at implementing
> >> new
> >> locking mechanisms.
> >
> > c) semaphores are total overkill for 99% percent of the users.  Remember
> > this thing about optimizing for the common case?
> >
> > Pretty much everywhere we do want mutex semantic.  So let's have a proper
> > primitive exactly for that, and we can keep the current semaphore
> > implementation (with a much simpler implementation) for that handfull of
> > users in the kernel that really want a counting semaphore.
> >
> > I really don't get why you hate mutex primitives so much.
> >
>
> Yes it's hard to figure.  It seems to be deeper than just hating mutex
> primitives, he hates the timer core updates that come from Ingo too; this
> may be a general dislike for all things -rt.

Andrew can surely answer that, but it could be something as
simple as wanting to build a more stable kernel (one without
so much churn), so that things have time to mature and
improve without breaking so many other things...

This (current) is a hectic development cycle style.
-- 
~Randy
