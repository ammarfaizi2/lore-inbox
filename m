Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVL3IAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVL3IAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVL3IAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:00:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40838 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751208AbVL3IAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:00:51 -0500
Date: Fri, 30 Dec 2005 09:00:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051230080032.GA26152@elte.hu>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135908980.4568.10.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> It seems that debug_smp_processor_id is being called a lot, even 
> though I have a UP config, which I didn't see with the -rt kernel:

do you have CONFIG_DEBUG_PREEMPT enabled? (if yes then disable it)

> Was this optimized out on UP before?

no, because smp_processor_id() debugging is useful on UP too: it checks 
whether smp_processor_id() is every called with preemption enabled, and 
reports such bugs.

	Ingo
