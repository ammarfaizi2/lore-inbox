Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUEWLkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUEWLkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 07:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUEWLkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 07:40:07 -0400
Received: from zero.aec.at ([193.170.194.10]:18181 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262585AbUEWLkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:40:04 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <1YAd2-6Th-13@gated-at.bofh.it> <1YPF4-2hJ-11@gated-at.bofh.it>
	<1YPOI-2nq-1@gated-at.bofh.it> <1YRdQ-3pu-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 23 May 2004 13:39:59 +0200
In-Reply-To: <1YRdQ-3pu-5@gated-at.bofh.it> (Eric W. Biederman's message of
 "Sun, 23 May 2004 04:50:06 +0200")
Message-ID: <m3r7tbtlrk.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Currently I know of a safe version that will work on x86 on processors
> with sse support.   And I how to generate 64bit I/O cycles with using
> mmx or x87 registers,  but don't know if I can write code that touches
> the FPU registers that is interrupt safe.

As long as you save/restore cr0 and the FPU registers and do clts
interrupts are not a problem.  In fact interrupts are even easier that
process context, where you need preempt_disable().

-Andi

