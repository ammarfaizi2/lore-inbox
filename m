Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265621AbRF1KNJ>; Thu, 28 Jun 2001 06:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265622AbRF1KMs>; Thu, 28 Jun 2001 06:12:48 -0400
Received: from [202.54.26.202] ([202.54.26.202]:25599 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S265621AbRF1KMi>;
	Thu, 28 Jun 2001 06:12:38 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A79.00383EB6.00@sandesh.hss.hns.com>
Date: Thu, 28 Jun 2001 15:31:21 +0530
Subject: kernel memory leak: freeing pagetables in vmfree_area_pages in
	 vmalloc.c
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I was talking about this leak 2 days back but my mail ot lost..
----

we have in vfree -->
vmfree_area_pages (calling) free_area_pmd (calling) free_area_pte (calling)
free_page.
The final free_page frees all the pages that are allocated to a memory region in
vmalloc.
Now where are we freeing pages that are allocated to page table themselves.
For simplicity we can assume 2 level page tables (pgd == pmd)

Regards
Amol




