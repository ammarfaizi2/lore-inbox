Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932964AbWFWJYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWFWJYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWFWJYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:24:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19095 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932960AbWFWJYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:24:07 -0400
Date: Fri, 23 Jun 2006 11:19:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 17/61] lock validator: sk_callback_lock workaround
Message-ID: <20060623091912.GA4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212427.GQ3155@elte.hu> <20060529183409.32b8896b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183409.32b8896b.akpm@osdl.org>
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

> On Mon, 29 May 2006 23:24:27 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > temporary workaround for the lock validator: make all uses of 
> > sk_callback_lock softirq-safe. (The real solution will be to express 
> > to the lock validator that sk_callback_lock rules are to be 
> > generated per-address-family.)
> 
> Ditto.  What's the actual problem being worked around here, and how's 
> the real fix shaping up?

this patch should be moot meanwhile. Earlier versions of the lock 
validator produced false positives for certain read-locking constructs.

i have undone the patch:

  lock-validator-sk_callback_lock-workaround.patch

and there doesnt seem to be any false positives popping up. Please dont 
remove it from -mm yet, i'll test this some more and will do the removal 
in the lock validator queue refactoring, ok?

	Ingo
