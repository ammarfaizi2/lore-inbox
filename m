Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWHHTHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWHHTHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWHHTHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:07:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:148 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965036AbWHHTHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:07:01 -0400
Date: Tue, 8 Aug 2006 15:06:52 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Robert Crocombe <rcrocomb@gmail.com>
cc: hui Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re:
 Problems with 2.6.17-rt8
In-Reply-To: <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0608081506060.16824@gandalf.stny.rr.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> 
 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> 
 <1154541079.25723.8.camel@localhost.localdomain> 
 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> 
 <1154615261.32264.6.camel@localhost.localdomain>  <20060808025615.GA20364@gnuppy.monkey.org>
  <20060808030524.GA20530@gnuppy.monkey.org>
 <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Aug 2006, Robert Crocombe wrote:

> On 8/7/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> > > I tested it with a "make -j4" which triggers the warning and it they all
> > > go away now.
> > >
> > > Reverse patch attached:
>
> Unfortunately, this makes no difference on my setup.  Patch applied,
> made the obvious little change:
>
> -#include <linux/dobject.h>
> +#include <linux/kobject.h>
>
> But:
>
>
> kjournald/1119[CPU#1]: BUG in debug_rt_mutex_unlock at
> kernel/rtmutex-debug.c:471
>

Robert,

How far back do you get this bug?  I mean if you go back and test the
previous kernels, where did you start seeing this?

Thanks,

-- Steve
