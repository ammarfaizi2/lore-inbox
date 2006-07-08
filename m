Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWGHHky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWGHHky (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 03:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWGHHky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 03:40:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11733 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751263AbWGHHkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 03:40:53 -0400
Date: Sat, 8 Jul 2006 09:36:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708073621.GA6788@elte.hu>
References: <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com> <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com> <20060707220954.GA23651@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707220954.GA23651@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > [...] In fact, your spin-lock code already inserts "rep nops" and I 
> > never implied that they should be removed. I said only that "volatile" 
> > still needs to be used, not some macro that tells the compiler that 
> > everything in memory probably got trashed. [...]
> 
> your position here does seem to make much sense to me, so please help me 
                         ^--- not
> understand it. You suggest that the assembly code should be left alone. 
> But then why do you need the volatile keyword to begin with?
