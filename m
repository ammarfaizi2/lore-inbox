Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVFJWww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVFJWww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFJWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:52:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7229
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261317AbVFJWwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:52:36 -0400
Date: Sat, 11 Jun 2005 00:52:31 +0200
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
Message-ID: <20050610225231.GF6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610223724.GA20853@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 03:37:24PM -0700, Bill Huey wrote:
> Some of the comments from various folks are just intolerably paranoid

Just tell me how can you go to a customer and tell him that your
linux-RTOS has a guaranteed worst case latency of 50usec.  How can you
tell that? Did you exercise all possible scheduler paths with cache
disabled and calculated the worst case latency with rdtsc + math?

Why do you take risks when you can go with much more relaible solutions
like RTAI and rtlinux?

Using metal-hard RTOS in things that requires ruby-hard deadline
guarantee, seems just an unnecessary risk. I'd prefer you to be
more paranoid and less relaxed about these issues, there are enough bugs
and risks even when one does the best and is very paranoid.

Said that there are many problems where metal-hard solutions are
fine, every single app that don't require a worst-case guarantee of
the worst-case latency is fine with metal-hard, and every time one has
to call into the alsa ioctl or other complex syscalls also is fine with
metal hard since the first kmalloc or lock contention inside RT context,
will send your RTOS into water-hard state.
