Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVBMM7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVBMM7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 07:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBMM7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 07:59:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24228 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261266AbVBMM73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 07:59:29 -0500
Date: Sun, 13 Feb 2005 13:59:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050213125920.GA10256@elte.hu>
References: <20050211082841.GA3349@elte.hu> <000601c5101f$8ca3c1e0$c800a8c0@mvista.com> <20050211100405.GA7452@elte.hu> <1108158547.21183.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108158547.21183.60.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> Here's a trivial patch to help others from freaking out when they see
> on a show_trace that most of their processes are TASK_UNINTERRUPTIBLE. 

thanks, applied it to -39-00.

> -	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
> +	static const char *stat_nam[] = { "R", "M", "S", "D", "T", "t", "Z", "X" };

> I figure that "M" would be a good fit for TASK_RUNNING_MUTEX.

yeah - it's "M" already in fs/proc/array.c, but i missed the sched.c
case.

	Ingo
