Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965818AbWK1UQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbWK1UQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936098AbWK1UQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:16:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16289 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936095AbWK1UQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:16:43 -0500
Date: Tue, 28 Nov 2006 21:14:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
Message-ID: <20061128201444.GB26934@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu> <1164744757.1701.58.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164744757.1701.58.camel@mindpipe>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2006-11-28 at 11:58 -0800, Fernando Lopez-Lezcano wrote:
> > Hi, I'm trying out the latest -rt patch and getting alsa xruns when
> > using jackd and jack clients. This is a sample from the output of
> > qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):
> 
> Any improvement if you disable high res timers?
> 
> Also, the latency tracer does not work on dual core AMD machines due 
> to the TSC drift.  Might as well disable it.

i fixed this in -rt8: the latency tracer now uses the time of day 
clocksource - pmtimer in this case. (that means function tracing is 
slower than with the TSC, but latency figures are more reliable.)

	Ingo
