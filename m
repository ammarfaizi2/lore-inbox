Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSLQGmO>; Tue, 17 Dec 2002 01:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSLQGmO>; Tue, 17 Dec 2002 01:42:14 -0500
Received: from holomorphy.com ([66.224.33.161]:50614 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264760AbSLQGmM>;
	Tue, 17 Dec 2002 01:42:12 -0500
Date: Mon, 16 Dec 2002 22:49:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.52-mm1 DCU_MISS_OUTSTANDING + IFU_FETCH_MISS
Message-ID: <20021217064948.GS2690@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the oprofile stats for DCU_MISS_OUTSTANDING and IFU_IFETCH_MISS
during a repetitive kernel compile on 2.5.52-mm1.

Tested on a 16x NUMA-Q with 16GB of RAM. I don't really have a baseline
to compare against atm, but can wander about various kernels and compare.

Let me know if there are other perf. counters you're interested in
(or perhaps even workloads... might be pressed for io though)


Thanks,
Bill


DCU_MISS_OUTSTANDING:

c015d35c 286073   0.579215    path_lookup
c01131f0 299991   0.607394    mark_offset_tsc
c0150b50 408260   0.826608    get_empty_filp
c0135b38 496238   1.00474     __get_page_state
c01359a0 586828   1.18816     nr_free_pages
c013f030 589705   1.19398     zap_pte_range
c01406b8 627686   1.27088     do_wp_page
c01416f0 627890   1.27129     do_no_page
c0139028 645393   1.30673     kmem_cache_free
c013e234 674702   1.36608     pte_unshare
c01377d4 726418   1.47079     check_poison_obj
c0142900 922420   1.86763     vm_enough_memory
c0138e28 1052271  2.13054     kmem_cache_alloc
c013233c 1066434  2.15922     find_get_page
c01b2ee0 1098288  2.22371     __copy_user_intel
c01661fc 1102636  2.23252     d_lookup
c01b3088 1155982  2.34053     __copy_from_user
c0116ba8 1343484  2.72016     x86_profile_hook
c01fc75c 1377869  2.78978     sync_buffer
c0115620 1527197  3.09213     smp_apic_timer_interrupt
c01463f0 1660647  3.36233     page_add_rmap
c013d6c4 2082730  4.21692     __blk_queue_bounce
c011a9b0 3001602  6.07737     scheduler_tick
c01b3020 4047364  8.19473     __copy_to_user
c01465ec 5508580  11.1533     page_remove_rmap
c011a4f8 7613873  15.4159     load_balance


IFU_IFETCH_MISS:

c015d97c 7        0.876095    open_namei
c01b1d74 7        0.876095    radix_tree_lookup
c01b3240 7        0.876095    atomic_dec_and_lock
c0108f2c 8        1.00125     system_call
c0109abc 8        1.00125     page_fault
c0116ba8 8        1.00125     x86_profile_hook
c0132688 8        1.00125     do_generic_mapping_read
c0143d40 8        1.00125     do_brk
c01469b8 8        1.00125     increment_rss
c011ae98 9        1.12641     do_schedule
c0135468 9        1.12641     buffered_rmqueue
c01359a0 9        1.12641     nr_free_pages
c0139028 9        1.12641     kmem_cache_free
c0142900 9        1.12641     vm_enough_memory
c01355a4 10       1.25156     __alloc_pages
c011a9b0 12       1.50188     scheduler_tick
c013233c 13       1.62703     find_get_page
c0116b00 14       1.75219     pfn_to_nid
c0119c14 14       1.75219     kmap_atomic
c013e7e0 15       1.87735     pte_try_to_share
c01463f0 19       2.37797     page_add_rmap
c01412d0 20       2.50313     do_anonymous_page
c0141aa0 22       2.75344     handle_mm_fault
c01416f0 24       3.00375     do_no_page
c015c904 25       3.12891     link_path_walk
c0117350 27       3.37922     do_page_fault
