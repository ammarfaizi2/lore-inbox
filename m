Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUJSKcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUJSKcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUJSK36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:29:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40406 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268203AbUJSJs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:48:56 -0400
Date: Tue, 19 Oct 2004 11:50:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041019095013.GA19456@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <1098173546.12223.737.camel@thomas> <20041019090428.GA17204@elte.hu> <1098176615.12223.753.camel@thomas> <20041019093414.GA18086@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019093414.GA18086@elte.hu>
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

> so, could you try the init_MUTEX_LOCKED() fix plus the patch below -
> does that turn off the deadlock assert? (Plus also uncomment the
> RWSEM_BUG() around line 130.)

but i agree with you that this semaphore (ab-)use in the NFS code should
be fixed. Best would be to use a completion, but unfortunately there's
no wait_for_completion_timeout() API right now.

	Ingo
