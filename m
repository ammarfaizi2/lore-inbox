Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266421AbRGCCGy>; Mon, 2 Jul 2001 22:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266422AbRGCCGp>; Mon, 2 Jul 2001 22:06:45 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39077 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266421AbRGCCGc>;
	Mon, 2 Jul 2001 22:06:32 -0400
Message-ID: <3B4128A5.636ED850@mandrakesoft.com>
Date: Mon, 02 Jul 2001 22:06:29 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <E15HA1D-0006W0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > >       You pass a single cookie to the readb code
> > > >       Odd platforms decode it
> > >
> > > Last time I checked, ioremap didn't work for inb() and outb().
> >
> > It should :)
> 
> it doesnt need to.
> 
> pci_find_device returns the io address and can return a cookie, ditto
> isapnp etc

Is the idea here to mitigate the amount of driver code changes, or
something else?

If you are sticking a cookie in there behind the scenes, why go ahead
and use ioremap?

We -already- have a system which does remapping and returns cookies and
such for PCI mem regions.  Why not use it for I/O regions too?

	Jeff


-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
