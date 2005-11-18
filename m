Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVKRXiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVKRXiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVKRXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:38:05 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:2751 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1751180AbVKRXiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:38:04 -0500
Subject: Re: 2.6.14-rt13
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: nando@ccrma.Stanford.EDU, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <Pine.LNX.4.58.0511181725030.17504@gandalf.stny.rr.com>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <20051118220755.GA3029@elte.hu> <1132352143.6874.31.camel@mindpipe>
	 <Pine.LNX.4.58.0511181725030.17504@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 15:36:58 -0800
Message-Id: <1132357018.4735.51.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 17:25 -0500, Steven Rostedt wrote:
> On Fri, 18 Nov 2005, Lee Revell wrote:
> 
> > On Fri, 2005-11-18 at 23:07 +0100, Ingo Molnar wrote:
> > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > >
> > > > Arghhh, at least I take this as a confirmation that the TSCs do drift
> > > > and there is no workaround. It currently makes the -rt/Jack
> > > > combination not very useful, at least in my tests.
> > > >
> > > > Is there a way to resync the TSCs?
> > >
> > > no reasonable way. Does idle=poll make any difference?
> >
> > But JACK itself uses rdtsc() for timing calculations so TSC drift is
> > invariably fatal.
> 
> Can it simply be pinned to a cpu?

Is there a way to know in which cpu a process is running? At least Jack
could ignore timinig issues if the measurement is going to happen in a
different cpu than the one where the original timestamp was collected. 

-- Fernando


