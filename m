Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWEOIFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWEOIFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWEOIFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:05:15 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47781 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751123AbWEOIFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:05:13 -0400
Date: Mon, 15 May 2006 10:04:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Galbraith <efault@gmx.de>, Florian Paul Schmidt <mista.tapas@gmx.net>,
       Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 scheduling latency testcase and failure data
Message-ID: <20060515080449.GA24523@elte.hu>
References: <200605121924.53917.dvhltc@us.ibm.com> <20060513112039.41536fb5@mango.fruits> <1147521338.7909.5.camel@homer> <Pine.LNX.4.58.0605131137070.27751@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605131137070.27751@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Careful, rt21 has a bug slipped in that might have funny results on 
> SMP machines:
> 
> +		if (!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
> +			set_cpus_allowed(current, irq_affinity[irq]);
> 
> John (although he later fixed it) added a ; after the if.  But the fix 
> is not yet in Ingo's patch.

ouch - i missed that. I've released -rt22 with this fix.

	Ingo
