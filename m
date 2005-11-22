Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVKVTkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVKVTkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVKVTkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:40:12 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:34538 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965146AbVKVTkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:40:10 -0500
Date: Tue, 22 Nov 2005 19:40:04 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andi Kleen <ak@suse.de>, Andy Whitcroft <apw@shadowen.org>,
       linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
In-Reply-To: <4382F765.4020707@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0511221937290.2476@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet>
 <200511160252.05494.ak@suse.de> <Pine.LNX.4.58.0511160200530.8470@skynet>
 <4382EF48.1050107@shadowen.org> <20051122102237.GK20775@brahms.suse.de>
 <Pine.LNX.4.58.0511221026200.31192@skynet> <4382F765.4020707@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:
> > On Tue, 22 Nov 2005, Andi Kleen wrote:
> >
> >
> > > > All of that said, I am not even sure we have a bit left in the page
> > > > flags on smaller architectures :/.
> > >
> > > How about
> > >
> > > #define PG_checked               8      /* kill me in 2.5.<early>. */
> > >
> > > ?
> > >
> > > At least PG_uncached isn't used on many architectures too, so could
> > > be reused. I don't know why those that use it don't check VMAs instead.
> > >
> >
> >
> > PG_unchecked appears to be totally unused. It's only users are the macros
> > that manipulate the bit and mm/page_alloc.c . It appears it has been a
> > long time since it was used to it is a canditate for reuse.
> >
> Considering memory hotplug, I don't want to resize bitmaps at hot-add/remove.
> no bitmap is welcome :)
>

Version has now been posted that has no usemap with the subject "Light
fragmentation avoidance without usemap". Details on implementation and
benchmarks are included.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
