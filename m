Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUBDXoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUBDXl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:41:29 -0500
Received: from s4.uklinux.net ([80.84.72.14]:28334 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S264365AbUBDXjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:39:25 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040202194626.191cbb95.akpm@osdl.org>
	<87llnk2js9.fsf@codematters.co.uk>
	<20040203132913.6145f4e6.akpm@osdl.org>
	<87znbzg78o.fsf@codematters.co.uk> <402087B3.1080302@cyberone.com.au>
	<877jz291jm.fsf@codematters.co.uk>
From: Philip Martin <philip@codematters.co.uk>
Date: Wed, 04 Feb 2004 23:38:29 +0000
In-Reply-To: <877jz291jm.fsf@codematters.co.uk> (Philip Martin's message of
 "Wed, 04 Feb 2004 17:50:37 +0000")
Message-ID: <87y8riifey.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Martin <philip@codematters.co.uk> writes:

> Nick Piggin <piggin@cyberone.com.au> writes:
>
>> What are you building, by the way? It slipped my mind.
>
> All the 2.6 figures so far are for a plain 2.6.1.  I've just switched
> to 2.6.2 and at first glance it's the same as 2.6.1.

This is the profile for 2.6.2, it is very much like 2.6.1

248.07user 118.81system 3:42.00elapsed 165%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (434major+3770493minor)pagefaults 0swaps

c0109e28 setup_frame                                 448   1.0667
c010aff4 error_code                                  449   8.0179
c0108a48 copy_thread                                 459   0.8376
c012591c __mod_timer                                 463   1.7276
c010a5b0 syscall_call                                484  44.0000
c0119f8c wake_up_forked_process                      492   1.3516
c01200b4 put_files_struct                            534   2.8404
c0120f80 wait_task_zombie                            559   1.4116
c011e598 do_fork                                     604   1.6237
c0126dd0 flush_signal_handlers                       607   8.9265
c010c320 handle_IRQ_event                            620   7.0455
c0122430 do_softirq                                  642   3.1471
c0125b44 del_timer_sync                              700   2.5362
c0115e58 flush_tlb_mm                                814   6.5645
c011063c old_mmap                                    895   2.7623
c012a1a8 sys_rt_sigaction                            926   3.7951
c012127c sys_wait4                                   929   1.6017
c010a4d8 ret_from_intr                              1275  45.5357
c0128e44 get_signal_to_deliver                      1482   1.8162
c0120a68 do_exit                                    1486   1.8668
c0122388 current_kernel_time                        1518  22.3235
c011a158 schedule_tail                              1520   9.2683
c011cbb7 .text.lock.sched                           2291   4.5366
c0129270 sys_rt_sigprocmask                         2462   7.5988
c0129c84 do_sigaction                               2843   4.8682
c011d888 copy_files                                 2869   4.2693
c011d0f8 dup_task_struct                            3001  22.0662
c011b520 __wake_up                                  3053  69.3864
c0129190 sigprocmask                                3345  14.9330
c011f9c0 release_task                               3593   7.6123
c012041c exit_notify                                4023   2.4957
c011aec0 schedule                                   6625   4.3357
c0115ed4 flush_tlb_page                             7025  54.8828
c011db90 copy_process                               7663   2.9840
c011d3b8 copy_mm                                    7704   8.0250
c010a584 system_call                                8314 188.9545
c01188a8 pte_alloc_one                             15944 249.1250
c0118c78 do_page_fault                             44368  37.7279
c0108690 default_idle                             1351419 25988.8269
00000000 total                                    1503962   9.7998

-- 
Philip Martin
