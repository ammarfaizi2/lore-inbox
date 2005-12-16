Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVLPTq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVLPTq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVLPTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:46:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932391AbVLPTq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:46:26 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <20051216140425.GY23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <dnv0d3$4jl$1@sea.gmane.org>
	 <1134758219.2992.52.camel@laptopd505.fenrus.org>
	 <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 20:46:18 +0100
Message-Id: <1134762379.2992.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You're using overly generalized assertions to try to convince others

I'm no longer interested in arguing removing this thing. Too much
whining by ndiswrapper addicts [1].

> that the configurability of a particularly important (to some, albeit
> not you) config option is unnecessary.  4K vs 8K is hardly a "trivial"
> configuration option of the Linux kernel. 

Compared to many of the other changes that went in since 2.6.0? 4K
stacks is a minor change. There's no config option for 4 level
pagetables for example, and that's a far more invasive change in many
ways. 

>  At this point in time it
> has not been sufficiently demonstrated that 4K "just works".

Excuse me?
Fedora released 3 distributions with it enabled, and Red Hat uses it in
an enterprise distribution. That's a whopping lot of users right there
with a very wide range of workloads.

>  kernel to get the desired safety?  IF upstream
> kernel.org doesn't even provide the knobs to ensure safety at all
> costs (and vendors like Redhat have people at the helm who are
> advocating 4K stacks in the "Enterprise" Linux kernel configurations
> of the world) how does one get a Linux kernel that provides a sizable
> safety net that is _SUPPORTED_ for true enterprise-grade applications?

eh I don't know if you paid attention, but Red Hat Enterprise Linux 4
only has 4Kb stacks kernels... so that covers your supported true
enterprise-grade application thing. 

> Simply put 4K vs 8K is not as trivial a decision as you'd have people believe.

that's too simply put in fact, especially if you look at it
historically. It's a bit of irony that part of the reason 4K stacks was
developed was that the 2.4 kernels ran out of stack space for customers
occasionally (just as example look at lkml this week, there was a report
about such an overflow there as well). Remember that 4K+4K has more
stack space than the 4K+2K as 2.4 kernels have. Sure 2.6 bumped this to
5.5k/2.5k roughly in the "8K" case, but fundamentally the change to
4k/4k isn't all that big even inside 2.6. 

You can go on and keep painting this as a cowboy development, but it
really isn't....



[1] Yes addicts; binary drivers are in many ways similar to heroin;
they're really hard to get rid of for example and highly addictive, they
also cause some people to act like junkies-in-withdrawl when their
binary driver breaks, or when someone suggests breaking it.

