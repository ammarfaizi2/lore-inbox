Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267201AbUGMWnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbUGMWnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbUGMWmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:42:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:26011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267199AbUGMWmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:42:04 -0400
Date: Tue, 13 Jul 2004 15:44:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713154448.4d29e004.akpm@osdl.org>
In-Reply-To: <20040713223701.GM974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407130001.i6D01pkJ003489@localhost.localdomain>
	<20040712170844.6bd01712.akpm@osdl.org>
	<20040713162539.GD974@dualathlon.random>
	<20040713114829.705b9607.akpm@osdl.org>
	<20040713213847.GH974@dualathlon.random>
	<20040713145424.1217b67f.akpm@osdl.org>
	<20040713220103.GJ974@dualathlon.random>
	<20040713152532.6df4a163.akpm@osdl.org>
	<20040713223701.GM974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, Jul 13, 2004 at 03:25:32PM -0700, Andrew Morton wrote:
> > 	local_irq_disable();
> > 	<fiddle with per-cpu stuff>
> > 	function_which_calls_cond_resched();
> > 	<fiddle with per-cpu stuff>
> > 	local_irq_enable();
> > 
> > then we want might_sleep() to warn about the bug.
> 
> might_sleep currently _doesn't_ warn about any bug in the above case I
> quoted.
> 
> the kmalloc example is trapped instead.

Yeah, I know.  might_sleep() in cond_resched() makes sense.

> >From my part I don't like anybody to call schedule with irq disabled

I'd agree with that.  But when I "fixed" it, Ingo unfixed it again and I
didn't have sufficiently strong feelings either way to object.

