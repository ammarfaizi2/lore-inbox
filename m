Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbRFZMhZ>; Tue, 26 Jun 2001 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbRFZMhP>; Tue, 26 Jun 2001 08:37:15 -0400
Received: from [202.54.26.202] ([202.54.26.202]:17578 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S264872AbRFZMhC>;
	Tue, 26 Jun 2001 08:37:02 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A77.004598B0.00@sandesh.hss.hns.com>
Date: Tue, 26 Jun 2001 18:10:15 +0530
Subject: freeing pagetables in vmfree_area_pages in vmalloc.c
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



we have in vfree -->
vmfree_area_pages (calling) free_area_pmd (calling) free_area_pte (calling)
free_page.
The final free_page frees all the pages that are allocated to a memory region in
vmalloc.
Now where are we freeing pages that are allocated to page table themselves.
For simplicity we can assume 2 level page tables (pgd == pmd)

Regards
Amol



