Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317697AbSGOT7y>; Mon, 15 Jul 2002 15:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317699AbSGOT7x>; Mon, 15 Jul 2002 15:59:53 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:11407 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S317697AbSGOT7x>;
	Mon, 15 Jul 2002 15:59:53 -0400
Date: Mon, 15 Jul 2002 14:01:40 -0600
From: yodaiken@fsmlabs.com
To: mbs <mbs@mc.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020715140140.A18132@hq.fsmlabs.com>
References: <Pine.LNX.4.33.0207151151200.19586-100000@penguin.transmeta.com> <200207151950.PAA11566@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207151950.PAA11566@mc.com>; from mbs@mc.com on Mon, Jul 15, 2002 at 03:52:37PM -0400
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 03:52:37PM -0400, mbs wrote:
> On Monday 15 July 2002 14:56, Linus Torvalds wrote:
> > (*) Which is a lot less than the hw can generate, since you mustn't allow
> > users to bog down the system in timer interrupts by just using
> > "itimer(ITIMER_REAL, .. fine-resolution..)".
> 
> actually, that is an interesting philosophical argument.
> 
> in an embedded system, it is sometimes more useful to not put artificial 

That's why we have RTLinux.

> in an embedded system a "tickless" system is sometimes preferable to a ticked 
> system.  there is often only one or a very small number of processes/threads 
> running and the extra overhead of 10 surplus clock ticks per process quantum 
> is a waste of cycles. (also when using a ppc or similar modern chip(flame 
> on;-), there is no need to keep a software wall clock, as the cpu has a 64bit 
> free running counter)  

Right: but "one or a very small number of processes/threads" does not apply to 
Linux.



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

