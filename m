Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUHUJab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUHUJab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268953AbUHUJaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:30:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9430 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268954AbUHUJaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:30:24 -0400
Date: Sat, 21 Aug 2004 11:31:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
Message-ID: <20040821093152.GB27273@elte.hu>
References: <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <1093058602.854.5.camel@krustophenia.net> <20040821091338.GA25931@elte.hu> <1093079726.854.80.camel@krustophenia.net> <20040821091804.GA26622@elte.hu> <1093080202.854.94.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093080202.854.94.camel@krustophenia.net>
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

> Sorry, I was thinking of this one:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace10.txt

ok, reduced the zap block size to 8 pages a time. It should not be a big
issue to have this at a low value because we dont retry anything and we
do a full TLB flush only once. (subsequent flushes are caught by the
tlb->need_flush optimization.)

	Ingo
