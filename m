Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262841AbSJTOxN>; Sun, 20 Oct 2002 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbSJTOxN>; Sun, 20 Oct 2002 10:53:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30760 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262841AbSJTOxL>; Sun, 20 Oct 2002 10:53:11 -0400
Date: Sun, 20 Oct 2002 16:59:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Jaeger <aj@suse.de>
Cc: Andi Kleen <ak@muc.de>, Jeff Dike <jdike@karaya.com>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020145919.GU23930@dualathlon.random>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <u8lm4tcknv.fsf@gromit.moeb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u8lm4tcknv.fsf@gromit.moeb>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 03:19:32PM +0200, Andreas Jaeger wrote:
> Andi Kleen <ak@muc.de> writes:
> 
> > [full quote for context]
> >
> > On Sat, Oct 19, 2002 at 06:49:59AM +0200, Jeff Dike wrote:
> >> ak@muc.de said:
> >> > Guess you'll have some problems then with UML on x86-64, which always
> >> > uses vgettimeofday. But it's only used for gettimeofday() currently,
> >> > perhaps it's  not that bad when the UML child runs with the host's
> >> > time.
> >> 
> >> It's not horrible, but it's still broken.  There are people who depend
> >> on UML being able to keep its own time separately from the host.
> >> 
> >> > I guess it would be possible to add some support for UML to map own
> >> > code over the vsyscall reserved locations. UML would need to use the
> >> > syscalls then. But it'll be likely ugly. 
> >> 
> >> Yeah, it would be.
> >> 
> >> My preferred solution would be for libc to ask the kernel where the vsyscall
> >> area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
> >> because it adds a few instructions to the vsyscall address calculation.
> >
> > I would have no problems with adding that to the x86-64 kernel. It could
> > be passed in by the ELF environment vector and added to the ABI. 
> > Overhead should be negligible, it just needs a single table lookup.  
> > Andreas, what do you think ? 
> 
> Create a new AT_ constant, and pass it via the auxiliary vector and we
> can use it in glibc.

will it be a pointer to function?

Andrea
