Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRDKABc>; Tue, 10 Apr 2001 20:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132491AbRDKABW>; Tue, 10 Apr 2001 20:01:22 -0400
Received: from ns.suse.de ([213.95.15.193]:5899 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129282AbRDKABH>;
	Tue, 10 Apr 2001 20:01:07 -0400
Date: Wed, 11 Apr 2001 02:00:58 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411020058.B28670@gruyere.muc.suse.de>
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de> <E14n6Be-0005Ir-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14n6Be-0005Ir-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 11:00:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 11:00:31PM +0100, Alan Cox wrote:
> > I guess 386 could live with an exception handler that emulates it.
> 
> 386 could use a simpler setup and is non SMP

The idea was to have a `generic' kernel that works on all architectures.
If you drop 386 support much is better already.
 
> > (BTW an generic exception handler for CMPXCHG would also be very useful
> > for glibc -- currently it has special checking code for 386 in its mutexes) 
> > The 386 are so slow that nobody would probably notice a bit more slowness
> > by a few exceptions.
> 
> Be serious. You can compile glibc without 386 support. Most vendors already
> distribute 386/586 or 386/686 glibc sets.

Yes, and with CMPXCHG handler in the kernel it wouldn't be needed 
(the other 686 optimizations like memcpy also work on 386) 

-Andi
