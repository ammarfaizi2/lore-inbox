Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163360AbWLGU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163360AbWLGU7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163357AbWLGU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:59:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50638 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163354AbWLGU7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:59:20 -0500
Date: Thu, 7 Dec 2006 21:58:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
Message-ID: <20061207205819.GA21953@elte.hu>
References: <20061205171114.GA25926@elte.hu> <1165524358.9244.33.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165524358.9244.33.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Much better performance in terms of xruns with Jackd. Hardly any at 
> all as it should be. I'm starting to test -rt8 right now.
> 
> Now, I still don't have an smp machine to test so the improvement 
> could be because I'm just running 64 bit up instead of smp. Or it 
> could have been the hardware on that other machine that had some 
> problem (either because it was starting to fail or because the kernel 
> drivers for that hardware were somehow triggering the xruns).

i think it's the UP vs. SMP difference. We are chasing some SMP 
latencies right now that trigger on boxes that have deeper C sleep 
states. idle=poll seems to work around those problems.

	Ingo
