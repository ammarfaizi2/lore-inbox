Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265742AbUEZRkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUEZRkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265739AbUEZRkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:40:55 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:41913 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265742AbUEZRkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:40:23 -0400
Subject: Re: 4k stacks in 2.6
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu, arjanv@redhat.com
Content-Type: text/plain
Organization: 
Message-Id: <1085584670.955.1034.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2004 11:17:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> do you realize that the 4K stacks feature also adds
> a separate softirq and a separate hardirq stack?
> So the maximum footprint is 4K+4K+4K, with a clear
> and sane limit for each type of context, while the
> 2.4 kernel has 6.5K for all 3 contexts combined.
> (Also, in 2.4 irq contexts pretty much assumed that
> there's 2K of stack for them - leaving a de-facto 4K
> stack for the process and softirq contexts.) So in fact
> there is more space in 2.6 for all, and i dont really
> understand your fears.

Is that 4K per IRQ (total 64K to 1024K) or 4K total?
If it's total, then it's cheap to go with 32K.

The same goes for softirqs: 4K total, or per softirq?



