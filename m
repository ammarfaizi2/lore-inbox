Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSFGISe>; Fri, 7 Jun 2002 04:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317095AbSFGISd>; Fri, 7 Jun 2002 04:18:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53764 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316959AbSFGISd>; Fri, 7 Jun 2002 04:18:33 -0400
Date: Fri, 7 Jun 2002 09:18:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: "'davem@redhat.com'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sparc64 pgalloc.h pgd_quicklist question
Message-ID: <20020607091826.A5413@flint.arm.linux.org.uk>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A78A3@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 09:10:40PM -0500, Holzrichter, Bruce wrote:
> I meant to ask this a little bit back, while I was looking through this
> code.  In the 2.5 iteration you have for small_page.c your using the
> next_hash and pprev_hash entries, which no longer are available in the
> struct page, as far as I have looked, unless your struct page is defined
> elsewhere, other than linux/mm.h?  Just wondering, as I pull apart the mm
> code in what time I have looking at this.

It looks like next_hash and pprev_hash migrated to list.  (I've not
confirmed that it obeys exactly the same rules yet.)  The solution
is probably to convert small-page.c to use the list stuff instead.

If you don't get there before me, I'll probably fix it up this weekend.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

