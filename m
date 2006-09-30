Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751968AbWI3U5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWI3U5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWI3U5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:57:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14776 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751968AbWI3U5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:57:15 -0400
Date: Sat, 30 Sep 2006 22:49:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-ID: <20060930204900.GA576@elte.hu>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <200609302230.24070.ak@suse.de> <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I mean, really: Andi, point me to anything that was a real problem 
> when we had no unwinder at all?

personally, i like perfect stacktraces, alot. x86_64 was a huge pain for 
me without the unwinder. I got so used to perfect backtraces on i686 
(when using %ebp frames) during the years, and i had to look at _many_ 
backtraces with lockdep. On x86_64 it was just constant brain-drain to 
think away bogus stack entries. Yes, i can do it no problem when i have 
to look at only a few stacktraces per day, but if it's hundreds per day 
it's _alot_ of brainpower wasted.

(i'd have been happy with an %rbp based unwinder for x86_64, in fact i 
implemented it for lockdep and used it for some time on x86_64, but Andi 
wanted a dwarf-based, lower-overhead one. Andi also nicely integrated it 
into stacktrace.c.)

	Ingo
