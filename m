Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRCDEWV>; Sat, 3 Mar 2001 23:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRCDEWK>; Sat, 3 Mar 2001 23:22:10 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.46.236]:6803 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S130017AbRCDEV6>; Sat, 3 Mar 2001 23:21:58 -0500
Message-Id: <200103040421.UAA28916@lotus.CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context 
In-Reply-To: Your message of "03 Mar 2001 17:17:47 CST."
             <vbar90eqw6c.fsf@mozart.stat.wisc.edu> 
Date: Sat, 03 Mar 2001 20:21:56 -0800
From: Jason Riedy <ejr@CS.Berkeley.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And Kevin Buhr writes:
 - 
 - > What Linux does presently on x86 is as right as right can be on 
 - > this platform.
 - 
 - I'm not so sure.

Let me rephrase:  According to a designer of the x87 and one
of the IEEE 754 authors, the behavior currently in Linux and
glibc is reasonable on x86.  Reasonable is the best you can 
hope for in floating-point.  

Double-rounding from intermediate spills isn't reasonable, but 
that's neither a kernel nor a C library issue.  Tackling that 
issue in the compiler is difficult.  MS punted and gcc's trying 
to get things right (or has, I've lost track, search for `XF', 
`mode', and `spill' in the archives).  If you want plain single- 
or double-precision arithmetic, use a recent IA-32 with SSE2 
instructions.

What I should have done in my first response was to refer you to
Doug Priest's supplement to David Goldberg's ``What Every Computer
Scientist Should Know about Floating-Point Arithmetic''.  Of course,
you need first read the paper itself.  You can find a copy at
  http://www.validgh.com/
Read it with paper, pencil, and calculator handy.  You'll want to
work out some examples for yourself.  The supplement covers the
issues well.

If you really want to get upset at operating systems, complain
about their lack of support for efficient floating-point exception
handling.  ;)  (Or search for wmexcp, which will kill that 
complaint on x86 Linux.)

Jason
