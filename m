Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWFGInY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFGInY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWFGInY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:43:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14785 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750916AbWFGInX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:43:23 -0400
Date: Wed, 7 Jun 2006 10:42:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: genirq
Message-ID: <20060607084246.GA31896@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060606144242.GB29798@elte.hu> <1149613010.15050.1.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149613010.15050.1.camel@c-67-180-134-207.hsd1.ca.comcast.net>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Tue, 2006-06-06 at 16:42 +0200, Ingo Molnar wrote:
> 
> > there hasnt been any real problem since the MSI one. The core bits are 
> > rather stable. The patch-queue had positive input from the maintainers 
> > of the two architectures with the most complex IRQ hardware (arm and 
> > ppc*), and that's reassuring. But in any case, other architectures are 
> > not affected at all (sans brow paperbag build bugs and typos), their 
> > __do_IRQ() handling remains unchanged. So i'd like to see this in 
> > 2.6.18. (there a good deal of stuff we have ontop of genirq)
> 
> There was a problem reported by Kevin Hillman , the -v5 version was 
> not functional on ARM omap boards .. Was that handled already in -v6?

Daniel - you should be aware that the -mm genirq lineup does _not_ 
include the ARM bits. Those changes go via the normal ARM QA and merge 
path, i.e. via rmk. The -mm lineup only includes the generic bits (for 
type-based platforms). In any case, they dont impact upstream genirq 
merging plans.

(The omap thing in the armirq queue is likely some small thing. Thomas 
is checking it.)

	Ingo
