Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263240AbVCKJ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbVCKJ7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVCKJ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:59:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31958 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263244AbVCKJ6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:58:03 -0500
Date: Fri, 11 Mar 2005 10:57:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050311095747.GA21820@elte.hu>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net> <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > The short term fix is probably to put back the preempt_disables, the long
> > term is to get rid of these stupid bit_spin_lock busy loops.
> 
> Doing a quick search on the kernel, it looks like only kjournald uses
> the bit_spin_locks. I'll start converting them to spinlocks. The use
> seems to be more of a hack, since it is using bits in the state field
> for locking, and these bits aren't used for anything else.

yeah. bit-spinlocks are really a hack.

	Ingo
