Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318948AbSH1Ujb>; Wed, 28 Aug 2002 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSH1Ujb>; Wed, 28 Aug 2002 16:39:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47112 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318948AbSH1UjP>; Wed, 28 Aug 2002 16:39:15 -0400
Date: Wed, 28 Aug 2002 13:46:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDE7@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0208281343170.8978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Grover, Andrew wrote:
> 
> Well TMTA CPUs would seem to be easy, because all this is done behind the
> OS's back, right?

Yes. However, I certainly wouldn't mind having the same interfaces as 
everybody else to set things like "aggressive" vs "powersave". Transmeta 
does all the actual _work_ behind the OS's back, but you can still tell 
the CPU what policy to take, and what frequency limits to use.

> Let's talk about CPUs in which the OS has to control processor performance.
> The way I see it, there are a bunch of inputs that are going to determine
> CPU speed & voltage: user preference, workload, and thermals.

Absolutely. 

> Any workload analysis has to be in the kernel.

...with user mode input (ie user mode can know a lot of high-level stuff
that the kernel _doesn't_ know). So the kernel does potentially need user
input on policy.

		Linus

