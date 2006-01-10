Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWAJCyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWAJCyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAJCyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:54:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:37266 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750796AbWAJCyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:54:11 -0500
Date: Mon, 9 Jan 2006 18:54:39 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
Message-ID: <20060110025439.GI14738@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165CE.AF913697@tv-sign.ru> <20060110002818.GD15083@us.ibm.com> <Pine.LNX.4.64.0601091641000.5588@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601091641000.5588@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:43:17PM -0800, Linus Torvalds wrote:
> 
> On Mon, 9 Jan 2006, Paul E. McKenney wrote:
> > 
> > This patch looks sane to me.  It passes a short one-hour rcutorture
> > on ppc64 and x86, firing up some overnight runs as well.
> > 
> > Dipankar, Manfred, any other concerns?  Cacheline alignment?  (Seems
> > to me this code is far enough from the fastpath that this should not
> > be a problem, but thought I should ask.)
> 
> I'd ask you and Oleg to re-synchronize, and perhaps Oleg to re-send the 
> (part of?) the series that has no debate. I'm unsure, for example, whether 
> #2 was just to be dropped.

I believe that the original #2 is to be dropped, but that the patch Oleg
submitted in:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113681388600342&w=2

may be needed.  I have added Vatsa to the CC to get his take on this.

However, this patch should be independent from #4, so it should be OK
to apply an updated #4 first while we are working out what to do about #2.

> I already applied #1, and it looks like there's agreement on #3 and #4, 
> but basically, just to make sure, can Oleg please re-send to make sure I 
> got it right?
> 
> Getting a screwed-up RCU thing is going to be too painful to debug, so I'd 
> rather get it right the first time it hits my tree..

Been there more times than I care to admit, and I most definitely agree!!!

							Thanx, Paul
