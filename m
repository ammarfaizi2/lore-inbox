Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbVKRV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbVKRV6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbVKRV6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:58:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16533 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161256AbVKRV6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:58:16 -0500
Subject: Re: 2.6.14-rt13
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1132336954.20672.11.camel@cmn3.stanford.edu>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 16:54:41 -0500
Message-Id: <1132350882.6874.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 10:02 -0800, Fernando Lopez-Lezcano wrote:
> You mentioned before that the TSC's from both cpus could drift from
> each other over time. Assuming that is the source of timing (I have no
> idea) that could explain the behavior of Jack, it gets a reference
> time from one of the cpus and then compares that with what it gets
> from either cpu depending on where it is running at a given time. If
> it is the same cpu all is fine, if it is the other and it has drifted
> then the warning is printed.  

Yes, JACK uses rdtsc() for microsecond resolution timing and assumes
that the TSCs are in sync.

I've asked on this list what a better time source could be and didn't
get any useful responses, people just told me "use gettimeofday()" which
is WAY too slow.

Lee

