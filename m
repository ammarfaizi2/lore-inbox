Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUHBKH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUHBKH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266436AbUHBKH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:07:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47552 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266435AbUHBKHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:07:22 -0400
Date: Mon, 2 Aug 2004 12:08:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] preempt-timing-on-2.6.8-rc2-O2
Message-ID: <20040802100815.GA18349@elte.hu>
References: <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu> <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe> <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com> <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe> <20040802073938.GA8332@elte.hu> <1091435237.3024.9.camel@mindpipe> <20040802092855.GA15894@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802092855.GA15894@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> i've uploaded the preempt-timing patch (relative to -O2):
> 
>    http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc2-O2
> 
> QuickStart for those who havent used it yet: enable PREEMPT_TIMING in
> .config and add preempt_thresh=1000 [== 1000 usec threshold] to the
> kernel's boot options. 
> 
> i changed the original patch to make it a bit more usable - the
> threshold can be changed runtime via /proc/sys/kernel/preempt_thresh,
> and the units are microseconds not milliseconds.

i've uploaded a new version of the patch, this solves a problem when
using a smaller than 1000 usecs threshold: idle time got accounted as
delay too which flooded the log. The new patch makes idle=poll the
default and that function calls touch_preempt_timing().

	Ingo
