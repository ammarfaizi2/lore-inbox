Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHOGo7>; Thu, 15 Aug 2002 02:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSHOGo7>; Thu, 15 Aug 2002 02:44:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54931 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313711AbSHOGo6>;
	Thu, 15 Aug 2002 02:44:58 -0400
Date: Thu, 15 Aug 2002 08:49:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020815050343.A27963@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208150846120.2197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Jamie Lokier wrote:

> Is this correct?  I would have expected this, given that stacks are
> pre-decrement, and given that the value of `esp' is typically just after
> the end of an mmaped region:
> 
> +		childregs->esp -= sizeof(0UL);
> +		p->user_vm_lock = (long *) childregs->esp;

btw., i backported all the recent threading improvements to 2.4, and
current pthreads sources already use the new APIs, which worked this
CLONE_VM_RELEASE API uncleanliness around - but it's of course cleaner to
have your fix in. In any case, all the new APIs are fully functional.

	Ingo

