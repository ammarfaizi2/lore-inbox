Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269158AbUIRIAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269158AbUIRIAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUIRIAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 04:00:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44487 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269158AbUIRIAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 04:00:30 -0400
Date: Sat, 18 Sep 2004 10:02:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040918080214.GC31899@elte.hu>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu> <20040917125334.GA4954@elte.hu> <20040917205639.GB15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917205639.GB15426@dualathlon.random>
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


* Andrea Arcangeli <andrea@novell.com> wrote:

> [...] it still doesn't track the lock_kernel usage inside a spinlock,
> [...]

what do you mean? If something does lock_kernel() within spin_lock()
then the might_sleep() check in down() catches it and will print a
warning. (None of these warnings has triggered on any of my 3 systems
yet, suggesting that the problem is not widespread. In any case it's
very likely a _bug_ so we want to know!)

	Ingo
