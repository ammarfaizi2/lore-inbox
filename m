Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWEaUfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWEaUfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWEaUfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:35:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:21129 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964849AbWEaUfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:35:53 -0400
Date: Wed, 31 May 2006 22:36:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 3c59x.c disable_irq()
Message-ID: <20060531203609.GA882@elte.hu>
References: <20060531200900.GA32482@elte.hu> <1149107540.9978.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149107540.9978.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5012]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2006-05-31 at 22:09 +0200, Ingo Molnar wrote:
> > Subject: locking validator: special rule: 3c59x.c disable_irq()
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > 3c59x.c's vortex_timer() function knows that vp->lock can only be used
> > by an irq context that it disabled - and can hence take the vp->lock
> > without disabling hardirqs. Teach lockdep about this.
> 
> Ingo,
> 
> Did you update your
> http://people.redhat.com/mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch
> or did I miss the patch to add the disable_irq_lockdep function?

i've updated it now, please check it out. (i sent the generic 
disable_irq_lockdep() bits to lkml separately but forgot to Cc: you)

	Ingo
