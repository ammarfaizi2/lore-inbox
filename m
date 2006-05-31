Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWEaVdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWEaVdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWEaVdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:33:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:30400 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965169AbWEaVdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:33:23 -0400
Date: Wed, 31 May 2006 23:33:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531213340.GA3535@elte.hu>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E0A49.4050105@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5361]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> >AFAICS this isnt the lock validator but the normal mutex debugging code 
> >(CONFIG_DEBUG_MUTEXES). The log does not indicate that lockdep was 
> >enabled.
> 
> Buggered if I know how that got turned on. I thought we turned it off 
> by default now? That's what screwed up all the perf results before.
> 
> http://test.kernel.org/abat/33803/build/dotconfig
> That's the build config it ran with.
> 
> CONFIG_DEBUG_MUTEXES=y

still ... it shouldnt have crashed on us. I did change it in -mm1 so 
i'll take a look tomorrow.

> Grrr. Humpf. I can't see the option being turned on for lockdep ...
> what was the config option, and is it enabled by default?

these are the lock validator options in question:

 # CONFIG_PROVE_SPIN_LOCKING is not set
 # CONFIG_PROVE_RW_LOCKING is not set
 # CONFIG_PROVE_MUTEX_LOCKING is not set
 # CONFIG_PROVE_RWSEM_LOCKING is not set

and they are off by default.

	Ingo
