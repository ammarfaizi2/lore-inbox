Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDKM2R>; Wed, 11 Apr 2001 08:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDKM2H>; Wed, 11 Apr 2001 08:28:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6412 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132563AbRDKM1y>; Wed, 11 Apr 2001 08:27:54 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: ak@suse.de (Andi Kleen)
Date: Wed, 11 Apr 2001 13:28:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        torvalds@transmeta.com (Linus Torvalds),
        dhowells@cambridge.redhat.com (David Howells),
        andrewm@uow.edu.au (Andrew Morton), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010411020058.B28670@gruyere.muc.suse.de> from "Andi Kleen" at Apr 11, 2001 02:00:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nJjm-0006X8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 386 could use a simpler setup and is non SMP
> 
> The idea was to have a `generic' kernel that works on all architectures.
> If you drop 386 support much is better already.

Having the 386 non SMP only means you dont have to worry about this. We dont
currently support an SMP kernel that boots reliably on all non SMP boxes.
At least not officially although current 2.4 seems close.

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

They would still be needed. The 686 built glibc materially improves performance
on 686 class machines. That one isnt an interesting problem to solve. Install
the right software instead.


