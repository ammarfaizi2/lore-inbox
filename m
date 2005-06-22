Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVFVU5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVFVU5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVFVU5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:57:44 -0400
Received: from opersys.com ([64.40.108.71]:5904 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262232AbVFVUwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:52:09 -0400
Message-ID: <42B9D208.4080305@opersys.com>
Date: Wed, 22 Jun 2005 17:03:04 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu> <42B9C777.8040202@opersys.com> <20050622202242.GA17301@elte.hu>
In-Reply-To: <20050622202242.GA17301@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
>>From all the test i've done, 600,000 samples are not enough to trigger 
> the worst-case latency - even with the polling method! Also, your tests 
> dont really load the system, so you have a fundamentally lower chance of 
> seeing worst-case latencies. My tests do a dd test, a flood ping, an 
> LTP-40-copies test, an rtc_wakeup 8192 Hz test and an infinite loop of 
> hackbench test all in parallel, and even in such circumstances and with 
> a polling approach i need above 1 million samples to hit the worst-case 
> path! (which i cannot know for sure to be the worst-case path, but which 
> i'm reasonably confident about, based on the distribution of the 
> latencies and having done tens of millions of samples in overnight 
> tests.) Obviously it's a much bigger constraint on the IRQ subsystem if 
> _all_ interrupt _and_ DMA sources in the system are as active as 
> possible.

Hmm... well, I can't say I'm uninterested. Any chances we can get a
copy of the scripts you use to do the MOAILT (Mother Of All Irq Latency
Tests).

> so ... give the -50-12 -RT tree a try and report back the lpptest 
> results you are getting.

First things first, we want to report back that our setup is validated
before we go onto this one. So we've modified LRTBF to do the busy-wait
thing.

> [ I know the results i am seeing, but i wont 
> post them as a counter-point because i'm obviously biased :-) I'll let 
> people without an axe to grind do the measurements. ]

That's an extra reason for giving us a copy (or pointing us to one) of
the script you use to run your tests :)

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
