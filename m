Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVE0Hc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVE0Hc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVE0Hc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:32:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59110 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261948AbVE0H3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:29:52 -0400
Date: Fri, 27 May 2005 09:21:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
Message-ID: <20050527072119.GA7267@elte.hu>
References: <20050509073702.GA13615@elte.hu> <427FBFE1.5020204@mvista.com> <20050524075927.GA20462@elte.hu> <429339CC.1080705@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429339CC.1080705@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> Ingo Molnar wrote:
> >* George Anzinger <george@mvista.com> wrote:
> >
> >
> >>Also, I think that del_timer_sync and friends need to be turned on if 
> >>soft_irq is preemptable.
> >
> >
> >you mean the #ifdef CONFIG_SMP should be:
> >
> >	#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
> >
> >?
> Yes, exactly.

i have done this in -47-09 and it seems to work fine - is it sufficient?

	Ingo
