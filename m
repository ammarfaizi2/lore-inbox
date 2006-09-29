Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161429AbWI2SsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161429AbWI2SsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbWI2SsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:48:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1262 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161429AbWI2SsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:48:15 -0400
Date: Fri, 29 Sep 2006 20:39:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
       tilman@imap.cc
Subject: Re: [2.6.18-rc7-mm1] slow boot
Message-ID: <20060929183959.GA13991@elte.hu>
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org> <451BFFA9.4030000@imap.cc> <200609281912.01858.ak@suse.de> <451C58AC.5060601@imap.cc> <20060928163046.055b3ce0.rdunlap@xenotime.net> <20060928163046.055b3ce0.rdunlap@xenotime.net> <451C65A0.1080002@imap.cc> <451CE2F0.76E4.0078.0@novell.com> <p73lko2ircn.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73lko2ircn.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
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


* Andi Kleen <ak@suse.de> wrote:

> "Jan Beulich" <jbeulich@novell.com> writes:
> 
> > There's nothing stack trace/unwind related among the functions listed at all afaics.
> > I don't know much about how profiling works, is it perhaps just missing something?
> 
> Perhaps lockdep calls them with interrupts off? The old profiler 
> doesn't support profiling with interrupts off. oprofile does, but it 
> cannot be used at early boot.

Yes, lockdep does everything that changes the dependency graph(s) with 
irqs off. Jan, i bounced you the mail with the function traces included, 
that should show you the overhead points.

	Ingo
