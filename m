Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315181AbSDWSPz>; Tue, 23 Apr 2002 14:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315291AbSDWSPy>; Tue, 23 Apr 2002 14:15:54 -0400
Received: from zero.tech9.net ([209.61.188.187]:55570 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315181AbSDWSPx>;
	Tue, 23 Apr 2002 14:15:53 -0400
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204231722330.16139-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 14:15:54 -0400
Message-Id: <1019585756.1470.133.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 11:23, Ingo Molnar wrote:

> On 23 Apr 2002, Robert Love wrote:
>
> > Now the hard part is abstracting sched_find_first_set for an arbitrary
> > MAX_RT_PRIO.
> 
> i'd suggest the following: keep the current hand-optimized one for the
> bitrange it's good for, and use the find_bit variant for all other values.  
> (We had this before, check out some of the older versions of the O(1)  
> scheduler.)

In earlier releases we have

	include/asm-i386/mmu_context.h :: sched_find_first_zero_bit

but that seems to operate on a 168-bit bitmap only.  Around what time
did we have a routine that operated on arbitrary maps?  What name/file?

Thanks,

	Robert Love

