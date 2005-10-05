Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVJEP6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVJEP6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVJEP6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:58:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40398 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030194AbVJEP6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:58:21 -0400
Date: Wed, 5 Oct 2005 17:58:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051005155836.GA3626@elte.hu>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain> <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain> <1128527319.13057.139.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128527319.13057.139.camel@tglx.tec.linutronix.de>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2005-10-05 at 10:29 -0400, Steven Rostedt wrote:
> > Hmm, Ingo,
> > 
> > Do you know why time goes backwards when I run hackbench as a realtime
> > process?  I added the output of start and stop and it does seem to go
> > backwards.
> > 
> > Thomas?
> 
> Yes. Thats happening. I moved the priority of softirq-timer above 
> hackbench priority and the problem goes away. I look into this 
> further.

wouldnt hackbench then permanently starve run_timer_softirq(), and 
update_times() in particular?

	Ingo
