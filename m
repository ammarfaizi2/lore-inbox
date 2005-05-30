Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVE3SOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVE3SOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVE3SL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:11:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61084 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261668AbVE3SKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:10:44 -0400
Date: Mon, 30 May 2005 20:09:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050530180924.GA4647@elte.hu>
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <42978730.4040205@stud.feec.vutbr.cz> <20050528055322.GA14867@elte.hu> <429AE21C.2020309@stud.feec.vutbr.cz> <20050530143833.GA16609@elte.hu> <20050530145016.GA18433@elte.hu> <429B43AD.5060003@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B43AD.5060003@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> >* Ingo Molnar <mingo@elte.hu> wrote:
> >>agreed - i've added your patch to my tree.
> >
> >with a small modification: i turned the error into a link-time error, 
> >because gcc parses both branches and will give a compiler-time warning 
> >even if the proper compat_semaphore is used.
> 
> Oh, sorry. I actually had it produce a link-time error at first. But I 
> wanted so much to make it fail at compile time that I screwed it up and 
> didn't test both cases.
> 
> However, what you have in RT-V0.7.47-13 is still not correct. Now it 
> again produces only a warning :-)
> Patch attached. This time I really tested it in both cases. For struct 
> semaphore it fails at link-time. For struct compat_semaphore it compiles 
> without problems.

ok - released -14 with this fix.

	Ingo

