Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935587AbWK2Noq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935587AbWK2Noq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935588AbWK2Noq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:44:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9187 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935587AbWK2Nop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:44:45 -0500
Date: Wed, 29 Nov 2006 14:43:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
Message-ID: <20061129134311.GA14566@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu> <20061128200927.GA26934@elte.hu> <1164746224.15887.40.camel@cmn3.stanford.edu> <1164747854.15887.48.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164747854.15887.48.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > > > (            japa-4096 |#0): new 17 us maximum-latency wakeup.
> > > > (         beagled-3412 |#1): new 19 us maximum-latency wakeup.
> > > > (          IRQ 18-1081 |#1): new 26 us maximum-latency wakeup.
> > > > (             snd-4040 |#1): new 1107 us maximum-latency wakeup.
> > > > (            japa-4096 |#0): new 1445 us maximum-latency wakeup.
> > > > (            japa-4096 |#0): new 2110 us maximum-latency wakeup.
> > > > (        qjackctl-4038 |#1): new 2328 us maximum-latency wakeup.
> > > > (            japa-4096 |#0): new 2548 us maximum-latency wakeup.
> > > > (          IRQ 18-1081 |#0): new 10291 us maximum-latency wakeup.

ok, i reproduced something similar on one of my boxes and it turned out 
to be a tracer bug. I've uploaded -rt10, could you try it? (The xruns 
will likely remain, but at least the tracer should be more usable now to 
find out the reason for the xruns.)

	Ingo
