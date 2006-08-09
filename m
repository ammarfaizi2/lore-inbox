Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWHIAgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWHIAgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWHIAgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:36:12 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:45760
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1030373AbWHIAgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:36:11 -0400
Date: Tue, 8 Aug 2006 17:35:56 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Darren Hart <dvhltc@us.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060809003556.GA4826@gnuppy.monkey.org>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 11:46:40AM -0700, Robert Crocombe wrote:
> Unfortunately, this makes no difference on my setup.  Patch applied,
> made the obvious little change:
... 
> kjournald/1119[CPU#1]: BUG in debug_rt_mutex_unlock at
> kernel/rtmutex-debug.c:471
> 
> Call Trace:
>       <ffffffff804875c3>{_raw_spin_lock_irqsave+34}
>       <ffffffff8022cc37>{__WARN_ON+105}
>       <ffffffff8022cbf2>{__WARN_ON+36}
>       <ffffffff80248933>{debug_rt_mutex_unlock+204}
...

I'll get on this as well. At least one problem was fixed with previous
patch.

bill


