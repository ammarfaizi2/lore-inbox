Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313134AbSC1LUk>; Thu, 28 Mar 2002 06:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313135AbSC1LUa>; Thu, 28 Mar 2002 06:20:30 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:29105 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S313134AbSC1LUV>; Thu, 28 Mar 2002 06:20:21 -0500
Date: Thu, 28 Mar 2002 16:51:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kmem_cache_zalloc
Message-ID: <20020328165142.A23089@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20020327201917.A23810@phoenix.infradead.org> Christoph Hellwig wrote:

> I'd really go for k(mem_)zalloc, but a kmem_cache_alloc leads people toward
> writing bad code.  The purpose of the slab allocator is to allow caching
> readily constructed objects, a _zalloc destroys them on alloc.

I thought that the life span of an object is between 
kmem_cache_alloc and kmem_cache_free. If you are expecting caching 
beyond this, you may not get correct data. kmem_cache allocator
is supposed to quickly allocate fixed size structures avoiding
the need for frequent splitting and coalescing in the allocator.

Am I missing something here ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
