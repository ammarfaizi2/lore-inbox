Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVKURYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVKURYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVKURYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:24:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:9152 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932360AbVKURYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:24:46 -0500
Date: Mon, 21 Nov 2005 18:24:44 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051121172444.GB20775@brahms.suse.de>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de> <20051106015542.GE14064@opteron.random> <20051121164349.GE14746@opteron.random> <20051121170517.GA20775@brahms.suse.de> <20051121171616.GH14746@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121171616.GH14746@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 06:16:16PM +0100, Andrea Arcangeli wrote:
> On Mon, Nov 21, 2005 at 06:05:17PM +0100, Andi Kleen wrote:
> > On Mon, Nov 21, 2005 at 05:43:49PM +0100, Andrea Arcangeli wrote:
> > > Since there was no feedback to my last post, I assume you agree, so
> > > please backout the tsc disable so then I can plug the performane counter
> > > disable on top of it (at zero additional runtime cost).
> > 
> > Sorry I don't agree.
> 
> You've the config option, turn that off on your systems, what's the
> problem with that?
> 
> Or does this mean I need to ship kernels myself with covert channels
> made mathematically impossible with seccomp enabled? I'd rather avoid

I don't believe theoretical, unlikely to be usable in any way
covert channels are a justification to make fast paths slower. 
That's independent of CONFIG options.

And in addition your change doesn't even close that channel
in theory.

-Andi
