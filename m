Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSFPPWI>; Sun, 16 Jun 2002 11:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSFPPWH>; Sun, 16 Jun 2002 11:22:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39311 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316194AbSFPPWH>;
	Sun, 16 Jun 2002 11:22:07 -0400
Date: Sun, 16 Jun 2002 17:19:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@mvista.com>
Cc: "David S. Miller" <davem@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
In-Reply-To: <1024075953.4799.224.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206161710240.7461-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Jun 2002, Robert Love wrote:

> > Ummm what is with all of those switch_mm() hacks?  Is this an attempt
> > to work around the locking problems?  Please don't do that as it is
> > going to kill performance and having ifdef sparc64 sched.c changes is
> > ugly to say the least.
> >
> > Ingo posted the correct fix to the locking problem with the patch
> > he posted the other day, that is what should go into the -ac patches.
> 
> I am explicitly refraining from sending Alan any code that is not
> well-tested in 2.5 and my machines first.  As Ingo's new switch_mm()
> bits are not even in 2.5 yet, [...]

Linus applied them already, they will be in 2.5.22. They fix real bugs and
i've seen no problems on my testboxes. Those bits are a must for SMP x86
and Sparc64 as well, there is absolutely no reason to selectively delay
their backmerge. Besides the last task_rq_lock() optimization which got
undone in 2.5 already, all the recent scheduler bits i posted are needed.

	Ingo

