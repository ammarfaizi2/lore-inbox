Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUHMM3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUHMM3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUHMM3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:29:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51585 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265040AbUHMM3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:29:05 -0400
Date: Fri, 13 Aug 2004 14:16:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813121632.GA19047@elte.hu>
References: <2mkTt-BZ-11@gated-at.bofh.it> <2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it> <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813121502.GA18860@elte.hu>
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

> > Or just stick some cond_sched()s in there. It was designed to be slow,
> > but there are no locking issues.
> 
> the speedup would be important: even on a 2GHz box reading 10,000
> trace entries takes a couple of seconds.

binary searching should be doable without much extra code, the kallsym
entries are already sorted.

	Ingo
