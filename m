Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268435AbTBYXqZ>; Tue, 25 Feb 2003 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbTBYXqZ>; Tue, 25 Feb 2003 18:46:25 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:39060 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S268435AbTBYXqX>; Tue, 25 Feb 2003 18:46:23 -0500
Date: Tue, 25 Feb 2003 16:57:55 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: Re: IO scheduler benchmarking
Message-ID: <20030225215755.GA2038@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why does 2.5.62-mm2 have higher sequential
> write latency than 2.5.61-mm1?

Anticipatory scheduler tiobench profile on uniprocessor:

                              2.5.61-mm1   2.5.62-mm2
total                           1993387     1933241
default_idle                    1873179     1826650
system_call                       49838       43036
get_offset_tsc                    21905       20883
do_schedule                       13893       10344
do_gettimeofday                    8478        6044
sys_gettimeofday                   8077        5153
current_kernel_time                4904       12165
syscall_exit                       4047        1243
__wake_up                          1274        1000
io_schedule                        1166        1039
prepare_to_wait                    1093         792
schedule_timeout                    612         366
delay_tsc                           502         443
get_fpu_cwd                         473         376
syscall_call                        389         378
math_state_restore                  354         271
restore_fpu                         329         287
del_timer                           325         200
device_not_available                290         377
finish_wait                         257         181
add_timer                           218         137
io_schedule_timeout                 195          72
cpu_idle                            193         218
run_timer_softirq                   137          33
remove_wait_queue                   121         188
eligible_child                      106         154
sys_wait4                           105         162
work_resched                        104         110
ret_from_intr                        97          74
dup_task_struct                      75          48
add_wait_queue                       67         124
__cond_resched                       59          69
do_page_fault                        55           0
do_softirq                           53          12
pte_alloc_one                        51          67
release_task                         44          55
get_signal_to_deliver                38          43
get_wchan                            16          10
mod_timer                            15           0
old_mmap                             14          19
prepare_to_wait_exclusive            10          32
mm_release                            7           0
release_x86_irqs                      7           8
sys_getppid                           6           5
handle_IRQ_event                      4           0
schedule_tail                         4           0
kill_proc_info                        3           0
device_not_available_emulate          2           0
task_prio                             1           1
__down                                0          33
__down_failed_interruptible           0           3
init_fpu                              0          12
pgd_ctor                              0           3
process_timeout                       0           2
restore_all                           0           2
sys_exit                              0           2
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

