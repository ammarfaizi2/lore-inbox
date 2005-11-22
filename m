Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVKVKfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVKVKfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVKVKfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:35:54 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:51380 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964903AbVKVKfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:35:53 -0500
Date: Tue, 22 Nov 2005 10:35:44 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andi Kleen <ak@suse.de>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
In-Reply-To: <20051122102237.GK20775@brahms.suse.de>
Message-ID: <Pine.LNX.4.58.0511221026200.31192@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet>
 <200511160252.05494.ak@suse.de> <Pine.LNX.4.58.0511160200530.8470@skynet>
 <4382EF48.1050107@shadowen.org> <20051122102237.GK20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Andi Kleen wrote:

> > All of that said, I am not even sure we have a bit left in the page
> > flags on smaller architectures :/.
>
> How about
>
> #define PG_checked               8      /* kill me in 2.5.<early>. */
>
> ?
>
> At least PG_uncached isn't used on many architectures too, so could
> be reused. I don't know why those that use it don't check VMAs instead.
>

PG_unchecked appears to be totally unused. It's only users are the macros
that manipulate the bit and mm/page_alloc.c . It appears it has been a
long time since it was used to it is a canditate for reuse.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
