Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVCXKnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVCXKnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVCXKnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:43:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17868 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262771AbVCXKnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:43:17 -0500
Date: Thu, 24 Mar 2005 11:42:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324104206.GA20359@elte.hu>
References: <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com> <20050324053456.GA14494@elte.hu> <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> This way when process C tries to get the lock again, it sees that it's 
> owned, but B hasn't executed yet. So it would be safe for C to take 
> the lock back from B, that is if C is greater priority than B, 
> otherwise it would act the same.

agreed. In particular this would be a nice optimization for cases where 
tasks are delayed for a longer time due to CPU congestion (e.g. lots of 
tasks on the same SCHED_FIFO priority). So if a higher prio task comes 
along while the

> If you agree with this approach, I would be willing to write a patch 
> for you.

yeah - please do.

	Ingo
