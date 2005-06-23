Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVFWB4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVFWB4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVFWByf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:54:35 -0400
Received: from opersys.com ([64.40.108.71]:64274 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261994AbVFWBwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:52:05 -0400
Message-ID: <42BA1850.4060505@opersys.com>
Date: Wed, 22 Jun 2005 22:02:56 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com> <20050623013451.GA14137@elte.hu>
In-Reply-To: <20050623013451.GA14137@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> if anything i wrote offended you i'd like to apologize for it. I feel 
> pretty strongly about the stuff i do, but i always regret 99.9% of the 
> flames in the next morning :) Also, i only realized when reading your 
> reply that you took my "vendor sponsored benchmarking" remark literally 
> (and that's my bad too). I never thought of you as a 'vendor' or having 
> any commercial interest in this benchmarking - it was just a stupid 
> analogy from me. I should have written "supporter driven benchmarking" 
> or so - that would still have been a pretty nice flame ;)

Thanks for the clarification, sorry if I jumped to the wrong conclusions
regarding what you meant to say.

> also please consider the other side of the coin. You posted numbers that 
> initially put PREEMPT_RT in a pretty bad light. Those numbers are still 
> being linked to from your website, without any indication to suggest 
> that they are incorrect. Even in your above paragraph you are not 
> talking about flawed numbers, you are talking about 'changing the tests 
> to fit my requirements'. Heck i have no 'requirements' other than to see 
> fair numbers. And if adeos/ipipe happens to beat PREEMPT_RT in a fair 
> irq latency test you wont hear a complaint from me. (you might see a 
> patch quite soon though ;)

OK, please recheck the webpage, I've now added a warning specifically
to the effect that the numbers need to be rerun. Hopefully this clears
things up.

> And i know what irq latencies to expect from PREEMPT_RT. It takes me 5 
> minutes to do a 10 million samples irq test using LPPTEST, the histogram 
> takes only 200 bytes on the screen, and the numbers i'm getting differ 
> from your numbers - but obviously i cannot run it on your hardware. The 
> rtc_wakeup and built-in latency-tracer numbers differ too. They could be 
> all wrong though, so i'm curious what your independent method will 
> yield.

Well the method we're using is certainly not absolute. That's why we're
providing the scripts. There's no saying that others (outside yourself
and us) will find some other outlandish results. But hopefully the more
we study these things, the more consistent we can characterize them.

> your lmbench results look accurate and fair, the slowdown during 
> irq-load is a known and expected effect of IRQ threading. If you flood 
> ping a box and generate context-switches instead of plain interrupts, 
> there will be noticeable overhead. I checked some of the lmbench numbers 
> today on my testbox, and while there's overhead, it's significantly less 
> than the 90% degradation you were seeing. That's why i suggested to you 
> to retest using the current base - but you of course dont 'have to'.  
> There were a number of bugs fixed in the past few dozen iterations of 
> patches that affected various components of lmbench :)

I certainly welcome this. Thanks for partly confirming our results,
and pointing out that newever versions are better. Like I said
earlier, we're bound to repeat our tests with all that's been
suggested now ... So we will redo with the version you mentioned
earlier. Hopefully this time we'll get it right.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
