Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275969AbRI1H6Y>; Fri, 28 Sep 2001 03:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275972AbRI1H6O>; Fri, 28 Sep 2001 03:58:14 -0400
Received: from chiara.elte.hu ([157.181.150.200]:45326 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275969AbRI1H6H>;
	Fri, 28 Sep 2001 03:58:07 -0400
Date: Fri, 28 Sep 2001 09:56:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <E15mnjA-0000sW-00@mail.tv-sign.ru>
Message-ID: <Pine.LNX.4.33.0109280953590.2196-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Oleg Nesterov wrote:

> > >  	current->nice = 19;
> > > -	schedule();
> > > -	__set_current_state(TASK_INTERRUPTIBLE);

your change is indeed correct. (the history if this is that the schedule()
was not always at the top of the loop - eg. it's not at the top of it in
the current -B2 patch.)

	Ingo

