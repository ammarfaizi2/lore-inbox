Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSGXIMP>; Wed, 24 Jul 2002 04:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSGXIMO>; Wed, 24 Jul 2002 04:12:14 -0400
Received: from holomorphy.com ([66.224.33.161]:36240 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318268AbSGXIMO>;
	Wed, 24 Jul 2002 04:12:14 -0400
Date: Wed, 24 Jul 2002 01:15:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
Message-ID: <20020724081511.GC25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@zip.com.au>,
	Robert Love <rml@tech9.net>, george anzinger <george@mvista.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020724080329.GB25038@holomorphy.com> <Pine.LNX.4.44.0207241003570.7635-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207241003570.7635-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, William Lee Irwin III wrote:
>> Since we're on the subject of preempt_schedule() being done at
>> inappropriate times, I'm seeing it being called and panicking the
>> machine before the per-cpu GDT, IDT, TSS, and LDT are loaded in
>> cpu_init() and suspect that may be a wee bit too early to be sane.

On Wed, Jul 24, 2002 at 10:06:28AM +0200, Ingo Molnar wrote:
> i've fixed this in my tree: the init thread needs to start up with a
> nonzero preempt_count, and schedule_init() sets it to 0. [schedule_init()  
> is the point after we can schedule.]

Sorry about the duplicated report, I must have missed the fix in the
changelogs. I've been following closely in general partly because my
machines are very sensitive to i386 interrupt changes, and I need to
help do testing and report things early as you're not likely to have a
similar machine.

Since it's where the fixes are going, it looks like I'd better use
your tree. I'll follow up once I've updated and had time to test.
(They are unfortunately very slow to boot.)

Thanks,
Bill
