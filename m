Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946478AbWKJLOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946478AbWKJLOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946504AbWKJLOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:14:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30919 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946478AbWKJLOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:14:21 -0500
Date: Fri, 10 Nov 2006 12:13:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110111316.GB4780@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061110011336.008840cf.akpm@osdl.org> <1163154958.3138.671.camel@laptopd505.fenrus.org> <200611101147.26081.ak@suse.de> <1163156158.3138.677.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163156158.3138.677.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > Most systems don't have C3 right now. And on those that have 
> > (laptops) it tends to be not that critical because they normally 
> > don't run workload where gettimeofday() is really time critical (and 
> > nobody expects them to be particularly fast anyways)
> 
> and that got changed when the blade people decided to start using 
> laptop processors ......

and some systems disable the lapic in C2 already: BIOSs started doing 
lowlevel-C3 in their C2 functionality and lie to the OS about it.

	Ingo
