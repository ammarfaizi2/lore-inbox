Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVFCOBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVFCOBC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFCOBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:01:02 -0400
Received: from dvhart.com ([64.146.134.43]:25511 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261271AbVFCOA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:00:57 -0400
Date: Fri, 03 Jun 2005 07:00:59 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jschopp@austin.ibm.com, linux-mm@kvack.org,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <370550000.1117807258@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0506031349280.10779@skynet>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie>  <429E20B6.2000907@austin.ibm.com><429E4023.2010308@yahoo.com.au>  <423970000.1117668514@flay><429E483D.8010106@yahoo.com.au>  <434510000.1117670555@flay><429E50B8.1060405@yahoo.com.au>  <429F2B26.9070509@austin.ibm.com><1117770488.5084.25.camel@npiggin-nld.site> <Pine.LNX.4.58.0506031349280.10779@skynet>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does it need more documentation? If so, I'll write up a detailed blurb on
> how it works and drop it into Documentation/
> 
>> Although I can't argue that a buddy allocator is no good without
>> being able to satisfy higher order allocations.
> 
> Unfortunately, it is a fundemental flaw of the buddy allocator that it
> fragments badly. The thing is, other allocators that do not fragment are
> also slower.

Do we care? 99.9% of allocations are fronted by the hot/cold page cache
now anyway ... and yes, I realise that things popping in/out of that 
obviously aren't going into the "defrag" pool, but still, it should help.
I suppose all we're slowing down is higher order allocs anyway, which
is the uncommon case, but ... worth thinking about.

M.

