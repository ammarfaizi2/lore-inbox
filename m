Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRDKA5R>; Tue, 10 Apr 2001 20:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132512AbRDKA5I>; Tue, 10 Apr 2001 20:57:08 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:19950 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S132503AbRDKA4x>;
	Tue, 10 Apr 2001 20:56:53 -0400
Date: Wed, 11 Apr 2001 02:56:32 +0200
From: David Weinehall <tao@acc.umu.se>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411025632.C21221@khan.acc.umu.se>
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de> <E14n6Be-0005Ir-00@the-village.bc.nu> <20010411020058.B28670@gruyere.muc.suse.de> <20010411021318.A21221@khan.acc.umu.se> <20010411022028.A28874@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010411022028.A28874@gruyere.muc.suse.de>; from ak@suse.de on Wed, Apr 11, 2001 at 02:20:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 02:20:28AM +0200, Andi Kleen wrote:
> On Wed, Apr 11, 2001 at 02:13:18AM +0200, David Weinehall wrote:
> > > 
> > > Yes, and with CMPXCHG handler in the kernel it wouldn't be needed 
> > > (the other 686 optimizations like memcpy also work on 386) 
> > 
> > But the code would be much slower, and it's on 386's and similarly
> > slow beasts you need every cycle you can get, NOT on a Pentium IV.
> 
> My reasoning is that who uses a 386 is not interested in speed, so a little
> bit more slowness is not that bad.

My reasoning is that the choice of computer is a direct function of
your financial situation. I can get hold of a lot of 386's/486's, but
however old a Pentium may be, people are still reluctant to give away
those. Doing the sometimes necessary updates on my 386:en is already
painfully slow, and I'd rather not take another performance hit.

> You realize that the alternative for distributions is to drop 386 support
> completely?

Yes, I realise that. But if _distribution X_ drops support for the 386,
there's always _distribution Y_ available with it still in, while if
we give the glibc-people the thumbs up saying "Ignore the 386 users from
now on", every distribution will get lousy performance on those machines.

> Most 386 i've seen used for linux do not run multi threaded applications
> anyways; they usually do things like ISDN routing. Also on early 386 with
> the kernel mode wp bug it's a security hazard to use clone().

Well, not all 386:en are early...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
