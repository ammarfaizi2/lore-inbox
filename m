Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVHOG3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVHOG3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 02:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVHOG3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 02:29:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65241 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S932093AbVHOG3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 02:29:21 -0400
Date: Mon, 15 Aug 2005 08:29:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Ryan Brown <some.nzguy@gmail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Message-ID: <20050815062934.GA5915@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <1123893158.12680.70.camel@mindpipe> <42FD4593.9030702@mvista.com> <20050814021258.GA25877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814021258.GA25877@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * George Anzinger <george@mvista.com> wrote:
> 
> > Ingo, all
> > 
> > I, silly person that I am, configured an RT, SMP, PREEMPT_DEBUG system. 
> >  Someone put code in the NMI path to modify the preempt count which, 
> > often as not will generate a PREEMPT_DEBUG message as there is no tell 
> > what state the preempt count is in on an NMI interrupt.  I have sent 
> > the attached patch to Andrew on this, but meanwhile, if you want RT, 
> > SMP, PREEMPT_DEBUG you will be much better off with this.
> 
> ah - thanks, applied. Might explain some of the recent SMP weirdnesses 
> i'm seeing. Attributed them to the HRT patch ;-)

i'm still seeing weird crashes under SMP, which go away if i disable 
CONFIG_HIGH_RES_TIMERS. (this after i fixed a couple of other SMP bugs 
in the HRT code) It happens sometime during the bootup, after enabling 
the network but before users can log in. There's no good debug info, 
just a hang that comes from all CPUs trying to get some debug info out 
but crashing deeply.

	Ingo
