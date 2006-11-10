Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946446AbWKJLMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946446AbWKJLMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946478AbWKJLMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:12:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61579 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946446AbWKJLMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:12:03 -0500
Date: Fri, 10 Nov 2006 12:10:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 11/19] i386: Rework local APIC calibration
Message-ID: <20061110111048.GA4780@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.340517000@cruncher.tec.linutronix.de> <1163153841.3138.653.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163153841.3138.653.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> > plain text document attachment (i386-lapic-calibrate-timer.patch)
> > From: Thomas Gleixner <tglx@linutronix.de>
> 
> One question: why do the irq measurement at all if pmtimer is 
> available?

the pmtimer read will always return zero on platforms where there's no 
pm-timer clock - in this case the irq measurement is what calibrates.

	Ingo
