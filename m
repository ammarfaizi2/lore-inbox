Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUHPEKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUHPEKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUHPEKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:10:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31212 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267407AbUHPEKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:10:15 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816040142.GA13531@elte.hu>
References: <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040142.GA13531@elte.hu>
Content-Type: text/plain
Message-Id: <1092629463.810.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 00:11:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:01, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I will try next with /dev/random disabled.  Don't most/many new
> > machines have a hardware RNG that would eliminate the need for this
> > code?
> 
> The C3 does have one IIRC, but do Intel CPUs have it too? Also, there's
> the question of trust - how random it truly is. Is it a partly
> pseudo-RNG masked via encryption? /dev/random i know is random, driven
> by random timings of real disks and real network packets. The CPU's HRNG
> is much more encapsulated and can only be blackbox-tested.

According to menuconfig, it looks like Linux supports hardware RNGs from
AMD, Intel, and Via.  Via at least has published a cryptanalysis of
theirs: http://www.via.com.tw/en/viac3/via_c3_padlock_evaluation.pdf.

I am not a crypto expert so I can't comment much more.  Also I have one
of the older C3s without this feature so it's beside the point.

Lee

