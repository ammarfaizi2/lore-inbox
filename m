Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVCaTyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVCaTyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVCaTyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:54:05 -0500
Received: from fmr24.intel.com ([143.183.121.16]:43187 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261697AbVCaTyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:54:02 -0500
Message-Id: <200503311953.j2VJrog22170@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Linus Torvalds" <torvalds@osdl.org>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Thu, 31 Mar 2005 11:53:50 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU1/Bu0D5SGrTCsSzGaoo/aEx5CZAALgmuw
In-Reply-To: <20050331141441.GA2384@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Thursday, March 31, 2005 6:15 AM
> is there any idle time on the system, in steady state (it's a sign of
> under-balancing)? Idle balancing (and wakeup balancing) is one of the
> things that got tuned back and forth alot. Also, do you know what the
> total number of context-switches is during the full test on each kernel?
> Too many context-switches can be an indicator of over-balancing. Another
> sign of migration gone bad can be relative increase of userspace time
> vs. system time. (due to cache trashing, on DB workloads, where most of
> the cache contents are userspace's.)

No, there are no idle time on the system. If system become I/O bound, we
would do everything we can to remove that bottleneck, i.e., throw a couple
hundred GB of memory to the system, or add a couple hundred disk drives,
etc.  Believe it or not, we are currently CPU bound and that's the reason
why I care about every single cpu cycle being spend in the kernel code.


