Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVBCQu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVBCQu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVBCQu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:50:27 -0500
Received: from netblock-66-218-40-30.dslextreme.com ([66.218.40.30]:7626 "EHLO
	mail.lowrydigital.com") by vger.kernel.org with ESMTP
	id S263405AbVBCQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:49:42 -0500
Mime-Version: 1.0 (Apple Message framework v619.2)
In-Reply-To: <E1CwY6U-0003p6-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1CwY6U-0003p6-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1e90ea5b2039243539df074d7bc9a658@lowrydigital.com>
Content-Transfer-Encoding: 7bit
From: Ian Godin <Ian.Godin@lowrydigital.com>
Subject: Re: Drive performance bottleneck
Date: Thu, 3 Feb 2005 08:49:42 -0800
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 2, 2005, at 7:56 PM, Bernd Eckenfels wrote:

> In article <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com> you 
> wrote:
>>  Below is an oprofile (truncated) of (the same) dd running on 
>> /dev/sdb.
>
> do  you also have the oprofile of the sg_dd handy?
>
> Greetings
> Bernd
>

   Just ran it on the sg_dd (using /dev/sg1):

CPU: P4 / Xeon, speed 3402.13 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not 
stopped) with a unit mask of 0x01 (mandatory) count 10
0000
samples  %        symbol name
2145136  89.7474  __copy_to_user_ll
64720     2.7077  lock_kernel
17883     0.7482  mark_offset_tsc
16212     0.6783  page_address
8091      0.3385  schedule
5380      0.2251  timer_interrupt
5314      0.2223  _spin_lock
5311      0.2222  mwait_idle
4034      0.1688  sysenter_past_esp
3569      0.1493  do_anonymous_page
3530      0.1477  apic_timer_interrupt
3368      0.1409  _spin_lock_irqsave
3150      0.1318  sg_read_xfer
3043      0.1273  kmem_cache_alloc
2590      0.1084  find_busiest_group
2553      0.1068  scheduler_tick
2319      0.0970  __copy_from_user_ll
2299      0.0962  sg_ioctl
2131      0.0892  irq_entries_start
1905      0.0797  sys_ioctl
1773      0.0742  copy_page_range
1678      0.0702  fget
1648      0.0689  __switch_to
1648      0.0689  scsi_block_when_processing_errors
1632      0.0683  sg_start_req
1569      0.0656  increment_tail
1511      0.0632  try_to_wake_up
1506      0.0630  update_one_process
1454      0.0608  fput
1397      0.0584  do_gettimeofday
1396      0.0584  zap_pte_range
1371      0.0574  recalc_task_prio
1357      0.0568  sched_clock
1352      0.0566  sg_link_reserve
1282      0.0536  __elv_add_request
1229      0.0514  kmap_atomic
1195      0.0500  page_fault

   Oddly enough it appears to also be copying to user space...

      Ian.

