Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWGJJEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWGJJEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWGJJEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:04:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:20623 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751378AbWGJJE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:04:29 -0400
Date: Mon, 10 Jul 2006 10:58:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       mingo@redhat.com, Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need refcounting too
Message-ID: <20060710085849.GA6016@elte.hu>
References: <200607091458.52298.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607091458.52298.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5005]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> It's not just "normal" mode operation that needs refcounting for the 
> {en,dis}able_irq() calls ... "wakeup" mode calls need it too, for the 
> very same reasons.
> 
> This patch adds that refcounting.  I expect that some ARM drivers will 
> be triggering the new warning, but this call isn't yet widely used. 
> (Which is probably why the bug has lingered this long...)

Acked-by: Ingo Molnar <mingo@elte.hu>

we should also add disable_irq_wake() / enable_irq_wake() APIs and start 
migrating most ARM users over to the new APIs, agreed? That makes the 
APIs more symmetric and the code more readable too.

	Ingo

