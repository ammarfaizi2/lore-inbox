Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUJCGhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUJCGhl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 02:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJCGhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 02:37:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53447 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264915AbUJCGhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 02:37:39 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
Content-Type: text/plain
Message-Id: <1096785457.1837.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 02:37:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> i've released the -S7 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> 

This one was caused by amlat:

preemption latency trace v1.0.7 on 2.6.9-rc2-mm4-VP-S7
-------------------------------------------------------
 latency: 264 us, entries: 5 (5)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: amlat/3921, uid:1000 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: rtc_open+0x12/0x270
 => ended at:   rtc_open+0x13f/0x270
=======>
00000001 0.000ms (+0.264ms): rtc_open (misc_open)
00000001 0.264ms (+0.000ms): sub_preempt_count (rtc_open)
00000001 0.265ms (+0.000ms): update_max_trace (check_preempt_timing)
00000001 0.265ms (+0.000ms): _mmx_memcpy (update_max_trace)
00000001 0.265ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Lee

