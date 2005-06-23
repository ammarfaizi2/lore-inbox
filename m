Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVFWBk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVFWBk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVFWBhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:37:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26262 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261970AbVFWBfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:35:30 -0400
Date: Thu, 23 Jun 2005 03:34:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050623013451.GA14137@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA069D.20208@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> If I wanted to show "my" project in such a good light, would I have 
> gone back and redone tests, and then published them even if those 
> numbers now showed that the "other" project was as good as "mine"? 
> Would I have even listened to any of your suggestions and gone back 
> and had the tests changed to fit your requirements? Would I still be 
> telling that we're going to further fix the tests based on your 
> feedback?

if anything i wrote offended you i'd like to apologize for it. I feel 
pretty strongly about the stuff i do, but i always regret 99.9% of the 
flames in the next morning :) Also, i only realized when reading your 
reply that you took my "vendor sponsored benchmarking" remark literally 
(and that's my bad too). I never thought of you as a 'vendor' or having 
any commercial interest in this benchmarking - it was just a stupid 
analogy from me. I should have written "supporter driven benchmarking" 
or so - that would still have been a pretty nice flame ;)

also please consider the other side of the coin. You posted numbers that 
initially put PREEMPT_RT in a pretty bad light. Those numbers are still 
being linked to from your website, without any indication to suggest 
that they are incorrect. Even in your above paragraph you are not 
talking about flawed numbers, you are talking about 'changing the tests 
to fit my requirements'. Heck i have no 'requirements' other than to see 
fair numbers. And if adeos/ipipe happens to beat PREEMPT_RT in a fair 
irq latency test you wont hear a complaint from me. (you might see a 
patch quite soon though ;)

And i know what irq latencies to expect from PREEMPT_RT. It takes me 5 
minutes to do a 10 million samples irq test using LPPTEST, the histogram 
takes only 200 bytes on the screen, and the numbers i'm getting differ 
from your numbers - but obviously i cannot run it on your hardware. The 
rtc_wakeup and built-in latency-tracer numbers differ too. They could be 
all wrong though, so i'm curious what your independent method will 
yield.

your lmbench results look accurate and fair, the slowdown during 
irq-load is a known and expected effect of IRQ threading. If you flood 
ping a box and generate context-switches instead of plain interrupts, 
there will be noticeable overhead. I checked some of the lmbench numbers 
today on my testbox, and while there's overhead, it's significantly less 
than the 90% degradation you were seeing. That's why i suggested to you 
to retest using the current base - but you of course dont 'have to'.  
There were a number of bugs fixed in the past few dozen iterations of 
patches that affected various components of lmbench :)

	Ingo
