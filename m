Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbULHLQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbULHLQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 06:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbULHLQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 06:16:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24489 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261184AbULHLQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 06:16:10 -0500
Date: Wed, 8 Dec 2004 12:15:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, kernel@kolivas.org
Subject: Re: [PATCH, RFC] protect call to set_tsk_need_resched() by the rq-lock
Message-ID: <20041208111549.GB24484@elte.hu>
References: <200412062339.52695.mbuesch@freenet.de> <200412080031.08490.mbuesch@freenet.de> <20041208082633.GA7720@elte.hu> <200412081049.37498.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412081049.37498.mbuesch@freenet.de>
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


* Michael Buesch <mbuesch@freenet.de> wrote:

> Someone else said to me:
> [quote]
> "another runqueue might want to touch your runqueue
> while you're in scheduler_tick" ...
> "that is far more likely to hit with many many cpus and I'd
> be surprised if you're the first person to get a race there"
> [/quote]
> 
> What about this? Is this possible? Or did she/he/it miss a point?

it might touch the runqueue but it wont move _your task_ off from under
you. So setting need_resched of the current task is perfectly fine.

	Ingo
