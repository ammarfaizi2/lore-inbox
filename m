Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVJFPMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVJFPMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJFPMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:12:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:50387 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751083AbVJFPMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:12:16 -0400
Date: Thu, 6 Oct 2005 16:12:07 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-mm@kvack.org, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/7] Fragmentation Avoidance V16: 002_usemap
In-Reply-To: <20051005.163847.73221396.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0510061610390.1255@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
 <20051005144557.11796.2110.sendpatchset@skynet.csn.ul.ie>
 <20051005.163847.73221396.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, David S. Miller wrote:

> From: Mel Gorman <mel@csn.ul.ie>
> Date: Wed,  5 Oct 2005 15:45:57 +0100 (IST)
>
> > +	unsigned int type = 0;
>  ...
> > +	bitidx = pfn_to_bitidx(zone, pfn);
> > +	usemap = pfn_to_usemap(zone, pfn);
> > +
>
> There seems no strong reason not to use "unsigned long" for "type" and
> besides that will provide the required alignment for the bitops
> interfaces.  "unsigned int" is not sufficient.
>

There is no strong reason. I'll convert them to unsigned longs and check
for implicit type conversions.

> Then we also don't need to thing about "does this work on big-endian
> 64-bit" and things of that nature.
>

Always a plus.

> Please audit your other bitops uses for this issue.
>

I will. Thanks

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
