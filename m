Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUA3BIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUA3BIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:08:44 -0500
Received: from mail.broadpark.no ([217.13.4.2]:43722 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S266283AbUA3BIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:08:41 -0500
Date: Fri, 30 Jan 2004 02:08:39 +0100
From: Daniel Andersen <kernel-list@majorstua.net>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1 (Breakage?)
Message-Id: <20040130020839.0775de2e.kernel-list@majorstua.net>
In-Reply-To: <87r7xiba2k.fsf@lapper.ihatent.com>
References: <20040127233402.6f5d3497.akpm@osdl.org>
	<200401281313.03790.ender@debian.org>
	<200401281225.37234.s0348365@sms.ed.ac.uk>
	<87r7xiba2k.fsf@lapper.ihatent.com>
Reply-To: daniel@majorstua.net
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 	Hello, Andrew, I've switched from 2.6.2-rc1-mm1 to 2.6.2-rc1-mm1, and I've
> > > encountered this:
> > >
> > [snip]
> > 
> > Decided to build my first kernel with preempt since the early 2.5 days. I'm 
> > seeing the same warnings in 2.6.2-rc2-mm1.
> > 
> > gkrellm 0 waking gkrellm: 897 1485
> > Badness in try_to_wake_up at kernel/sched.c:722
> > Call Trace:
> >  [<c011a6a7>] try_to_wake_up+0x97/0x1d0
> >  [<c011b0b0>] __wake_up_common+0x30/0x60
> >  [<c011b109>] __wake_up+0x29/0x50
> >  [<c0131f1b>] wake_futex+0x2b/0x70
> >  [<c013259a>] do_futex+0x3fa/0x6e0
> >  [<c011d9d0>] copy_process+0x7b0/0x10a0
> >  [<c011e3a9>] do_fork+0xe9/0x179
> >  [<c011a142>] schedule+0x1d2/0x640
> >  [<c0132988>] sys_futex+0x108/0x130
> >  [<c03e1b9e>] sysenter_past_esp+0x43/0x65
> > 
> > Every five seconds. This is when it reads the sensor information from /sys, I 
> > think. And during boot, similar messages to those already reported (from 
> > kern.log this time).
> > 

As Zephaniah E. Hull suggested earlier, the message will disappear by reverting this patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/broken-out/futex-wakeup-debug.patch

Daniel Andersen
