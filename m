Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSIWNve>; Mon, 23 Sep 2002 09:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbSIWNve>; Mon, 23 Sep 2002 09:51:34 -0400
Received: from crack.them.org ([65.125.64.184]:28944 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261415AbSIWNvd>;
	Mon, 23 Sep 2002 09:51:33 -0400
Date: Mon, 23 Sep 2002 09:56:29 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Mark Veltzer <mark@veltzer.org>
Cc: Con Kolivas <conman@kolivas.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
Message-ID: <20020923135629.GA11792@nevyn.them.org>
Mail-Followup-To: Mark Veltzer <mark@veltzer.org>,
	Con Kolivas <conman@kolivas.net>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1032750261.3d8e84b5486a9@kolivas.net> <1032750631.966.1003.camel@phantasy> <1032751018.3d8e87aa99cc2@kolivas.net> <200209231106.g8NB63d10555@www.veltzer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209231106.g8NB63d10555@www.veltzer.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 02:06:01PM +0300, Mark Veltzer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 23 September 2002 06:16, Con Kolivas wrote:
> 
> > >
> > > Ugh??  Something is _seriously_ messed up here.
> >
> 
> The most important question to ask here is: What flags did you compile both 
> ?!? I wouldn't count on the flags that were designed for gcc 2.95 to be any 
> good for 3.2... Could the original poster comment on this ?
> 
> Any GCC maintainers on this list to comment ? Is there any set of flags to be 
> passed to gcc 3.2 to replicate 2.95 behaviour ? I wouldn't rule out gcc 3.2 
> having a totaly different set of optimizations geared towards user space C++. 
> Again, any gcc maintainers comments ?!? 
> 
> Since most of the code in gcc is for C++ most of the changes in gcc should 
> have been geared towards C++ (yes - quite a monstrous language). It seems to 
> me that the changes in C compilation between 2.95 and 3.2 should be minor 
> EXCEPT in terms of C optimization. Can anyone with assembly knowledge take 
> apart two identical drivers and see the better machine code produced by 2.95 
> as compared to 3.2 ? If so - can this be reported to the gcc folk ?
> 
> It seems to me that the difference is so huge that even user space 
> applications could show the difference. I suggest compiling a large C program 
> (emphasis on the C) in user space and doing the comparison... I would guess 
> that this should have been done by the gcc folk but because of the 
> hideousness of the C++ language I would guess that they mostly concentrated 
> on C++ and didn't bother to benchmark regular C optimization. This is quite 
> awful as the bulk of lower level open source code is in C and not C++ so this 
> kind of test has a lot of meaning for any distribution that is going to be 
> based on gcc 3.2...
> 
> If this benchmark turns out to be right then it seems to me that the only 
> conclusion is that the gcc folk let their interest in aesoteric features of 
> C++ (which has about 1/2 a billion of those) override the basic need for 
> strong C optimization. Yes - it now seems that the C++ language (which is 
> quite an abomination in terms of engineering and the KISS principle) is 
> actually hurting open source (which has been my conclusion for quite some 
> time).

Mark, if you followed the GCC development process you'd realize that
all of your above ranting about C++ is completely unfounded.  Most
people doing performance work - and there are a good number of them -
focus on language-independent optimizations and check them primarily in
C.

And I've no idea what you mean by "EXCEPT in terms of C optimization". 
First of all you're completely wrong - 3.2 supports most of C99, which
is substantial - and secondly, of course the bulk of changes in support
for a language are optimization.  And those are substantial too.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
