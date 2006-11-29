Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935316AbWK2HYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935316AbWK2HYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935390AbWK2HYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:24:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27095 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935316AbWK2HYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:24:38 -0500
Date: Wed, 29 Nov 2006 08:21:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
Message-ID: <20061129072100.GA1983@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu> <1164744757.1701.58.camel@mindpipe> <20061128201444.GB26934@elte.hu> <1164751282.7543.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164751282.7543.25.camel@localhost.localdomain>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> > i fixed this in -rt8: the latency tracer now uses the time of day 
> > clocksource - pmtimer in this case. (that means function tracing is 
> > slower than with the TSC, but latency figures are more reliable.)
> 
> I have a patch set to make the using the clocksources a little nicer.. 
> Is there anything I should add to that interface to help enable 
> latency tracing, or are you satisfied with using the timekeeping 
> clocksource? It might get constrictive after a while.

please talk to John and Thomas about GTOD interfaces. Right now the 
solution used by the latency tracer is working out pretty OK - but if 
something better comes along i can use that too. It's not a burning 
issue though, unless you know of some bug. (i'm not sure what you mean 
by it becoming constrictive)

	Ingo
