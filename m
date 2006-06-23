Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932968AbWFWJgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbWFWJgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbWFWJgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:36:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3979 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932968AbWFWJgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:36:13 -0400
Date: Fri, 23 Jun 2006 11:30:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 22/61] lock validator:  add per_cpu_offset()
Message-ID: <20060623093059.GC4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212457.GV3155@elte.hu> <20060529183458.ebb74ff8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183458.ebb74ff8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +#define per_cpu_offset(x) (__per_cpu_offset(x))
> > +
> >  /* Separate out the type, so (int[3], foo) works. */
> >  #define DEFINE_PER_CPU(type, name) \
> >      __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
> 
> I can tell just looking at it that it'll break various builds.I assume 
> that things still happen to compile because you're presently using it 
> in code which those architectures don't presently compile.
> 
> But introducing a "generic" function invites others to start using it.  
> And they will, and they'll ship code which "works" but is broken, 
> because they only tested it on x86 and x86_64.
> 
> I'll queue the needed fixups - please check it.

[belated reply] They look good.

	Ingo
