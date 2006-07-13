Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWGMMtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWGMMtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWGMMtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:49:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37507 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030182AbWGMMtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:49:12 -0400
Date: Thu, 13 Jul 2006 14:43:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Albert Cahalan <acahalan@gmail.com>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
Message-ID: <20060713124316.GA18852@elte.hu>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <20060713070445.GA30842@elte.hu> <20060713092432.GA11812@elte.hu> <200607131437.28727.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607131437.28727.ak@suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> On Thursday 13 July 2006 11:24, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > > utrace enables something like 'transparent live debugging': an app
> > > crashes in your distro, a window pops up, and you can 'hand over' a
> > > debugging session to a developer you trust. Or you can instruct the
> > > system to generate a coredump. Or you can generate a shorter summary
> > > of the crash, sent to a central site.
> >
> > not to mention that utrace could be used to move most of the ELF
> > coredumping code out of the kernel. (the moment you have access to all
> > crashed threads userspace can construct its own coredump - instead of
> > having the kernel construct a coredump file) Roland's patch does not go
> > as far yet, but it could be a possible target.
> 
> I'm not sure that's particularly useful (I think I would prefer to 
> keep it in kernel), [...]

why would we want to keep this in the kernel? Coredumping in the kernel 
is fragile, and it's nowhere near performance-critical to really live 
within the kernel.

	Ingo
