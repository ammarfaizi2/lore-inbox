Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbSKNWFZ>; Thu, 14 Nov 2002 17:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKNWFY>; Thu, 14 Nov 2002 17:05:24 -0500
Received: from fmr06.intel.com ([134.134.136.7]:61923 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261609AbSKNWFW>; Thu, 14 Nov 2002 17:05:22 -0500
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA5AE0@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       Rohit Seth <rseth@unix-os.sc.intel.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, "Seth, Rohit" <rohit.seth@intel.com>,
       dada1 <dada1@cosmosbay.com>, Christoph Hellwig <hch@infradead.org>,
       Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: RE: [patch] remove hugetlb syscalls
Date: Thu, 14 Nov 2002 14:12:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: William Lee Irwin III [mailto:wli@holomorphy.com] 
> > 
> On Thu, Nov 14, 2002 at 12:11:32PM -0800, Rohit Seth wrote:
> > This is not the problem with MAP_SHARED.  It is the lack of  (arch
> > specific) hugepage aligned function support in the kernel. 
> You can use 
> > the mmap on hugetlbfs using only MAP_FIXED with properly aligned 
> > addresses (but then this also is only a hint to kernel).  
> With addr == 
> > NULL in mmap, the function is bound to fail almost all the times.
> 
> There's very little standing in the way of automatic 
> placement. If in your opinion it should be implemented, I'll 
> add that feature today.
> 
mmap with addr==NULL is in my opinion a very useful thing.

> IIRC you mentioned you would like to export the arch-specific 
> hugepage-aligned vma placement functions; once these are 
> available, it should be trivial to reuse them.
> 
> 
I will export those functions from arch specific trees.
