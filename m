Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132514AbRDKBYW>; Tue, 10 Apr 2001 21:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDKBYM>; Tue, 10 Apr 2001 21:24:12 -0400
Received: from ns.suse.de ([213.95.15.193]:25871 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132514AbRDKBYB>;
	Tue, 10 Apr 2001 21:24:01 -0400
Date: Wed, 11 Apr 2001 03:23:54 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, David Weinehall <tao@acc.umu.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411032354.A29422@gruyere.muc.suse.de>
In-Reply-To: <20010411030739.A29277@gruyere.muc.suse.de> <Pine.LNX.4.31.0104101809260.15069-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104101809260.15069-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Apr 10, 2001 at 06:12:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 06:12:12PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 11 Apr 2001, Andi Kleen wrote:
> >
> > Fixup for user space is probably not that nice (CMPXCHG is used there by
> > linuxthreads)
> 
> In user space I'm not convinced that you couldn't do the same thing
> equally well by just having the proper dynamically linked library.  You'd
> not get in-lined lock primitives, but that's probably fine.

It's currently done this way, ld-linux.so looks in a special "686" path when
the ELF vector mentions it, otherwise normal path. There is a special 686
version of glibc and linuxthread. Just it's a very complicated and disk 
space chewing solution for a simple problem (some distributions are starting 
to drop support for 386 because of that)

-Andi
