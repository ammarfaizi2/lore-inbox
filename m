Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWAXJXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWAXJXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWAXJXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:23:02 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21640 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030422AbWAXJXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:23:00 -0500
Date: Tue, 24 Jan 2006 10:23:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124092330.GA7060@elte.hu>
References: <1138089139.2771.78.camel@mindpipe> <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe> <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124091730.GA31204@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> > Have not tested yet but it appears that will reduce it substantially:
> > 
> > $ grep "dst_destroy (dst_rcu_free)" /proc/latency_trace | wc -l
> > 3027
> > 
> > This implies the latency would be reduced to ~4ms, still not great but
> > it will be overshadowed by rt_run_flush/rt_garbage_collect.
> 
> The other patch to try would be Dipankar Sarma's patch at:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113657112726596&w=2
> 
> This patch was primarily designed to reduce memory overhead, but given 
> that it tends to reduce batch size, it should also reduce latency.

if this solves Lee's problem, i think we should apply this as a fix, and 
get it into v2.6.16. The patch looks straightforward and correct to me.

	Ingo
