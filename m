Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVJaAQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVJaAQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVJaAQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:16:56 -0500
Received: from xenotime.net ([66.160.160.81]:17075 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932417AbVJaAQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:16:51 -0500
Date: Sun, 30 Oct 2005 16:16:48 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Rob Landley <rob@landley.net>
Cc: torvalds@osdl.org, jgarzik@pobox.com, akpm@osdl.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
Message-Id: <20051030161648.1faeb77e.rdunlap@xenotime.net>
In-Reply-To: <200510301759.39498.rob@landley.net>
References: <20051029182228.GA14495@havoc.gtf.org>
	<200510300644.20225.rob@landley.net>
	<Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
	<200510301759.39498.rob@landley.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2005 17:59:39 -0600 Rob Landley wrote:

> On Sunday 30 October 2005 16:36, Linus Torvalds wrote:
> 
> > > Is this a viable option?
> >
> > No.
> >
> > There is no "ordering" in a distributed environment. We have things
> > happening in parallel, adn you can't really linearize the patches.
> 
> To clarify my thinking:
> 
> It doesn't matter what the ordering is, as long as A) the patches are 
> separated somehow, B) the resulting kernel from applying any initial subset 
> (patches 1-X in the series) has some reasonable chance to build and work.
> 
> Any arbitrary order is theoretically fine for (A).  Alphabetical by msgid or 
> sha1sum.  Or the order they appear in the changelog.
> 
> It's (B) that's the tricky bit, but not an insoluble problem.  "The order 
> Linux imported them into his tree" might give that.
> 
> > The closest you can get is "git bisect", which does the right thing.
> 
> Ok, so we've already got an order, whatever order git bisect puts them in.  
> (It doesn't have to be stable between releases, just a snapshot in time of a 
> set of individual patches which, cumulatively applied,would have the same 
> effect as the big rc1->rc2 diffs we've been getting.)
> 
> It doesn't sound like it would be _too_ hard to abuse the "git bisect" 
> mechanism to work out each possible bisection point between -rc1 and -rc1, 
> and if that can be done why can't it spit out the individual patches (with 
> descriptions) and cat them together?
> 
> Why wouldn't this work?

Why isn't there a linus.git ordering?  that can be made to work.

---
~Randy
