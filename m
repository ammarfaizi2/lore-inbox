Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVFAJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFAJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFAJU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:20:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49614 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261349AbVFAJUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:20:21 -0400
Date: Wed, 1 Jun 2005 11:19:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050601091908.GA13041@elte.hu>
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4294E24E.8000003@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Hi Ingo,
> 
> I'm now running -RT-2.6.12-rc4-V0.7.47-08 on amd64. I use cpufreq, but 
> with the RT kernel it triggers "Kernel BUG at "kernel/latency.c":1295" 
> (the check for preempt_count underflow).
> 
> I'm attaching a patch which changes a semaphore in cpufreq into a 
> completion. With this patch, my system runs OK even with cpufreqd.

btw., could you please submit this upstream too, so that it doesnt get 
lost? Semaphore->completion conversions are desirable upstream for cases 
where the semaphore was in reality not used for mutual exclusion but for 
completion purposes. (in which case real completions are both more 
readable and slightly faster)

	Ingo
