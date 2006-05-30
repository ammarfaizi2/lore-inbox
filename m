Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWE3GQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWE3GQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWE3GQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:16:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34208 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932155AbWE3GQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:16:17 -0400
Date: Tue, 30 May 2006 08:16:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [-rt BUG] scheduling with irqs disabled: swapper
Message-ID: <20060530061630.GB19870@elte.hu>
References: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com> <1148692456.5381.7.camel@localhost.localdomain> <1148775233.30211.1.camel@leatherman> <1148778806.5381.11.camel@localhost.localdomain> <20060528064026.GA14665@elte.hu> <1148936590.30211.9.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148936590.30211.9.camel@leatherman>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> > the backtrace shows misrouted_irq(), which is only called if "irqfixup" 
> > is enabled. That indeed isnt supported in -rt yet.
> 
> Ugh. You and Steven are right. We've been bitten by this a few times, 
> but we thought we got rid of that option on all of our boxes. I guess 
> one slipped by.
> 
> Anyway, thanks for pointing that out. Would you consider a patch like 
> the following so that folks don't continue to slip over this?

sure, i've applied it. (fixed a small typo in the printout)

	Ingo
