Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWGEUwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWGEUwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWGEUwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:52:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36263 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964982AbWGEUwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:52:01 -0400
Date: Wed, 5 Jul 2006 22:47:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705204727.GA16615@elte.hu>
References: <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu> <20060705025349.eb88b237.akpm@osdl.org> <20060705102633.GA17975@elte.hu> <20060705113054.GA30919@elte.hu> <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 5 Jul 2006, Andrew Morton wrote:
> > 
> > OK, but what happened to the 35-bytes-per-callsite saving?
> 
> I really don't think it existed.
> 
> Maybe there's something else going on. In particular, I wonder if 
> sections like the "debug_loc" fection end up being counted towards 
> text-size? They never actually get _loaded_, but they can be 
> absolutely enormous if CONFIG_DEBUG_INFO is enabled.

i had CONFIG_DEBUG_INFO (and UNWIND_INFO) disabled in all these build 
tests.

	Ingo
