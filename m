Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVDFAIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVDFAIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVDFAIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:08:49 -0400
Received: from fmr24.intel.com ([143.183.121.16]:55997 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261885AbVDFAIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:08:47 -0400
Message-Id: <200504060008.j3608Zg22021@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Paul Jackson" <pj@engr.sgi.com>, <torvalds@osdl.org>,
       <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Date: Tue, 5 Apr 2005 17:08:34 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU43vtCQO5COAU3Rbej+It5BdScZQBW4Wvg
In-Reply-To: <20050404062414.GA22664@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Sunday, April 03, 2005 11:24 PM

> great! How long does the benchmark take (hours?), and is there any way
> to speed up the benchmarking (without hurting accuracy), so that
> multiple migration-cost settings could be tried? Would it be possible to
> try a few other values via the migration_factor boot option, in 0.5 msec
> steps or so, to find the current sweet spot? It used to be at 11 msec
> previously, correct?

It take days, each experiment is 5 hours.  Previous experiments on 2.6.8
shows that the sweet spot was 12.5ms.

This time on 2.6.11, it got pushed into 16 ms.  Results comparing to 10ms:

 8 ms  -0.3%
10 ms  --
12 ms	+0.11%
16 ms +0.14%
20 ms +0.06%

12ms and up all has about 1.5% idle time.  We are not anywhere near the
limits on what the disk storage can deliver.  So there is a potential to
to tune/optimize the scheduler and reap these extra idle time.

- Ken


