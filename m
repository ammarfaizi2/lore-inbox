Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWGJJSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWGJJSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWGJJSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:18:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25579 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932430AbWGJJSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:18:08 -0400
Date: Mon, 10 Jul 2006 11:12:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
       mingo@redhat.com, Andrew Victor <andrew@sanpeople.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch 2.6.18-rc1] genirq: {en,dis}able_irq_wake() need refcounting too
Message-ID: <20060710091230.GA7611@elte.hu>
References: <200607091458.52298.david-b@pacbell.net> <20060710085849.GA6016@elte.hu> <20060710091340.GA4400@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710091340.GA4400@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > we should also add disable_irq_wake() / enable_irq_wake() APIs and 
> > start migrating most ARM users over to the new APIs, agreed? That 
> > makes the APIs more symmetric and the code more readable too.
> 
> That _is_ the API anyway.  set_irq_wake() was never intended to be 
> called directly from drivers.

doh - right. So the patch is the right thing to do :-)

	Ingo
