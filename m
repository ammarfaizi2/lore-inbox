Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbVF3QS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVF3QS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVF3QS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:18:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61674 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262991AbVF3QSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:18:16 -0400
Date: Thu, 30 Jun 2005 18:17:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630161726.GA11185@elte.hu>
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com> <20050630070709.GA26239@elte.hu> <20050630154304.GA1298@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630154304.GA1298@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> > another point is that this test is measuring the overhead of PREEMPT_RT, 
> > without measuring the benefit of the cost: RT-task scheduling latencies.  
> > We know since the rtirq patch (to which i-pipe is quite similar) that we 
> > can achieve good irq-service latencies via relatively simple means, but 
> > that's not what PREEMPT_RT attempts to do. (PREEMPT_RT necessarily has 
> > to have good irq-response times too, but much of the focus went to the 
> > other aspects of RT task scheduling.)
> 
> Agreed, a PREEMPT_RT-to-IPIPE comparison will never be an 
> apples-to-apples comparison.  Raw data will never be a substitute for 
> careful thought, right?  ;-)

well, it could still be tested, since it's so easy: the dohell script is 
already doing all of that as it runs rtc_wakeup - which runs a 
SCHED_FIFO task and carefully measures wakeup latencies. If it is used 
with 1024 Hz (the default) and it can be used in every test without 
impacting the system load in any noticeable way.

	Ingo
