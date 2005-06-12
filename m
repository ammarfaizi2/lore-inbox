Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVFLKgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVFLKgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVFLKgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:36:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54991 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261936AbVFLKfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:35:55 -0400
Date: Sun, 12 Jun 2005 12:35:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050612103513.GA10808@elte.hu>
References: <20050608112801.GA31084@elte.hu> <200506112140.36352.gene.heskett@verizon.net> <20050612064939.GB4897@elte.hu> <200506120502.01752.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506120502.01752.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> Glitch reports as they develop of course.
> 
> Q: Whats the diff between turning on hardirq's in mode 3, and mode 4?

well, "mode 3" is PREEMPT_DESKTOP - normal CONFIG_PREEMPT on the 
mainstream kernel. If you turn on hardirq/softirq threading then you can 
e.g. chprio your sound IRQ to have better audio latencies. It will cause 
runtime overhead though. On "mode 4" (PREEMPT_RT) hardirq/softirq 
threading is mandatory (due to the processing model).

	Ingo
