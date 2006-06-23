Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933000AbWFWKZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbWFWKZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932998AbWFWKZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:25:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31196 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933000AbWFWKZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:25:42 -0400
Date: Fri, 23 Jun 2006 12:20:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 21/61] lock validator: lockdep: add local_irq_enable_in_hardirq() API.
Message-ID: <20060623102045.GM4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212452.GU3155@elte.hu> <20060529183428.0d12052e.akpm@osdl.org> <20060623092852.GB4889@elte.hu> <20060623025237.10ac3f68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623025237.10ac3f68.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > Also, trace_irqflags.h doesn't seem an appropriate place for it to 
> > > live.
> > 
> > seems like the most practical place for it. Previously we had no 
> > central include file for irq-flags APIs (they used to be included 
> > from asm/system.h and other random per-arch places) - 
> > trace_irqflags.h has become the central file now. Should i rename it 
> > to irqflags.h perhaps, to not tie it to tracing? We have some 
> > deprecated irq-flags ops in interrupt.h, maybe this all belongs 
> > there. (although i think it's cleaner to have 
> > linux/include/irqflags.h and include it from interrupt.h)
> > 
> 
> Yes, irqflags.h is nice.

ok, done.

	Ingo
