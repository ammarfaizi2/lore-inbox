Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVGKLbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVGKLbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVGKLbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:31:31 -0400
Received: from opersys.com ([64.40.108.71]:45062 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261650AbVGKLb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:31:29 -0400
Message-ID: <42D2572B.8070103@opersys.com>
Date: Mon, 11 Jul 2005 07:25:31 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
References: <42CF05BE.3070908@opersys.com> <20050709071911.GB31100@elte.hu> <42CFEFC9.7070007@opersys.com> <20050711070516.GA2238@elte.hu>
In-Reply-To: <20050711070516.GA2238@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> So why do your "ping flood" results show such difference? It really is 
> just another type of interrupt workload and has nothing special in it.
...
> are you suggesting this is not really a benchmark but a way to test how 
> well a particular system withholds against extreme external load?

Look, you're basically splitting hairs. No matter how involved an explanation
you can provide, it remains that both vanilla and I-pipe were subject to the
same load. If PREEMPT_RT consistently shows the same degradation under the
same setup, and that is indeed the case, then the problem is with PREEMPT_RT,
not the tests.

> so you can see ping packet flow fluctuations in your tests? Then you 
> cannot use those results as any sort of benchmark metric.

I didn't say this. I said that if fluctuation there is, then maybe this is
something we want to see the effect of. In real world applications,
interrupts may not come in at a steady pace, as you try to achieve in your
own tests.

> and from this point on you should see zero lmbench overhead from flood 
> pinging. Can vanilla or I-PIPE do that?

Let's not get into what I-pipe can or cannot do, that's not what these
numbers are about. It's pretty darn amazing that we're even having this
conversation. The PREEMPT_RT stuff is being worked on by more than a
dozen developers spread accross some of the most well-known Linux companies
out there (RedHat, MontaVista, IBM, TimeSys, etc.). Yet, despite this
massive involvement, here we have a patch developed by a single guy,
Philippe, who's doing this work outside his regular work hours, and his
patch, which does provide guaranteed deterministic behavior, is:
a) Much smaller than PREEMPT_RT
b) Less intrusive than PREEMPT_RT
c) Performs very well, as-good-as if not sometimes even better than PREEMPT_RT

Splitting hairs won't erase this reality. And again, before the I get the
PREEMPT_RT mob again on my back, this is just for the sake of argument,
both approaches remain valid, and are not mutually exclusive.

Like I said before, others are free to publish their own numbers showing
differently from what we've found.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

