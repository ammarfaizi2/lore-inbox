Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUHMMIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUHMMIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUHMMIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:08:24 -0400
Received: from zero.aec.at ([193.170.194.10]:29445 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264833AbUHMMIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:08:23 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <2m9bF-kH-13@gated-at.bofh.it> <2m9EG-Js-5@gated-at.bofh.it>
	<2md5B-36u-11@gated-at.bofh.it> <2mkTt-BZ-11@gated-at.bofh.it>
	<2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it>
	<2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it>
	<2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it>
	<2sHu9-2EW-31@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 13 Aug 2004 14:08:17 +0200
In-Reply-To: <2sHu9-2EW-31@gated-at.bofh.it> (Ingo Molnar's message of "Fri,
 13 Aug 2004 12:30:17 +0200")
Message-ID: <m31xibtf4e.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Lee Revell <rlrevell@joe-job.com> wrote:
>
>> Interesting results.  One of the problems is kallsyms_lookup,
>> triggered by the printks:
>
> yeah - kallsyms_lookup does a linear search over thousands of symbols. 
> Especially since /proc/latency_trace uses it too it would be worthwile
> to implement some sort of binary searching.

Or just stick some cond_sched()s in there. It was designed to be slow,
but there are no locking issues.

-Andi

