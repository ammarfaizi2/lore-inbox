Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317124AbSEXKvL>; Fri, 24 May 2002 06:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317123AbSEXKvK>; Fri, 24 May 2002 06:51:10 -0400
Received: from holomorphy.com ([66.224.33.161]:42140 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317124AbSEXKvK>;
	Fri, 24 May 2002 06:51:10 -0400
Date: Fri, 24 May 2002 03:51:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@vger.kernel.org
Subject: treap bootmem update
Message-ID: <20020524105100.GI14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update to the treap-based bootmem patch. Very lightly tested
(UP i386 laptop with 256MB of RAM). As the patch is too lengthy to post
directly, I give only pointers to it. It features two new features:

(1) dynamic page stealing
(2) free_pages() of higher-order pages for bulk marking of free pages
	in the buddy allocator bitmap in free_all_bootmem_core().
and a cleanup:
(3) various cleanups including codesize reduction and elimination of
	dozens of include/asm-*/bootmem.h droppings around the tree.

Available from:
	bk://linux-wli.bkbits.net/bootmem/
	ftp://ftp.kernel.org/pub/linux/kernel/wli/bootmem/bootmem-2.5.17-1

Remaining TODO items to follow up on are:
(1) The ability to mark memory as available at runtime but unusable for
	bootmem allocations. (rmk)
(2) Implement queries for automatic determination of ->node_start_paddr
	and ->node_low_pfn. (wli)

Cheers,
Bill
