Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVCJW4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVCJW4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263421AbVCJWwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:52:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:178 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263361AbVCJWqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:46:54 -0500
Date: Thu, 10 Mar 2005 14:46:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <1110490683.24355.17.camel@localhost>
Message-ID: <Pine.LNX.4.58.0503101445090.15150@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <1110490683.24355.17.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Dave Hansen wrote:

> > +extern void clear_pages (void *page, int order);
> >  extern void copy_page (void *to, void *from);
> > +#define clear_page(__page) clear_pages(__page, 0)
> > +#define __HAVE_ARCH_CLEAR_PAGES
>
> Although this is a simple instance, could this please be done in a
> Kconfig file?  If that #define happens inside of other #ifdefs, it can
> be quite hard to decipher the special .config incantation to get it set.
> On the other hand, if the dependencies are spelled out in a Kconfig
> entry...

Ok will do.

> BTW, I tried applying this to 2.6.11-bk6, and it rejected:
> ...
> patching file include/asm-i386/page.h
> Hunk #2 FAILED at 28.
> 1 out of 2 hunks FAILED -- saving rejects to file
> include/asm-i386/page.h.rej
> ...
>
> There were some more rejects as well.  Were there some other patches
> applied first?

Patches work fine here.
