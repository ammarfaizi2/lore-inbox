Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSAIXPy>; Wed, 9 Jan 2002 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSAIXPo>; Wed, 9 Jan 2002 18:15:44 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:13067 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287833AbSAIXP1>;
	Wed, 9 Jan 2002 18:15:27 -0500
Date: Thu, 10 Jan 2002 10:15:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020109231513.GA10002@krispykreme>
In-Reply-To: <20020108114355.GA25718@krispykreme> <Pine.LNX.4.33.0201081533270.7255-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201081533270.7255-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > With the patch things look much better (and the kernel boots on my
> > ppc64 machine :)
> 
> hey it should not even compile, you forgot to send us the PPC definition
> of sched_find_first_zero_bit() ;-)

Good point, but its ppc64 so the patch would include all of
include/asm-ppc64 and arch/ppc64 :)

I expect most architectures have a reasonably fast find_first_zero_bit
so they can simply do:

static inline int sched_find_first_zero_bit(unsigned long *bitmap)
{
	return find_first_zero_bit(bitmap, MAX_PRIO);
}
