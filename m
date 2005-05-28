Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVE1T41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVE1T41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 15:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVE1T40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 15:56:26 -0400
Received: from colin.muc.de ([193.149.48.1]:50692 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261179AbVE1Tzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 15:55:55 -0400
Date: 28 May 2005 21:55:46 +0200
Date: Sat, 28 May 2005 21:55:46 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528195546.GG86087@muc.de>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <20050527135310.GC16158@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527135310.GC16158@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 03:53:10PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@muc.de> wrote:
> 
> > AFAIK the kernel has quite regressed recently, but that was not true 
> > (for reasonable sound) at least for some earlier 2.6 kernels and some 
> > of the low latency patchkit 2.4 kernels.
> 
> (putting my scheduler maintainer hat on) was this under a stock !PREEMPT 
> kernel?  

Yes. I did not run the numbers personally, but I was told 2.6.11+
was already considerable worse for latency tests with jack than 2.6.8+
(this was with vendor kernels in SUSE releases); and apparently
2.6.8 was already worse than earlier 2.6.4/5 kernels or the later 
and better 2.4s. CONFIG_PREEMPT in all cases did not change the
picture much. Sorry for being light on details; as I did 
not run the tests personally.

BTW another reason I am pretty suspicious against the old style preempt
stuff and intrusive latency in general too is that it was broken forever 
in x86-64 - I only fixed it after 2.6.11 which you may have noticed. Before
that it it would only preempt when the interrupts were off,not
on (pretty embarassing bug). And nobody complained; The problem was only found
during code review for a completely different project (thanks JanB!)
And x86-64 is quite widely used these days.

So in practice all these latencies cannot be that big a problem.


-Andi
