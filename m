Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268002AbUHKJBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268002AbUHKJBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268003AbUHKJBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:01:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44217 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268002AbUHKJBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:01:18 -0400
Date: Wed, 11 Aug 2004 10:25:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040811082536.GA6528@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092210765.1650.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > (another thing: could you turn on CONFIG_DEBUG_HIGHMEM,
> > CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP? Lets make sure
> > that what we are seeing here is not somehow caused by atomicity
> > violations.)
> 
> I have highmem disabled per your previous request.  Should I turn it
> back on?

nope, please keep it disabled still. (You can turn the C3 CPU option
back on though, it doesnt seem to have any impact on latency.)

then it's just the spinlock debugging options that should be enabled. 
(they make sense on UP kernels too, if CONFIG_PREEMPT is enabled.)

	Ingo
