Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317210AbSEXQ2m>; Fri, 24 May 2002 12:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSEXQ2l>; Fri, 24 May 2002 12:28:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39949 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317210AbSEXQ2l>; Fri, 24 May 2002 12:28:41 -0400
Date: Fri, 24 May 2002 17:28:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: bruce.holzrichter@monster.com, linux-kernel@vger.kernel.org
Subject: Re: sparc64 pgalloc.h pgd_quicklist question
Message-ID: <20020524172833.A11638@flint.arm.linux.org.uk>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A775C@nocmail101.ma.tmpw.net> <20020524.090526.105379973.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 09:05:26AM -0700, David S. Miller wrote:
>    From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
>    Date: Fri, 24 May 2002 11:12:25 -0500
>    
>    Anyway, After looking at the SMP and UP configuration in pgalloc.h, could
>    you simply remove the UP/SMP differentiation in the routines, as in my
>    attachment?  It looks to me, that the struct for pgt_quicklist is built
>    correctly for UP or SMP above this?  I could be wrong on this....
> 
> That would waste 3/4 of every page allocated for PGDs.
> 
> We use the pointers to keep track of which bits of the page
> are allocated to PGDs.  So how about rewriting our code to
> use bits in page->flags instead?

See arch/arm/mm/small_page.c (2.4) or arch/arm/mach-arc/small_page.c for
a sub-page allocator using page->flags.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

