Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUHQHh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUHQHh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUHQHh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:37:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16519 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264251AbUHQHh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:37:58 -0400
Date: Tue, 17 Aug 2004 09:39:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
Message-ID: <20040817073927.GA594@elte.hu>
References: <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <20040817021431.169d07db@mango.fruits.de> <1092701223.13981.106.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092701223.13981.106.camel@krustophenia.net>
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

> > i don't know if this was mentioned before, but i sometimes see traces
> > like this where half the entries are "preempt_schedule
> > (copy_page_range)". I just wanted to ask if this is normal and expected
> > behaviour.
> 
> Yes, Ingo identified an issue with copy_page_range, I don't think it's
> fixed yet.  See the voluntary-preempt-2.6.8.1-P0 thread.

right, it's not fixed yet. It's not a trivial critical section - we are
holding two locks and are mapping two atomic kmaps.

	Ingo
