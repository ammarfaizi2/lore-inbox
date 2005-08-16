Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVHPRB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVHPRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVHPRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:01:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25791 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1030244AbVHPRB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:01:58 -0400
Date: Tue, 16 Aug 2005 19:02:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ryan Brown <some.nzguy@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050816170206.GA11332@elte.hu>
References: <20050816161226.GA2826@elte.hu> <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
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


* Alan Stern <stern@rowland.harvard.edu> wrote:

> In general yes, the patch should be okay.  But there are a few things 
> to check for.  Perhaps most of the USB drivers don't care whether 
> interrupts are enabled or not in their completion routines.  However I 
> know of at least one where it does matter.  The current code _is_ 
> SMP-safe, but it won't remain UP-safe unless you add this patch in 
> addition to your own.

ah, indeed. I've added this to the -RT tree too.

	Ingo
