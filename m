Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWABUOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWABUOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWABUOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:14:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16034 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751009AbWABUOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:14:42 -0500
Date: Mon, 2 Jan 2006 21:14:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: gcoady@gmail.com, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20060102201429.GB32464@elte.hu>
References: <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu> <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com> <20051230080914.GA26643@elte.hu> <Pine.LNX.4.64.0512300849590.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512300849590.3298@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > have you applied the zlib patches too? In particular this one should 
> > make a difference:
> > 
> >     http://redhat.com/~mingo/latency-tracing-patches/patches/reduce-zlib-stack-hack.patch
> > 
> > If you didnt have this applied, could you apply it and retry with 
> > stack-footprint-debugging again?
> 
> Ingo, instead of having a static work area and using locking, why not 
> just move those fields into the "z_stream" structure, and thus make 
> them be per-stream? The z_stream structure should already be allocated 
> with kmalloc() or similar by the caller, so that also gets it off the 
> stack without the locking thing.
> 
> Hmm?

yeah, i'll implement that. The above one was just a quick hack that 
somehow survived. (and i am definitely a wimp when it comes to changing 
zlib internals :-)

	Ingo
