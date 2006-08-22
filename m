Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWHVKw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWHVKw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWHVKw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:52:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42724 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932161AbWHVKw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:52:26 -0400
Date: Tue, 22 Aug 2006 12:44:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] futex_find_get_task: don't take tasklist_lock
Message-ID: <20060822104446.GB28183@elte.hu>
References: <20060821170621.GA1643@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821170621.GA1643@oleg>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> It is ok to do find_task_by_pid() + get_task_struct() under 
> rcu_read_lock(), we cand drop tasklist_lock.
> 
> Note that testing of ->exit_state is racy with or without tasklist 
> anyway.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

yeah. (We did this in the -rt tree for some time too, never saw any 
problems.)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
