Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVFJXcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVFJXcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVFJXb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:31:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29210
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261458AbVFJXaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:30:01 -0400
Date: Sat, 11 Jun 2005 01:29:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Karim Yaghmour <karim@opersys.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610232955.GH6564@g5.random>
References: <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610230836.GD21618@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:08:36PM -0700, Bill Huey wrote:
> On Sat, Jun 11, 2005 at 12:52:31AM +0200, Andrea Arcangeli wrote:
> > Just tell me how can you go to a customer and tell him that your
> > linux-RTOS has a guaranteed worst case latency of 50usec.  How can you
> > tell that? Did you exercise all possible scheduler paths with cache
> > disabled and calculated the worst case latency with rdtsc + math?
> 
> Ask Ingo. I'm through with this track and your misinformed comments

You didn't provide an answer yourself, and you fallback on somebody else
cause there's no valid answer to this question. All I've seen so far are
measurements backed by some statistical significance, that's very far
from the meaning I give to the word _guarantee_.

I fully acknowledge there are some problems that aren't more equally
easily solved with full userland code, for those problems keeping things
simpler by making the kernel more RT aware has a value.

I fully acknowledge that simulating infinite cpus has a value too in
discovering race conditions too ;).

But I personally dislike all things that works by luck, preempt-RT that
aims to provide guarantees about worst case latencies is no exception,
so you shoudln't be surprised if I'm not a RTOS backer for problems that
can be more easily solved with ruby-hard RT designs like RTAI and
rtlinux. I don't care how things have worked in the past on non-linux
OS. Most of the time even current not-RT linux will work fine if it's
idle as it would be on some embedded usages like the printer example.

This even ignoring the fact all those context switch will not be cheap,
kernel can execute a lot more hard-irqs than context switches per
second, and this is another fact. On a 4ghz cpu it doesn't matter, but
on a embedded it can matter, so the more reliable solution is obviously
higher performant too. Of the 50usec it takes to such project on
linuxdevices to execute probably a 10% of that is wasted in the irq
handling itself (ioapic hardware proper stuff).

Anyway I've more fun things to do on than to talk about hard-RT, which
I'm doing just with the aim to provide my little contribution in form of
IMHO valid criticism that you clearly don't appreciate.
