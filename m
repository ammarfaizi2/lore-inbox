Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWASBtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWASBtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWASBtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:49:39 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:36517 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030499AbWASBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:49:38 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, gcoady@gmail.com,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060102201429.GB32464@elte.hu>
References: <1135814419.7680.13.camel@mindpipe>
	 <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com>
	 <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe>
	 <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu>
	 <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
	 <20051230080914.GA26643@elte.hu>
	 <Pine.LNX.4.64.0512300849590.3298@g5.osdl.org>
	 <20060102201429.GB32464@elte.hu>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 20:49:31 -0500
Message-Id: <1137635372.4736.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 21:14 +0100, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > > have you applied the zlib patches too? In particular this one should 
> > > make a difference:
> > > 
> > >     http://redhat.com/~mingo/latency-tracing-patches/patches/reduce-zlib-stack-hack.patch
> > > 
> > > If you didnt have this applied, could you apply it and retry with 
> > > stack-footprint-debugging again?
> > 
> > Ingo, instead of having a static work area and using locking, why not 
> > just move those fields into the "z_stream" structure, and thus make 
> > them be per-stream? The z_stream structure should already be allocated 
> > with kmalloc() or similar by the caller, so that also gets it off the 
> > stack without the locking thing.
> > 
> > Hmm?
> 
> yeah, i'll implement that. The above one was just a quick hack that 
> somehow survived. (and i am definitely a wimp when it comes to changing 
> zlib internals :-)

Ingo,

If you get a chance would you mind porting this to 2.6.16-rc1?  I only
get 6 failures when applying the 2.6.15-rc7 patch set.

I'd like to be able to catch any 2.6.16 latency regressions while there
is time to do something about them, to avoid a repeat of the unmap_vmas
problem in 2.6.15.

Lee

