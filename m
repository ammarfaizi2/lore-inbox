Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVEXH7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVEXH7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 03:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVEXH7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 03:59:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54227 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261431AbVEXH7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 03:59:40 -0400
Date: Tue, 24 May 2005 09:59:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
Message-ID: <20050524075927.GA20462@elte.hu>
References: <20050509073702.GA13615@elte.hu> <427FBFE1.5020204@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427FBFE1.5020204@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> Also, I think that del_timer_sync and friends need to be turned on if 
> soft_irq is preemptable.

you mean the #ifdef CONFIG_SMP should be:

	#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)

?

	Ingo
