Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVF2TaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVF2TaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVF2TaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:30:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34794 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262479AbVF2T3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:29:36 -0400
Date: Wed, 29 Jun 2005 21:29:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Realtime Preemption - 2.6.12-final-RT-V0.7.50-35
Message-ID: <20050629192916.GA6079@elte.hu>
References: <Pine.LNX.4.63.0506291005390.4929@ghostwheel.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0506291005390.4929@ghostwheel.llnl.gov>
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


* Chuck Harding <charding@llnl.gov> wrote:

> still having sox hang with no messages about what is going on. I have 
> CONFIG_DEBUG_PREEMPT enabled. It did work without hanging for about 50 
> times of playing a sound file, so the problem seems to take a bit of 
> time to develop. What other info would you need to figure this out?

could you chrt the sound IRQ thread to SCHED_OTHER (audio performance 
will suck, but it will be more debuggable) - when the lockup happens, do 
you see the IRQ thread looping? Do you have SOFTLOCKUP_DETECT turned on 
too?

	Ingo
