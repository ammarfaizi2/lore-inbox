Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317967AbSGLB2s>; Thu, 11 Jul 2002 21:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317969AbSGLB2r>; Thu, 11 Jul 2002 21:28:47 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:12768 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S317967AbSGLB2q>; Thu, 11 Jul 2002 21:28:46 -0400
Date: Thu, 11 Jul 2002 21:37:39 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <1026435320.1178.362.camel@sinai>
Message-ID: <Pine.LNX.4.33.0207112107070.7158-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Why must HZ be the same as 'interrupts per second'?
> > 
> > s/interrupts/scheduler calls/
> 
> Uh, HZ is not scheduler calls per second.
> 
> Neither exactly is it interrupts per second, but _timer_ interrupts per
> second.  It is the frequency of the timer interrupt.

is there really code which uses HZ which is not merely fiddling with jiffies?
that is, HZ is merely "jiffies per second".  there's no reason the timer
(if any!) couldn't run faster than HZ, even at different ratios depending on
power level.

afaikt, jiffies has survived because there's a need for a
moderately fast, strictly monotonically increasing clock.
that doesn't imply that the periodic timer needs to run at HZ
or even that such a clock exists (tickless).  
just that the kernel promises to update jiffies at HZ,
even if that means HZ is 1M, and goes by jumps of 10K.

