Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWE1Gke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWE1Gke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 02:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWE1Gke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 02:40:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51164 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932784AbWE1Gkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 02:40:33 -0400
Date: Sun, 28 May 2006 08:40:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [-rt BUG] scheduling with irqs disabled: swapper
Message-ID: <20060528064026.GA14665@elte.hu>
References: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com> <1148692456.5381.7.camel@localhost.localdomain> <1148775233.30211.1.camel@leatherman> <1148778806.5381.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148778806.5381.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Thanks, but I was looking more into the code, and I'm wondering... 
> Does this machine have "irqfixup" or "irqpoll" set in the kernel 
> command line?
> 
> I think that -rt doesn't support it yet.  That is, it can call a 
> handler from interrupt context, which should have been a thread.
> 
> Let me know if that was the case.

the backtrace shows misrouted_irq(), which is only called if "irqfixup" 
is enabled. That indeed isnt supported in -rt yet.

	Ingo
