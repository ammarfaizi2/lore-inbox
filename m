Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVKVBbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVKVBbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVKVBbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:31:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24241 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964824AbVKVBbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:31:50 -0500
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1132616496.31144.27.camel@cog.beaverton.ibm.com>
References: <20051115090827.GA20411@elte.hu>
	 <1132608728.4805.20.camel@cmn3.stanford.edu>
	 <20051121221511.GA7255@elte.hu>  <20051121221941.GA11102@elte.hu>
	 <1132616496.31144.27.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 20:31:43 -0500
Message-Id: <1132623104.4772.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 15:41 -0800, john stultz wrote:
> I believe this is the same dual-core TSC drift that has been seen w/
> x86-64. I have just added some similar logic to the TSC clocksource
> that mimics what x86-64 does so an alternative clocksource will be
> selected automatically.
> 
> I should be sending out another release later tonight with these
> updates.
> 

It is really unfortunate that the TSC cannot be used for timekeeping on
these machines.  I wrote a simple benchmark that shows rdtsc on
Fernando's box to be insanely fast - 10000 iterations in 68
microseconds.  This was an order of magnitude faster than any other
machine we tested.  Why would they bother making it so fast if it's
useless for timekeeping?

Lee

