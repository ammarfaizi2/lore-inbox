Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUHUJpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUHUJpX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268958AbUHUJpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:45:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28318 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268957AbUHUJpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:45:21 -0400
Date: Sat, 21 Aug 2004 11:46:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6
Message-ID: <20040821094650.GA28525@elte.hu>
References: <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <1093059838.854.11.camel@krustophenia.net> <20040821091036.GA25864@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821091036.GA25864@elte.hu>
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

> but the XFree86 latency is interesting indeed. It could be the effect
> of the now-enlarged ioperm() bitmap! 80 usecs is excessive.

yeah, that's the reason. The quick fix is to reduce IO_BITMAP_BITS to
1024 in include/asm-i386/processor.h. I'm working on a real fix.

	Ingo
