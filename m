Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSH1RI5>; Wed, 28 Aug 2002 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSH1RI5>; Wed, 28 Aug 2002 13:08:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42467 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316882AbSH1RI4>;
	Wed, 28 Aug 2002 13:08:56 -0400
Date: Wed, 28 Aug 2002 19:16:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr
In-Reply-To: <20020828163242.2c84747f.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0208281914100.2647-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Rusty Russell wrote:

> >  - HT-aware affinity.
> > 
> >    Tasks should attempt to 'stick' to physical CPUs, not logical CPUs.
> 
> Linus disagreed with this before when I discussed it with him, and with
> the current (stupid, non-portable, broken) set_affinity syscall he's
> right.

actually, affinity still works just fine, users can bind tasks to logical
CPUs as well. What i meant was the affinity logic of the scheduler (ie.  
affinity decisions done by the scheduler), not the externally visible
affinity API.

> You don't know if someone said "schedule me on cpu 0" because they
> really want to be scheduled on CPU 0, or because they really *don't*
> want to be scheduled on CPU 1 (where something else is running).  You
> can't just assume they are equivalent if they are the same physical CPU.

i dont assume that. There's also a fair amount of code in the kernel that
relies on binding threads to particular CPUs, the patch does not break
that in any way.

	Ingo

