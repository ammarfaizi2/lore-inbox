Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132497AbRDKAU7>; Tue, 10 Apr 2001 20:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDKAUu>; Tue, 10 Apr 2001 20:20:50 -0400
Received: from ns.suse.de ([213.95.15.193]:15116 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132497AbRDKAUj>;
	Tue, 10 Apr 2001 20:20:39 -0400
Date: Wed, 11 Apr 2001 02:20:28 +0200
From: Andi Kleen <ak@suse.de>
To: David Weinehall <tao@acc.umu.se>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411022028.A28874@gruyere.muc.suse.de>
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de> <E14n6Be-0005Ir-00@the-village.bc.nu> <20010411020058.B28670@gruyere.muc.suse.de> <20010411021318.A21221@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411021318.A21221@khan.acc.umu.se>; from tao@acc.umu.se on Wed, Apr 11, 2001 at 02:13:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 02:13:18AM +0200, David Weinehall wrote:
> > 
> > Yes, and with CMPXCHG handler in the kernel it wouldn't be needed 
> > (the other 686 optimizations like memcpy also work on 386) 
> 
> But the code would be much slower, and it's on 386's and similarly
> slow beasts you need every cycle you can get, NOT on a Pentium IV.

My reasoning is that who uses a 386 is not interested in speed, so a little
bit more slowness is not that bad.

You realize that the alternative for distributions is to drop 386 support
completely?

Most 386 i've seen used for linux do not run multi threaded applications
anyways; they usually do things like ISDN routing. Also on early 386 with
the kernel mode wp bug it's a security hazard to use clone().

-Andi

