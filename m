Return-Path: <linux-kernel-owner+w=401wt.eu-S932307AbWLNKCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWLNKCp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWLNKCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:02:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47022 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbWLNKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:02:44 -0500
Date: Thu, 14 Dec 2006 11:00:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: tike64 <tike64@yahoo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt and arm
Message-ID: <20061214100055.GB19549@elte.hu>
References: <1166034960.1785.10.camel@localhost.localdomain> <20061214072126.12023.qmail@web59204.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214072126.12023.qmail@web59204.mail.re1.yahoo.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* tike64 <tike64@yahoo.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> > Also, have you tried this with a nanosleep instead of a select.
> > Select's timeout is just that, a timeout. It's not suppose to be
> > accurate, as long as it doesn't expire early.  The reason I state
> > this, is that select uses a different mechanism than nanosleep, and
> > that can indeed affect the jitter.
> 
> Ok, understood; I tried this:
> 
> 	t = raw_timer();
> 	ts.tv_nsec = 5000000;
> 	ts.tv_sec = 0;
> 	nanosleep(&ts, 0);
> 	t = raw_timer() - t;
> 
> It is better but I still see 8ms occasional delays when listing 
> nfs-mounted directories onto FB. And, what is funny, also this version 
> makes the average delay 20ms as if it made the jiffy 20ms.

ARM has no high resolution timers support yet in the -rt tree.

	Ingo
