Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbUKWIUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUKWIUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUKWIUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:20:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57248 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262330AbUKWIT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:19:26 -0500
Date: Tue, 23 Nov 2004 10:21:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041123092152.GA5061@elte.hu>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com> <41A1F4B2.10401@timesys.com> <20041122152452.GA2036@elte.hu> <41A2902A.5050308@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A2902A.5050308@timesys.com>
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


* john cooper <john.cooper@timesys.com> wrote:

> >>I'd hazard a guess the reason existing implementations do not do this
> >>type of dependency-chain closure is the complexity of a general
> >>approach. [...]
> >
> >
> >please take a look at the latest patch, it is i believe handling all the
> >cases correctly. It certainly appears to solve the cases uncovered by
> >pi_test.
> 
> Yes I see where you are walking the dependency chain
> in pi_setprio().  But this is under the global spinlock
> 'pi_lock'.
> 
> My earlier comment was of the difficulty to establish fine
> grained locking, [...]

the issues raised in the paper and in this thread were much more
fundamental than SMP-scalability. Considering the costs of a hard-RT
mutex approach itself i dont think SMP-scalability is a primary issue
right now.

> [...]  However I'd offer there is more concurrency possible in this
> design.

yeah, most likely - but correctness comes first. SMP scalability is
something that can be done later.

	Ingo
