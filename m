Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbRGCIQ3>; Tue, 3 Jul 2001 04:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266477AbRGCIQK>; Tue, 3 Jul 2001 04:16:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:1527 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S266478AbRGCIP7>; Tue, 3 Jul 2001 04:15:59 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Your message of "Mon, 02 Jul 2001 14:26:34 EDT."
             <3B40BCDA.CFA5750E@mandrakesoft.com> 
Date: Tue, 03 Jul 2001 09:15:57 +0100
Message-ID: <3963.994148157@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> Russell King wrote:
> > 
> > On Mon, Jul 02, 2001 at 05:56:56PM +0100, Alan Cox wrote:
> > > Case 1:
> > >       You pass a single cookie to the readb code
> > >       Odd platforms decode it
> > 
> > Last time I checked, ioremap didn't work for inb() and outb().
> 
> It should :)

Surely it shouldn't... ioremap() is for mapping "memory-mapped I/O" resources
into the kernel's virtual memory scheme (at least on the i386 arch). There's
no way to tell the CPU/MMU that a particular pages should assert the IO access
pin rather than memory access pin (or however it is done externally).

David
