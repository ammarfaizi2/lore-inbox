Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVL3IJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVL3IJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVL3IJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:09:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57799 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751211AbVL3IJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:09:34 -0500
Date: Fri, 30 Dec 2005 09:09:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: gcoady@gmail.com
Cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051230080914.GA26643@elte.hu>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu> <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
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


* Grant Coady <grant_lkml@dodo.com.au> wrote:

> On Thu, 29 Dec 2005 21:28:48 +0100, Ingo Molnar <mingo@elte.hu> wrote:
> 
> >
> >thanks, applied - new version uploaded.
> 
> I just booted with latency tracer, it died with (copy by hand):
> {   40} [<c012e74a>] debug_stackoverflow+0x6a/0xc0
> 
> Much unusual stuff (several screenfuls) scrolled up prior to lockup.

have you applied the zlib patches too? In particular this one should 
make a difference:

    http://redhat.com/~mingo/latency-tracing-patches/patches/reduce-zlib-stack-hack.patch

If you didnt have this applied, could you apply it and retry with 
stack-footprint-debugging again?

	Ingo
