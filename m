Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265741AbSJTCun>; Sat, 19 Oct 2002 22:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265742AbSJTCun>; Sat, 19 Oct 2002 22:50:43 -0400
Received: from zero.aec.at ([193.170.194.10]:61962 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265741AbSJTCum>;
	Sat, 19 Oct 2002 22:50:42 -0400
Date: Sun, 20 Oct 2002 04:56:09 +0200
From: Andi Kleen <ak@muc.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jeff Dike <jdike@karaya.com>, Andi Kleen <ak@muc.de>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020025609.GA15342@averell>
References: <200210190450.XAA06161@ccure.karaya.com> <Pine.LNX.4.44L.0210192349220.22993-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210192349220.22993-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 03:50:37AM +0200, Rik van Riel wrote:
> On Fri, 18 Oct 2002, Jeff Dike wrote:
> 
> > My preferred solution would be for libc to ask the kernel where the
> > vsyscall area is.  That's reasonably clean and virtualizable.  Andrea
> > doesn't like it because it adds a few instructions to the vsyscall
> > address calculation.
> 
> Sounds like the best solution indeed, especially when keeping
> in mind the strange people who want to run with a different
> user:kernel split or statically linked binaries at fun addresses
> so they've got more space for their fortran arrays ;)

x86-64 addresses that (not that it would need it) by putting vsyscalls at 
the top of the virtual mapping after the direct mapped area. This part
never moves even with changed __PAGE_OFFSET. The same technique should work 
on i386 too.

-Andi
