Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUJOWnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUJOWnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUJOWnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:43:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14503 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266486AbUJOWnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:43:13 -0400
Subject: Re: [PATCH] reduce fragmentation due to kmem_cache_alloc_node
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097863727.2861.43.camel@dyn318077bld.beaverton.ibm.com>
References: <41684BF3.5070108@colorfullife.com>
	 <1097863727.2861.43.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097879593.2861.61.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Oct 2004 15:33:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 11:08, Badari Pulavarty wrote:

> 
> I see size-64 "inuse" objects increasing. Eventually, it fills
> up entire low-mem. I guess while freeing up scsi-debug disks,
> is not cleaning up all the allocations :(
> 
> But one question I have is - Is it possible to hold size-64 slab,
> because it has a management allocation (slabp - 40 byte allocations)
> from alloc_slabmgmt() ?  I remember seeing this earlier. Is it worth
> moving all managment allocations to its own slab ? should I try it ?

Nope. Moving "slabp" allocations to its own slab, didn't fix anything.
I guess scsi-debug is not cleaning up properly :(

Thanks,
Badari

