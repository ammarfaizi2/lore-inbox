Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbTCJBDE>; Sun, 9 Mar 2003 20:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbTCJBDE>; Sun, 9 Mar 2003 20:03:04 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:52072
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262688AbTCJBDE>; Sun, 9 Mar 2003 20:03:04 -0500
Date: Sun, 9 Mar 2003 20:11:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] small fixes in brlock.h
In-Reply-To: <1047255023.680.16.camel@phantasy.awol.org>
Message-ID: <Pine.LNX.4.50.0303091928430.1464-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
  <1047254400.680.10.camel@phantasy.awol.org> 
 <Pine.LNX.4.50.0303091901370.1464-100000@montezuma.mastecende.com>
 <1047255023.680.16.camel@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Robert Love wrote:

> Yep.  Any interrupt, actually.
> 
> Or the reschedule IPI on SMP systems.
> 
> Kernel preemption off an interrupt is actually the most common (and the
> ideal) place to preempt since an interrupt is usually what wakes up a
> task off I/O and sets need_resched.  So kernel preemption lets us
> reschedule the higher priority task the moment the interrupt wakes it
> up.  Of course, if a lock is held, we have to wait till we drop it.

Thanks for clearing that up, i'll probably need to relook at some of my 
code to be sure.

	Zwane
-- 
function.linuxpower.ca
