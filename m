Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTBTFRn>; Thu, 20 Feb 2003 00:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTBTFRn>; Thu, 20 Feb 2003 00:17:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34711 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264875AbTBTFRm>; Thu, 20 Feb 2003 00:17:42 -0500
Date: Wed, 19 Feb 2003 21:27:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: Performance of partial object-based rmap
Message-ID: <33520000.1045718860@[10.10.2.4]>
In-Reply-To: <20030220051613.GG22687@holomorphy.com>
References: <7490000.1045715152@[10.10.2.4]> <20030220044748.GE22687@holomorphy.com> <32200000.1045718048@[10.10.2.4]> <20030220051613.GG22687@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Could I get a larger, multiplicative differential profile?
>>> i.e. ratios of the fractions of profile hits?
>>> If you have trouble generating such I can do so myself from
>>> fuller profile results.
> 
> On Wed, Feb 19, 2003 at 09:14:10PM -0800, Martin J. Bligh wrote:
>> before:
>> 	187256 total
>> after:
>> 	170196 total
> 
> Well, I was trying to get an idea of what got slower to compensate
> for the improvement in page_(add|remove)_rmap() times.

diffprofile:

1514 default_idle
921 .text.lock.file_table
145 vm_enough_memory
131 release_pages
93 file_move
68 __copy_to_user_ll
62 fd_install
60 buffered_rmqueue
58 vma_merge
52 __fput
...
-65 kmem_cache_alloc
-72 copy_page_range
-73 do_anonymous_page
-76 get_empty_filp
-98 filemap_nopage
-168 unmap_all_pages
-352 find_get_page
-402 kmem_cache_free
-594 __pte_chain_free
-4360 page_add_rmap
-13542 page_remove_rmap
-17060 total

I'll try out akpm's file table stuff later today.

M.

