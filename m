Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUICGtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUICGtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUICGtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:49:19 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46253 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268993AbUICGtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:49:16 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <20040903063658.GA11801@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
	 <1094181447.4815.6.camel@orbiter>
	 <1094192788.19760.47.camel@krustophenia.net>
	 <20040903063658.GA11801@elte.hu>
Content-Type: text/plain
Message-Id: <1094194157.19760.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 02:49:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 02:36, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > -Q and later use the current method, which is like the above except
> > the second hump is discarded, as it is a function of the scheduling
> > latency and the period size rather than just the scheduling latency:
> > 
> > 	http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6
> > 
> > So, don't be fooled by the numbers, the newest version of the patch is
> > in fact the best.  I have been meaning to go back and measure the
> > current patches with the old code but it's pretty low priority...
> 
> vanilla kernel 2.6.8.1 would be quite interesting to get a few charts of
> - especially if your measurement methodology has changed.

OK, I will give this a shot.  Now that the VP patches are stabilizing I
will be doing more profiling.  I also want to try the -mm kernel, this
has some interesting differences from the stock kernel.  For example I
measured about a 10% improvement with the old method, which implies a
big performance gain.

>  There's not
> much sense in re-testing older VP patches.
> 

Yup, my thoughts exactly, this would just tell us what we already know,
that the latency gets better with each version.

> also, has the userspace workload you are using stayed constant during
> all these tests?
> 

I am mostly just using normal desktop hacker workloads, web browsing,
email, builds.  Lately I am using the box as a Samba server.  At first,
I was stressing the system using every disk benchmark I could think of,
but it never seemed to affect the worst case and did not even change the
shape of the distribution much, so I don't bother.  For all practical
purposes, it's impossible to change the shape of these graphs much by
stressing the system.

I am able to induce large latencies by using up all available swap with
make -j12 on a KDE program, and by pingflooding the broadcast address,
but these are pathological enough that I have not worried about them.

Lee

