Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVEXQDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVEXQDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVEXQBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:01:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55241 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262112AbVEXP4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:56:41 -0400
Date: Tue, 24 May 2005 17:56:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "K.R. Foley" <kr@cybsft.com>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524155619.GA21570@elte.hu>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <42930E79.1030305@cybsft.com> <42934674.30406@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42934674.30406@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Well, yes. There are lots of things Linux isn't suited for. There are 
> likewise a lot of patches that SGI would love to get into the kernel 
> so it runs better on their 500+ CPU systems. [...]

this reminds me. PREEMPT_RT found a handful of SMP races that not even
100+ CPU systems triggered in any deterministic way.

(I have mentioned this before but it seems worth repeating: the
preemption model of PREEMPT_RT is similar to a SMP Linux kernel running
on an system that has an 'infinite' number of CPUs. Each task can be
thought of having its own separate CPU - and SMP-alike instruction
overlap can happen at any instruction boundary.)

So the very small meets (and helps) the very large in interesting ways.
PREEMPT_RT very much depends on a good SMP implementation and on a good
CONFIG_PREEMPT implementation. The synergies are much wider than just
enabling deterministic behavior in embedded systems.

	Ingo
