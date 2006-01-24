Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWAXIK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWAXIK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWAXIK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:10:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46059 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030366AbWAXIK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:10:58 -0500
Date: Tue, 24 Jan 2006 09:11:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124081118.GB25855@elte.hu>
References: <1138089139.2771.78.camel@mindpipe> <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe> <20060124080157.GA25855@elte.hu> <1138089833.2771.86.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138089833.2771.86.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2006-01-24 at 09:01 +0100, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > On Tue, 2006-01-24 at 08:56 +0100, Ingo Molnar wrote:
> > > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > > 
> > > > > I ported the latency tracer to 2.6.16 and got this 13ms latency within 
> > > > > a few hours.  This is a regression from 2.6.15.
> > > > > 
> > > > > It appears that RCU can invoke ipv4_dst_destroy thousands of times in 
> > > > > a single batch.
> > > > 
> > > > could you try the PREEMPT_RCU patch below?
> > > 
> > > Sure.  If it works do you see this making it in 2.6.16?  Otherwise we 
> > > still would have a regression...
> > 
> > nope, that likely wont make v2.6.16, which is frozen already.
> > 
> 
> Well, the last latency regression I found, I was told "I wish you'd 
> caught this at 2.6.15-rc1, something could have been done".  Now I've 
> found another one at the -rc1 stage, and there's still nothing that 
> can be done?

i did not say that - it should clearly be fixed for 2.6.16. But 
nevertheless we should do PREEMPT_RCU in v2.6.17, because RCU related 
latencies are hard to fix in general.

	Ingo
