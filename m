Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbUK2P7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUK2P7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUK2P6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:58:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9175 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261743AbUK2P56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:57:58 -0500
Date: Mon, 29 Nov 2004 16:57:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041129155752.GA17828@elte.hu>
References: <20041129095941.GD7868@elte.hu> <Pine.OSF.4.05.10411291152050.14592-100000@da410.ifa.au.dk> <20041129155642.GA17663@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129155642.GA17663@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > iteration over a list which can be O(number of waiters * locking
> > depth) long. As long as we are in the kernel both is "controlled",
> > i.e. one can see the worst-case number in stress test and know it
> > can't get worse. *
> 
> which list do you mean? Note that the pi_list depends on the number of
> _RT-tasks_, not on the number of SCHED_NORMAL tasks. So you can create
> an arbitrary number of SCHED_NORMAL tasks, they wont impact the
> overhead of mutexes!
> 
> i very intentionally made it independent of nr-of-non-RT-tasks.

and i'm regularly testing this property with 'hackbench 50', which
creates over a 1000 wildly scheduling non-RT tasks. Latency is not
affected by such workloads.

	Ingo
