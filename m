Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWIFJvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWIFJvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIFJvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:51:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21914 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750749AbWIFJvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:51:13 -0400
Date: Wed, 6 Sep 2006 11:43:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
Message-ID: <20060906094301.GA8694@elte.hu>
References: <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8430.1157534853@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4966]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> john stultz <johnstul@us.ibm.com> wrote:
> 
> > From this patch it looks like the FRV arch could be trivially 
> > converted to GENERIC_TIME.
> > 
> > Would you consider the following, totally untested patch?
> 
> It certainly looks interesting.  I'll have to study the clocksource 
> stuff - some FRV CPUs have an effective TSC.

btw., would be nice to convert it to genirq (and irqchips) too =B-) That 
would solve the kind of disable_irq_lockdep() breakage that was reported 
recently.

	Ingo
