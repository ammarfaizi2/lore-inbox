Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264543AbSIQU5E>; Tue, 17 Sep 2002 16:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264565AbSIQU5E>; Tue, 17 Sep 2002 16:57:04 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:1664 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S264543AbSIQU5D>; Tue, 17 Sep 2002 16:57:03 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032293199.4588.235.camel@phantasy>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain> 
	<1032290611.4592.206.camel@phantasy> 
	<1032292468.11907.44.camel@spc9.esa.lanl.gov> 
	<1032293199.4588.235.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Sep 2002 14:58:04 -0600
Message-Id: <1032296284.12257.66.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 14:06, Robert Love wrote:
> On Tue, 2002-09-17 at 15:54, Steven Cole wrote:
> 
> Thank you for the testing, Steven.
> 
> > Running dbench 3 resulted in the dbench clients hanging and being
> > unkillable with kill -9 in the D state.
> 
> Hrm, I cannot reproduce this.  I just successfully completed a `dbench
> 16'.  Can you find where they are hanging?  You can get a trace via
> sysrq.  You can also see where they are in the kernel via the wchan
> field of ps: "ps -ewo user,pid,priority,%cpu,stat,command,wchan" is a
> favorite of mine.
Sorry, it hung so badly that it didn't respond to that.
> 
> Sure it does not happen with a stock kernel (no preempt)?

I just began testing plain vanilla 2.5.35-bk3 without preempt, and the
box has run up to 24 clients so far. So far so good.

> 
> What if you replace the printk() and dump_stack() in schedule() with a
> no-op (but not something that will optimize away the conditional, i.e.
> try a cpu_relax()).

I'll try that in a bit.

Steven

