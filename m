Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317889AbSGVWsV>; Mon, 22 Jul 2002 18:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317890AbSGVWsT>; Mon, 22 Jul 2002 18:48:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55031 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317889AbSGVWsK>;
	Mon, 22 Jul 2002 18:48:10 -0400
Message-ID: <3D3C8C43.F65E7ED1@mvista.com>
Date: Mon, 22 Jul 2002 15:50:43 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Calleja <diegocg@teleline.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.27: do_softirq
References: <20020723000806.1372d26e.diegocg@teleline.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> 
> This is the output of readprofile | sort -nr:
> It shows too much calls to do_softirq ( i don't know what it means but i
> hope it can help)
>
Maybe  _local_bh_enable() should check to see if the call is
needed before it calls....
-g

> System is a dual P200 mhz with preempt enabled in a 2.5.27 kernel,
> config attached
> 
> 5739201 total                                     43,4012
> 5660227 default_idle                             108850,5192
>  60804 do_softirq                               241,2857
>   7875 timer_bh                                   9,3306
>   3447 tasklet_hi_action                         17,5867
>   2156 bh_action                                 11,0000
>    887 release_console_sem                        4,0318
>    755 schedule                                   0,7673
>    575 .text.lock.sched                           1,0748
>    266 acquire_console_sem                        3,9118
>    255 system_call                                5,3125
>    242 do_page_fault                              0,1898
>    177 add_wait_queue                             2,0114
>    163 __wake_up                                  1,9405
>    138 cpu_idle                                   1,9167
>    132 remove_wait_queue                          1,4348
>    127 pte_alloc_one                              0,7937
>     85 handle_IRQ_event                           0,6439
>     78 add_timer                                  0,2635
>     62 tasklet_init                               1,5500
>     53 syscall_exit                               3,5333
>     50 pgd_alloc                                  0,8333
>     49 try_to_wake_up                             0,0833
>     48 do_timer                                   0,5455
>     43 sys_rt_sigprocmask                         0,0731
>     42 __run_task_queue                           0,3000
>     40 copy_mm                                    0,0472
>     39 init_bh                                    1,6250
>     32 do_sigaction                               0,0842
>     29 do_syslog                                  0,0220
>     28 console_conditional_schedule               0,7000
>     27 del_timer_sync                             0,1378
>     23 do_fork                                    0,0099
>     17 dup_task_struct                            0,1574
>     13 __global_sti                               0,1548
>     12 sys_rt_sigaction                           0,0526
>     12 schedule_timeout                           0,0750
>     12 flush_tlb_page                             0,0811
>     12 flush_signal_handlers                      0,2000
>     12 copy_files                                 0,0139
>     11 tqueue_bh                                  0,3929
>     11 sys_nanosleep                              0,0270
>     11 old_mmap                                   0,0362
> <snip>
> 
>   ------------------------------------------------------------
>               Name: .config
>    .config    Type: unspecified type (application/octet-stream)
>           Encoding: base64

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
