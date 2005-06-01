Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFAUq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFAUq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFAUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:45:42 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:21772 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261215AbVFAUlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:41:47 -0400
Date: Wed, 1 Jun 2005 13:46:12 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601204612.GA27934@nietzsche.lynx.com>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601203212.GZ5413@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 10:32:12PM +0200, Andrea Arcangeli wrote:
> You don't know very much about local_irq_disable if you think it isn't
> smp safe in drivers.

Yes, I do. Look at the patch.

> local_irq_disable is perfectly safe in drivers, infact it's _needed_
> sometime to avoid race conditions with irqs.

Where ? Point it out.

> Now tell me what do you gain by keeping premept-RT "metal hard" and
> prone to break anytime somebody changes a device driver or some
> networking subsystem when you can do the "ruby hard" thing like RTAI and
> rtlinux do for years?
 
Long paths are audited and correct when instrumentation is triggered
by it. Look at the patch.

> The patch doesn't remove any local_irq_disable from drivers, nor it
> outlaws it.

Doesn't have to yet. Drivers are case by case problem as expected. Look
at the patch.

> It's you who has learn what local_irq_disable does, why it's obviously

Wrong. I did a parallel implementation of this patch and I understand
the issues very clearly. Deterministic single kernel RT isn't new or
novel in the RTOS world (LynxOS, SGI IRIX, ...).

> the _most_smp-safe_ function in the whole kernel (so much that it's the
> only one you can use to avoids locks around per-cpu data structures to
> get full scalability), and to grep for it in drivers and verify they're
> still there after applying the patch, and subject to modifications and
> brekages in future upgrades of the kernel.

Wrong.

Listen to what Ingo, me and others have said and read the patch. You're
way behind with these issues and have continued to ask really ridiculous
questions with looking at the patch. 6+ months of developement have gone
into the patch. Really, read the patch and stop asking question, spreading
FUD until then.

bill

