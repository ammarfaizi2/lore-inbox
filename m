Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUHUJZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUHUJZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUHUJZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:25:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58009 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268937AbUHUJZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:25:19 -0400
Date: Sat, 21 Aug 2004 11:26:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6
Message-ID: <20040821092651.GA27273@elte.hu>
References: <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <1093059838.854.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093059838.854.11.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here's a 171 usec latency from ext3_free_blocks:
> 
> preemption latency trace v1.0.1
> -------------------------------
>  latency: 171 us, entries: 2 (2)
>     -----------------
>     | task: evolution/863, uid:1000 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: ext3_free_blocks+0x1d0/0x4b0
>  => ended at:   ext3_free_blocks+0x229/0x4b0
> =======>
> 00000001 0.000ms (+0.000ms): ext3_free_blocks (ext3_free_data)
> 00000001 0.167ms (+0.167ms): sub_preempt_count (ext3_free_blocks)

ok, i broke this lock in my tree, will show up in -P7.

	Ingo
