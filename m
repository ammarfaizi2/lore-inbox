Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSBWSUY>; Sat, 23 Feb 2002 13:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293172AbSBWSUP>; Sat, 23 Feb 2002 13:20:15 -0500
Received: from zero.tech9.net ([209.61.188.187]:51722 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293171AbSBWSUH>;
	Sat, 23 Feb 2002 13:20:07 -0500
Subject: Re: [PATCH] only irq-safe atomic ops
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020223043815.B29874@hq.fsmlabs.com>
In-Reply-To: <3C773C02.93C7753E@zip.com.au>,
	<1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au>
	<1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> 
	<20020223043815.B29874@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 13:20:06 -0500
Message-Id: <1014488408.846.806.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 06:38, yodaiken@fsmlabs.com wrote:

> So without preemption in the kernel
> 	maybe 4 instructions: calculate cpuid, inc; all local no cache ping
> 	code is easy to read and understand.
> 
> with preemption in the kernel
> 	a design problem. a slippery synchronization issue that 
> 	involves the characteristic preemption error - code that works
> 	most of the time.

Or not.  The topic of this thread was a micro-optimization.  If we treat
the variable as anything normal requiring synchronization under SMP, any
of the standard solutions (atomic ops, etc.) work.  If we want to get
fancy, we can disable preemption, use my atomic_irq ops, or just not
care.

	Robert Love

