Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSKNUdH>; Thu, 14 Nov 2002 15:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSKNUdH>; Thu, 14 Nov 2002 15:33:07 -0500
Received: from holomorphy.com ([66.224.33.161]:28362 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265201AbSKNUdG>;
	Thu, 14 Nov 2002 15:33:06 -0500
Date: Thu, 14 Nov 2002 12:36:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rohit Seth <rseth@unix-os.sc.intel.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, rohit.seth@intel.com,
       dada1 <dada1@cosmosbay.com>, Christoph Hellwig <hch@infradead.org>,
       Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114203648.GL23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rohit Seth <rseth@unix-os.sc.intel.com>,
	Benjamin LaHaise <bcrl@redhat.com>, rohit.seth@intel.com,
	dada1 <dada1@cosmosbay.com>, Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet> <20021114141310.A25747@infradead.org> <002b01c28bf0$751a3960$760010ac@edumazet> <20021114103147.A17468@redhat.com> <3DD40374.9050001@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD40374.9050001@unix-os.sc.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 12:11:32PM -0800, Rohit Seth wrote:
> This is not the problem with MAP_SHARED.  It is the lack of  (arch 
> specific) hugepage aligned function support in the kernel. You can use 
> the mmap on hugetlbfs using only MAP_FIXED with properly aligned 
> addresses (but then this also is only a hint to kernel).  With addr == 
> NULL in mmap, the function is bound to fail almost all the times.

There's very little standing in the way of automatic placement. If in
your opinion it should be implemented, I'll add that feature today.

IIRC you mentioned you would like to export the arch-specific
hugepage-aligned vma placement functions; once these are available,
it should be trivial to reuse them.


Thanks,
Bill
