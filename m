Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUHPDov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUHPDov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUHPDou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:44:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13719 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267404AbUHPDor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:44:47 -0400
Date: Mon, 16 Aug 2004 05:46:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816034618.GA13063@elte.hu>
References: <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092627691.867.150.camel@krustophenia.net>
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

> On Sun, 2004-08-15 at 23:36, Ingo Molnar wrote:
> > doh - i think i found a brown-paperbag bug.
> 
> Heh, this would explain all those latency traces with repeated 
> calls to voluntary_resched...

hm, didnt those traces show preempt_schedule()?

this bug also fooled the latency tracer because the preempt count went
down to zero (hence the latency got reset), but in reality we skipped
the reschedule.

	Ingo
