Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUKSItk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUKSItk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbUKSItk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:49:40 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15289 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261298AbUKSIti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:49:38 -0500
Date: Fri, 19 Nov 2004 10:51:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@novell.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] no need to recalculate rq
Message-ID: <20041119095122.GB27642@elte.hu>
References: <1100837616.4051.17.camel@localhost.localdomain> <1100839146.20622.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100839146.20622.22.camel@localhost>
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


* Robert Love <rml@novell.com> wrote:

> -		deactivate_task(p, task_rq(p));
> +		deactivate_task(p, rq);
>  	retval = 0;
>  	oldprio = p->prio;
>  	__setscheduler(p, policy, lp.sched_priority);
>  	if (array) {
> -		__activate_task(p, task_rq(p));
> +		__activate_task(p, rq);

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
