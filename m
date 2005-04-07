Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVDGHR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVDGHR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVDGHR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:17:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:648 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261418AbVDGHRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:17:16 -0400
Date: Thu, 7 Apr 2005 09:17:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 5/5] sched: consolidate sbe sbf
Message-ID: <20050407071702.GC26607@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <42532427.3030100@yahoo.com.au> <20050406062723.GC5973@elte.hu> <4253993C.4020505@yahoo.com.au> <42539AEC.6000204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42539AEC.6000204@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Nick Piggin wrote:
> 
> >
> >One problem I just noticed, sorry. This is doing set_cpus_allowed
> >without holding the runqueue lock and without checking the hard
> >affinity mask either.
> >
> 
> Err, that is to say set_task_cpu, not set_cpus_allowed.

yes. The whole cpus_allowed+set_task_cpu() section in copy_process() 
should move into sched_fork().

	Ingo
