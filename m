Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUFZSK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUFZSK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUFZSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:10:57 -0400
Received: from [213.146.154.40] ([213.146.154.40]:38601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266353AbUFZSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:10:56 -0400
Date: Sat, 26 Jun 2004 19:10:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of UML in 2.6.8
Message-ID: <20040626181048.GA16323@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	BlaisorBlade <blaisorblade_spam@yahoo.it>,
	Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406261905.22710.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 07:05:22PM +0200, BlaisorBlade wrote:
> Andrew, what are the requisite for stable inclusion of the UML update inside 
> 2.6-mm (or directly 2.6.8)? Currently (splitting out a little piece, which 
> should not be included) we have almost all the stuff inside arch/um and 
> include/asm-um, the addition of <linux/ghash.h> and of two filesystems for 
> UML use only, and this little hunk (plus 2 uses of it inside 
> mm/page_alloc.c).
> 
> +#ifndef HAVE_ARCH_FREE_PAGE
> +static inline void arch_free_page(struct page *page, int order) { }
> +#endif
> 
> Could it go in as-is? I'm especially worried about having it included soon in 
> 2.6.8, since last time it entered -mm and stayed there just for one release.

Please send split patches.  E.g. linux/ghash.h should not ne reintroduced,
it's completely fuly.  Also your above arch_free_page needs some more
discussion.

