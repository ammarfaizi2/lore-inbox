Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVELWJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVELWJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVELWJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:09:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43470 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262155AbVELWJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:09:49 -0400
Subject: Re: [-mm patch] mm.h: fix page_zone compile error
From: Dave Hansen <haveblue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
In-Reply-To: <20050512214258.GC3603@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org>
	 <20050512214258.GC3603@stusta.de>
Content-Type: text/plain
Date: Thu, 12 May 2005 15:09:37 -0700
Message-Id: <1115935777.21206.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 23:42 +0200, Adrian Bunk wrote:
> On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc3-mm3:
> >...
> > +sparsemem-memory-model.patch
> >...
> >  More sparsemem stuff
> >...
>
> This causes the following compile error with gcc 3.4 on i386:
> 
> <--  snip  -->
> 
> ...
>   CC      mm/hugetlb.o
> mm/hugetlb.c: In function `enqueue_huge_page':
> include/linux/mm.h:500: sorry, unimplemented: inlining failed in call to 
> 'page_zone': function not considered for inlining
> mm/hugetlb.c:486: sorry, unimplemented: called from here
> make[1]: *** [mm/hugetlb.o] Error 1
> make: *** [mm] Error 2

Any idea what actually causes that?

BTW, it doesn't seem to happen with gcc 2.95.  Can you send me
your .config?  I'll double-check.

-- Dave

