Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUIHG6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUIHG6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUIHG6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:58:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63188 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268892AbUIHG4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:56:03 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, felipe_alfaro@linuxmail.org,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040906110626.GA32320@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
Content-Type: text/plain
Message-Id: <1094626562.1362.99.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 02:56:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 07:06, Ingo Molnar wrote:
> i've released the -R6 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R6

I get these latencies when I cause the machine to swap by compiling a
kernel with make -j32.  They get bigger as the machine gets further into
swap.

Every 2.0s: head -60 /proc/latency_trace                                                                                                                             Wed Sep  8 02:51:40 2004

preemption latency trace v1.0.6 on 2.6.9-rc1-bk12-VP-R6
--------------------------------------------------
 latency: 605 us, entries: 5 (5)  [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: kswapd0/35, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: get_swap_page+0x23/0x490
 => ended at:   get_swap_page+0x13f/0x490
=======>
00000001 0.000ms (+0.606ms): get_swap_page (add_to_swap)
00000001 0.606ms (+0.000ms): sub_preempt_count (get_swap_page)
00000001 0.606ms (+0.000ms): update_max_trace (check_preempt_timing)
00000001 0.606ms (+0.000ms): _mmx_memcpy (update_max_trace)
00000001 0.607ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Lee

