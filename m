Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVE3Ouw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVE3Ouw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVE3Ouw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:50:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51076 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261615AbVE3Oun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:50:43 -0400
Date: Mon, 30 May 2005 16:50:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050530145016.GA18433@elte.hu>
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <42978730.4040205@stud.feec.vutbr.cz> <20050528055322.GA14867@elte.hu> <429AE21C.2020309@stud.feec.vutbr.cz> <20050530143833.GA16609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530143833.GA16609@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> 
> > Thanks for the explanation. In that case calling init_MUTEX_LOCKED on 
> > an RT semaphore is obviously wrong. However, it only produces a 
> > warning during the compilation and is guaranteed to BUG when run. It 
> > would be better if it obviously failed to compile. How about the 
> > attached patch? That makes the compilation fail like this:
> 
> agreed - i've added your patch to my tree.

with a small modification: i turned the error into a link-time error, 
because gcc parses both branches and will give a compiler-time warning 
even if the proper compat_semaphore is used.

	Ingo
