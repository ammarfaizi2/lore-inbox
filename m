Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWI3Vdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWI3Vdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWI3Vdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:33:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63926 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751338AbWI3Vdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:33:51 -0400
Date: Sat, 30 Sep 2006 23:25:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-ID: <20060930212524.GA6332@elte.hu>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <200609302230.24070.ak@suse.de> <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org> <20060930204900.GA576@elte.hu> <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
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

> It could - and _should_ dammit! - do some basic sanity tests like "is 
> the thing even in the same stack page"? But nooo... It seems 
> _designed_ to be fragile and broken.
>
> Here's a simple test: if the next stack-slot isn't on the same page, 
> the unwind information is bogus unless you had the IRQ stack-switch 
> signature there. Does the code do that? No. It just assumes that 
> unwind information is complete and perfect.

fully agreed - i have pointed out areas of conceptual fragility to Jan 
early on:

  http://lkml.org/lkml/2006/6/2/59

(but AFAICS i got no reply to that mail - i missed that in the lockdep 
flurry.)

	Ingo
