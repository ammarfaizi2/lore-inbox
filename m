Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315284AbSDWSR4>; Tue, 23 Apr 2002 14:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315292AbSDWSRz>; Tue, 23 Apr 2002 14:17:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61606 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315284AbSDWSRy>;
	Tue, 23 Apr 2002 14:17:54 -0400
Date: Tue, 23 Apr 2002 18:14:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
In-Reply-To: <1019585756.1470.133.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0204231813080.20614-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Apr 2002, Robert Love wrote:

> > i'd suggest the following: keep the current hand-optimized one for the
> > bitrange it's good for, and use the find_bit variant for all other values.  
> > (We had this before, check out some of the older versions of the O(1)  
> > scheduler.)
> 
> In earlier releases we have
> 
> 	include/asm-i386/mmu_context.h :: sched_find_first_zero_bit
> 
> but that seems to operate on a 168-bit bitmap only.  Around what time
> did we have a routine that operated on arbitrary maps?  What name/file?

hm, perhaps it was only my own internal version then.

in any case, you can use the find_first_zero_bit() library function i
added for exactly this purpose. Any problems with that? It wont be the
fastest option, but it will do.

	Ingo

