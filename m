Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVJXSNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVJXSNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJXSNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:13:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7376 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751215AbVJXSNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:13:17 -0400
Date: Mon, 24 Oct 2005 20:13:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.14-rc5-rt5 - softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:103
Message-ID: <20051024181320.GA9736@elte.hu>
References: <5bdc1c8b0510240907mc90490eoe111188ee874c8a5@mail.gmail.com> <1130173552.7377.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130173552.7377.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > Time: tsc clocksource has been installed.
> > WARNING: non-monotonic time!
> > ... time warped from 151976744 to 147973105.
> > softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:103
> 
> Hi Mark,
> 
> Yeah, I saw this too, and it went through to Thomas Gleixner and then 
> to John Stultz, where he said that he may have fixed this in his 
> latest version.  So we are now waiting on Thomas to pull John's work 
> into the ktimers code, and then onto Ingo's RT base.
> 
> So, until then, you may just ignore the messages.  It should only 
> happen when the tsc clocksource changes.
> 
> Unless, of course -rt5 already has this (I just got back from Germany, 
> so I've been out of the loop).
> 
> Thomas, this hasn't been done yet, has it?

not yet, but it's in progress. Meanwhile i increased the number of times 
the warning will be printed per bootup (from 1 to 3), so that if a time 
warp happens outside of that clock-switch case it should be printed too.

	Ingo
