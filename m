Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSKGQOl>; Thu, 7 Nov 2002 11:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSKGQOl>; Thu, 7 Nov 2002 11:14:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17676 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261409AbSKGQOk>; Thu, 7 Nov 2002 11:14:40 -0500
Date: Thu, 7 Nov 2002 11:20:05 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: John Levon <levon@movementarian.org>
cc: Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
In-Reply-To: <20021106200726.GA2388@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.3.96.1021107111731.30525A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, John Levon wrote:

> On Wed, Nov 06, 2002 at 11:49:07AM -0800, george anzinger wrote:
> 
> > So the performance counters are only used on UP machines?
> 
> no. nmi_watchdog=1 -> I/O APIC is used iff available and it works
> nmi_watchdog=2 -> local APIC LVTPC set to interrupt in NMI mode when
> perfctr overflows.
> 
> =2 can be used on both UP and SMP, =1 is only available on UP for the
> rare machines that have an I/O APIC on a UP motherboard (I believe there
> are some, but I don't know if the code is set up to do so properly).

By any chance, does this implementation imply that if I boot SMP with
'noapic' the NMI watchdog won't work? It doesn't, but I am not sure I had
it on before I turned off the APIC.

Clearly this would be desirable to work, as noapic is needed on a fairly
large minority of machines.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

