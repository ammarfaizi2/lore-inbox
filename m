Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSDTTru>; Sat, 20 Apr 2002 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313236AbSDTTrt>; Sat, 20 Apr 2002 15:47:49 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:48313 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313173AbSDTTrr>; Sat, 20 Apr 2002 15:47:47 -0400
Date: Sat, 20 Apr 2002 12:47:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mel <mel@csn.ul.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documenation/vm/numa
Message-ID: <2948370542.1019306872@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0204201703320.3995-100000@skynet>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + node_start_paddr  The starting physical address of the node. This doesn't
> +		    work really well as an unsigned long as it breaks for
> +                   ia32 with PAE for example. A more suitable solution would be
> +                   to record this as a Page Frame Number (pfn). This could be
> +                   trivially defined as (page_phys_addr >> PAGE\_SHIFT).

This looks fine.

> +                   Alternatively, it could be the struct page * index inside
> +                   mem_map.

But I'd just omit this last sentence ... that only works for machines 
with a contig mem_map (not NUMA), and it's kind of an accidental
kludge that happens to work in some cases, not the proper definition
(what I originally posted was confusing).

I actually submitted a patch a couple of days ago to fix these to
a pfn instead. If that gets in, we can update the documentation then.

M.
