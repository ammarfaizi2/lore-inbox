Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276702AbSIVILj>; Sun, 22 Sep 2002 04:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276792AbSIVILj>; Sun, 22 Sep 2002 04:11:39 -0400
Received: from holomorphy.com ([66.224.33.161]:11920 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S276702AbSIVILi>;
	Sun, 22 Sep 2002 04:11:38 -0400
Date: Sun, 22 Sep 2002 01:09:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <20020922080942.GF25605@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Erich Focht <efocht@ess.nec.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <597807912.1032600740@[10.10.2.3]> <598631797.1032601564@[10.10.2.3]> <20020921231810.GA25605@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020921231810.GA25605@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 09:46:05AM -0700, Martin J. Bligh wrote:
>> An old compile off 2.5.31-mm1 + extras (I don't have 37, but similar)

On Sat, Sep 21, 2002 at 04:18:10PM -0700, William Lee Irwin III wrote:
> Some 8-quad numbers for 2.5.37 (virgin) follow.

Okay, 2.5.37 virgin with overcommit_memory set to 1 this time.
(compiles with -j256 seem to do better than -j32 or -j48, here is -j256):

... will follow up with 2.5.38-mm1 with and without NUMA sched, at
least if the arrival rate of releases doesn't exceed the benchtime.

c01053ec 1605553  95.6785     poll_idle
c0114a48 7611     0.453556    load_balance
c0114ec0 5303     0.316018    scheduler_tick
c01422ac 5017     0.298974    page_remove_rmap
c01466de 4026     0.239918    .text.lock.file_table
c012d5ec 3290     0.196058    do_anonymous_page
c0141e48 3211     0.191351    page_add_rmap
c012df4c 2920     0.174009    handle_mm_fault
c010d6e8 2844     0.16948     timer_interrupt
c01547b3 2080     0.123952    .text.lock.namei
c0146070 1934     0.115251    get_empty_filp
c01a0d2c 1591     0.0948112   __generic_copy_from_user
c0111728 1477     0.0880177   smp_apic_timer_interrupt
c014633c 1437     0.085634    __fput
c01a0ce0 1346     0.0802111   __generic_copy_to_user
c0138c24 1249     0.0744307   rmqueue
c012e450 1169     0.0696633   vm_enough_memory
c012b694 1056     0.0629294   zap_pte_range
c0130e08 997      0.0594135   find_get_page
c014427c 950      0.0566126   dentry_open
c01391d0 949      0.056553    __alloc_pages
c0151424 892      0.0531563   link_path_walk
c01a0f90 834      0.0496999   atomic_dec_and_lock
