Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934025AbWKTJN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934025AbWKTJN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934026AbWKTJN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:13:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28884 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S934025AbWKTJNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:13:25 -0500
Date: Mon, 20 Nov 2006 10:12:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       samuel@sortiz.org, irda-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, arjan <arjan@infradead.org>
Subject: Re: 2.6.19-rc5: lockdep warnings starting irattach
Message-ID: <20061120091218.GA19940@elte.hu>
References: <200611181612.36008.arvidjaar@mail.ru> <1164013486.5968.133.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164013486.5968.133.camel@twins>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3617]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> The comment at the nesting lock says:
> 
> 	/* Careful for priority inversions here !
> 	 * irlmp->links is never taken while another IrDA
> 	 * spinlock is held, so we are safe. Jean II */
> 
> So, under the assumption the author was right, it just needs a lockdep
> annotation.
> 
> (depends on patches in -mm for spin_lock_irqsave_nested())
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
