Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbUBXWo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUBXWmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:42:12 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:9621 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262510AbUBXWl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:41:58 -0500
Date: Tue, 24 Feb 2004 17:41:45 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: cw@f00f.org, <piggin@cyberone.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
In-Reply-To: <20040224143618.368dfdca.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0402241741330.21522-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Andrew Morton wrote:

> > I guess highmem allocations really should put some pressure on
> > lowmem, even when there is enough lowmem free, because otherwise
> > you end up effectively not using half of the memory on 1.5-2 GB
> > systems for paging ...
> 
> Yup.  With the current -mm patches the reclaim rate from lowmem and highmem
> is nicely proportional to each zone's size for pagecache-heavy workloads. 
> For lowmem-intensive workloads the reclaim rate from lowmem is higher, as
> one would expect.  It seems to be working OK now.

OK, that should do the trick.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

