Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276475AbSIUXT5>; Sat, 21 Sep 2002 19:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbSIUXT5>; Sat, 21 Sep 2002 19:19:57 -0400
Received: from holomorphy.com ([66.224.33.161]:52622 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S276475AbSIUXT4>;
	Sat, 21 Sep 2002 19:19:56 -0400
Date: Sat, 21 Sep 2002 16:18:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <20020921231810.GA25605@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Erich Focht <efocht@ess.nec.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <597807912.1032600740@[10.10.2.3]> <598631797.1032601564@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <598631797.1032601564@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 09:46:05AM -0700, Martin J. Bligh wrote:
> An old compile off 2.5.31-mm1 + extras (I don't have 37, but similar)

Some 8-quad numbers for 2.5.37 (virgin) follow.

I'll get dcache_rcu and NUMA sched stuff in on the act for round 2.
This is more fs transaction-based (and VM process-spawning overhead)
and not pure I/O throughput so there won't be things like "but
everybody's running at peak I/O bandwidth" obscuring the issues.

real    0m30.854s

c01053ec 16963617 89.009      poll_idle
c0114a48 452526   2.37443     load_balance
c013962c 253666   1.331       get_page_state
c01466de 177354   0.930586    .text.lock.file_table
c0114ec0 150583   0.790117    scheduler_tick
c01547b3 116144   0.609414    .text.lock.namei
c01422ac 94042    0.493444    page_remove_rmap
c0138c24 83293    0.437043    rmqueue
c0141e48 51963    0.272653    page_add_rmap
c012d5ec 37086    0.194592    do_anonymous_page
c01391d0 34454    0.180782    __alloc_pages
c0130e08 32111    0.168488    find_get_page
c0139534 29222    0.153329    nr_free_pages
c012df4c 26734    0.140275    handle_mm_fault
c0146070 25881    0.135799    get_empty_filp
c01a0d2c 25250    0.132488    __generic_copy_from_user
c0111728 22018    0.11553     smp_apic_timer_interrupt
c0112b90 20777    0.109018    pfn_to_nid
c0136238 18410    0.0965983   kmem_cache_free
c0113270 17494    0.091792    do_page_fault
c0138900 17282    0.0906796   __free_pages_ok
c01a0f90 17160    0.0900395   atomic_dec_and_lock
c01a100b 16937    0.0888694   .text.lock.dec_and_lock
