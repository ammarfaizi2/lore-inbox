Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTJAPKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTJAPKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:10:19 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:51100 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262328AbTJAPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:10:12 -0400
Date: Wed, 1 Oct 2003 17:10:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001151011.GL31698@wohnheim.fh-wedel.de>
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk> <20031001143959.GI31698@wohnheim.fh-wedel.de> <20031001145206.GH29313@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001145206.GH29313@actcom.co.il>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 October 2003 17:52:06 +0300, Muli Ben-Yehuda wrote:
> > 
> > Index: include/linux/mm.h
> > ===================================================================
> > RCS file: /var/cvs/linux-2.6/include/linux/mm.h,v
> > retrieving revision 1.5
> > diff -u -p -r1.5 mm.h
> > --- a/include/linux/mm.h	28 Sep 2003 04:06:20 -0000	1.5
> > +++ b/include/linux/mm.h	1 Oct 2003 13:15:53 -0000
> > @@ -196,7 +196,7 @@ struct page {
> >  #if defined(WANT_PAGE_VIRTUAL)
> >  	void *virtual;			/* Kernel virtual address (NULL if
> >  					   not kmapped, ie. highmem) */
> > -#endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
> > +#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
> >  };
> 
> This is broken, the CONFIG_HIG(H)MEM shouldn't be there at all. Look
> at the #if defined(...) line. 

include/linux/mm.h:353:
#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
include/linux/mm.h:199:
#endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */

Ah, crud!  The comment fits perfectly, it just sits at the wrong
position.  Agreed, no comments are better than wrong comments.

Scrap my patch.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
