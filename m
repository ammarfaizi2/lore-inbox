Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVKVKWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVKVKWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKVKWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:22:41 -0500
Received: from ns2.suse.de ([195.135.220.15]:44460 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932241AbVKVKWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:22:40 -0500
Date: Tue, 22 Nov 2005 11:22:37 +0100
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Mel Gorman <mel@csn.ul.ie>, Andi Kleen <ak@suse.de>, linux-mm@kvack.org,
       mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
Message-ID: <20051122102237.GK20775@brahms.suse.de>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie> <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet> <200511160252.05494.ak@suse.de> <Pine.LNX.4.58.0511160200530.8470@skynet> <4382EF48.1050107@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4382EF48.1050107@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All of that said, I am not even sure we have a bit left in the page
> flags on smaller architectures :/.

How about

#define PG_checked               8      /* kill me in 2.5.<early>. */

?

At least PG_uncached isn't used on many architectures too, so could
be reused. I don't know why those that use it don't check VMAs instead.

-Andi
