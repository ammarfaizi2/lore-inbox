Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132493AbRDKAOH>; Tue, 10 Apr 2001 20:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRDKAN7>; Tue, 10 Apr 2001 20:13:59 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:13037 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S132493AbRDKANr>;
	Tue, 10 Apr 2001 20:13:47 -0400
Date: Wed, 11 Apr 2001 02:13:18 +0200
From: David Weinehall <tao@acc.umu.se>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411021318.A21221@khan.acc.umu.se>
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de> <E14n6Be-0005Ir-00@the-village.bc.nu> <20010411020058.B28670@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010411020058.B28670@gruyere.muc.suse.de>; from ak@suse.de on Wed, Apr 11, 2001 at 02:00:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 02:00:58AM +0200, Andi Kleen wrote:
> On Tue, Apr 10, 2001 at 11:00:31PM +0100, Alan Cox wrote:
> > > I guess 386 could live with an exception handler that emulates it.
> > 
> > 386 could use a simpler setup and is non SMP
> 
> The idea was to have a `generic' kernel that works on all architectures.
> If you drop 386 support much is better already.
>  
> > > (BTW an generic exception handler for CMPXCHG would also be very useful
> > > for glibc -- currently it has special checking code for 386 in its mutexes) 
> > > The 386 are so slow that nobody would probably notice a bit more slowness
> > > by a few exceptions.
> > 
> > Be serious. You can compile glibc without 386 support. Most vendors already
> > distribute 386/586 or 386/686 glibc sets.
> 
> Yes, and with CMPXCHG handler in the kernel it wouldn't be needed 
> (the other 686 optimizations like memcpy also work on 386) 

But the code would be much slower, and it's on 386's and similarly
slow beasts you need every cycle you can get, NOT on a Pentium IV.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
