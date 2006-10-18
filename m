Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWJRIwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWJRIwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWJRIwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:52:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:8126 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932124AbWJRIwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:52:46 -0400
Date: Wed, 18 Oct 2006 10:45:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: UNWIND_INFO slowdown in -mm1
Message-ID: <20061018084502.GA13618@elte.hu>
References: <20060928192048.GA17436@elte.hu> <45351782.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45351782.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.2i
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


* Jan Beulich <jbeulich@novell.com> wrote:

> >in 2.6.18-mm1 we are seeing _really_ long delays in the unwind code. 
> >(full trace attached) On an Athlon64 3800+ CPU:
> 
> Below patch should help, can you try it out? Short of the linker 
> supporting building a binary lookup table at build time, it creates 
> one as soon as the bootmem allocator is usable (so you'll continue 
> using the linear lookup for the first [hopefully] few calls). The code 
> should be ready to utilize a build-time created table once a fixed 
> linker becomes available.

i tried this ontop of -git and it builds and boots fine, and the bootup 
speed problems seem to be gone. Thanks!

> Signed-off-by: Jan Beulich <jbeulich@novell.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
