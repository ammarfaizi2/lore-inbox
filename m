Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSLVMOv>; Sun, 22 Dec 2002 07:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSLVMOv>; Sun, 22 Dec 2002 07:14:51 -0500
Received: from ci.aac.uc.pt ([193.137.213.1]:64715 "EHLO ci.aac.uc.pt")
	by vger.kernel.org with ESMTP id <S266384AbSLVMOu>;
	Sun, 22 Dec 2002 07:14:50 -0500
Date: Sun, 22 Dec 2002 13:23:08 +0000 (WET)
From: Joao Seabra <seabra@aac.uc.pt>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel GCC Optimizations 
Message-ID: <Pine.LNX.4.33.0212221322260.12768-100000@ci.aac.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Zack Weinberg wrote:

>
> > > So, let's make it -O6 per default for 2.7.x/3.1.x?
> >
> > A higher -O setting does not necessarily mean better performance -
> > loop unrolling is one compiler optimisation that I *think* is
> > performed by GCC at high -O settings, and that *often* causes code to
> > be slower.
>
> In all official releases of GCC, -Ox, x >= 4, has exactly the same
> effect as -O3.  This is unlikely to change anytime soon.
>
> -O3 enables exactly two optimizations relative to -O2:
> -finline-functions and -frename-registers.  This may or may not change
> in the future.  It does *not* enable loop unrolling. -finline-functions
> is almost always a major performance loss, because it makes the code
> huge and blows out the I-cache.  I'm not familiar with the performance
> effects of -frename-registers; it might be worth experimenting with
> just that switch.
>


 Why do I see all the time using >O3 when in the gcc man/docs they say the
max Ox is 3 and above that it is assumed that is O3?
 -finline-functions makes a difference in C++ 8) but the number of inline
functions can be defined with finline-limit.Could you be more specific
about the major performance loss?

 Rename registers from the gcc 3.2 man:
"Attempt to avoid false dependencies in scheduled code by making
          use of registers left over after register allocation. This
          optimization will most benefit processors with lots of
          registers. It can, however, make debugging impossible, since
          variables will no longer stay in a "home register"."

 Making debugging impossible could be a problem in the kernel apart from
the performance :)

 Best Regards,

 Joao Seabra


