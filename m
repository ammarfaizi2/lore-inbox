Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269945AbUJNBiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269945AbUJNBiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 21:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269947AbUJNBiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 21:38:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27077 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269945AbUJNBiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 21:38:09 -0400
Date: Thu, 14 Oct 2004 03:36:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014013659.GA344@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <Pine.LNX.4.58.0410132015530.1244@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410132015530.1244@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> Also, I noticed that the swapper/0 had a high-latency critical
> section.

this is normal during bootup - we spend many seconds with preemption
disabled - it's fair at that stage. After it has booted up you can reset
the maximum-latency searching via:

    echo 50 > /proc/sys/kernel/preempt_max_latency

i have that line in my rc.local.

	Ingo
