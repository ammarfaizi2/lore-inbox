Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSFGCL3>; Thu, 6 Jun 2002 22:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSFGCL2>; Thu, 6 Jun 2002 22:11:28 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:47139 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S316604AbSFGCL0>; Thu, 6 Jun 2002 22:11:26 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A78A3@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>,
        "'davem@redhat.com'" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: sparc64 pgalloc.h pgd_quicklist question
Date: Thu, 6 Jun 2002 21:10:40 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
> On Fri, May 24, 2002 at 09:05:26AM -0700, David S. Miller wrote:
> >    From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
> >    Date: Fri, 24 May 2002 11:12:25 -0500
> >    
> >    Anyway, After looking at the SMP and UP configuration in 
> pgalloc.h, could
> >    you simply remove the UP/SMP differentiation in the 
> routines, as in my
> >    attachment?  It looks to me, that the struct for 
> pgt_quicklist is built
> >    correctly for UP or SMP above this?  I could be wrong on this....
> > 
> > That would waste 3/4 of every page allocated for PGDs.
> > 
> > We use the pointers to keep track of which bits of the page
> > are allocated to PGDs.  So how about rewriting our code to
> > use bits in page->flags instead?
> 
> See arch/arm/mm/small_page.c (2.4) or 
> arch/arm/mach-arc/small_page.c for
> a sub-page allocator using page->flags.
> 

Russell, 

I meant to ask this a little bit back, while I was looking through this
code.  In the 2.5 iteration you have for small_page.c your using the
next_hash and pprev_hash entries, which no longer are available in the
struct page, as far as I have looked, unless your struct page is defined
elsewhere, other than linux/mm.h?  Just wondering, as I pull apart the mm
code in what time I have looking at this.

Thanks
Bruce H.


