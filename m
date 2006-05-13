Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWEMQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWEMQgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWEMQgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:36:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:39615 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932436AbWEMQgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:36:08 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Florian Paul Schmidt <mista.tapas@gmx.net>,
       Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0605131137070.27751@gandalf.stny.rr.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060513112039.41536fb5@mango.fruits> <1147521338.7909.5.camel@homer>
	 <Pine.LNX.4.58.0605131137070.27751@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sat, 13 May 2006 18:36:22 +0200
Message-Id: <1147538182.7562.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 11:39 -0400, Steven Rostedt wrote:
> Careful, rt21 has a bug slipped in that might have funny results on SMP
> machines:
> 
> +		if (!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
> +			set_cpus_allowed(current, irq_affinity[irq]);
> 
> John (although he later fixed it) added a ; after the if.  But the fix is
> not yet in Ingo's patch.

I saw that go by, and fixed it before building.  Mine is a UP build
anyway.

	-Mike

