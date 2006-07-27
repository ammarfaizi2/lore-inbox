Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWG0O3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWG0O3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWG0O3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:29:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:44761 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751335AbWG0O3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:29:35 -0400
Date: Thu, 27 Jul 2006 16:23:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Arjan Van de Ven <arjan@infradead.org>
Subject: Re: lockdep: results on ARM
Message-ID: <20060727142331.GA26040@elte.hu>
References: <20060727142425.GA5178@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727142425.GA5178@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> The best fix I've come up with which seems to work is:

> +#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
> +	p->hardirqs_enabled = 1;
> +#else
>  	p->hardirqs_enabled = 0;
> +#endif

yeah - that's the right solution - a new task's "soft" hardirq state 
should be initialized to the real irq-mode it starts up under.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
