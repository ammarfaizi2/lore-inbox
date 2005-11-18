Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVKRWGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKRWGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVKRWGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:06:38 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:54944 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932081AbVKRWGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:06:37 -0500
Subject: Re: 2.6.14-rt13
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: nando@ccrma.Stanford.EDU, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1132350882.6874.23.camel@mindpipe>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 14:05:33 -0800
Message-Id: <1132351533.4735.37.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 16:54 -0500, Lee Revell wrote:
> On Fri, 2005-11-18 at 10:02 -0800, Fernando Lopez-Lezcano wrote:
> > You mentioned before that the TSC's from both cpus could drift from
> > each other over time. Assuming that is the source of timing (I have no
> > idea) that could explain the behavior of Jack, it gets a reference
> > time from one of the cpus and then compares that with what it gets
> > from either cpu depending on where it is running at a given time. If
> > it is the same cpu all is fine, if it is the other and it has drifted
> > then the warning is printed.  
> 
> Yes, JACK uses rdtsc() for microsecond resolution timing and assumes
> that the TSCs are in sync.
> 
> I've asked on this list what a better time source could be and didn't
> get any useful responses, people just told me "use gettimeofday()" which
> is WAY too slow.

Arghhh, at least I take this as a confirmation that the TSCs do drift
and there is no workaround. It currently makes the -rt/Jack combination
not very useful, at least in my tests. 

Is there a way to resync the TSCs?
-- Fernando


