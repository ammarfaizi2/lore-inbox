Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUAOWOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUAOWOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:14:49 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3968 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263891AbUAOWOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:14:44 -0500
Date: Thu, 15 Jan 2004 22:21:39 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401152221.i0FMLdQr000218@81-2-122-30.bradfords.org.uk>
To: Pavel Machek <pavel@ucw.cz>, Robert Love <rml@ximian.com>
Cc: Daniel Gryniewicz <dang@fprintf.net>, Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040115204257.GG467@openzaurus.ucw.cz>
References: <20040111025623.GA19890@ncsu.edu>
 <1073791061.1663.77.camel@localhost>
 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
 <1073841200.1153.0.camel@localhost>
 <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
 <1073843690.1153.12.camel@localhost>
 <20040114045945.GB23845@redhat.com>
 <1074107508.4549.10.camel@localhost>
 <1074107842.1153.959.camel@localhost>
 <20040115204257.GG467@openzaurus.ucw.cz>
Subject: Re: Laptops & CPU frequency
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I have an athlon-xp laptop (HP pavilion ze4500) with powernow that
> > > definitely goes into low power mode when the plug is pulled.  The screen
> > > goes dark, and everything slows down.
> > 
> > Dave did not mean that the other power management schemes cannot do the
> > automatic reduction on loss of AC, just that there is no SMM/BIOS hacks
> > to do it automatically.
> 
> People are designing machines where battery can't provide
> enough ampers for cpu in high-power mode. If speedstep machines
> have same problem, SMM is actually right thing to do.

This reminds me of an idea I had years ago, but never really looked in
to very much, (it may well have been implemented somewhere
independently of my idea anyway).  Basically, it was for a multi-cpu
machine which, instead of running cpus in parallel, with all the
common scaling problems, ran each CPU in series for a very short
timeslice, effectively being a uni-processor machine, but moving the
state of the processor's registers between physical CPUs.  The theory
was that it would be possible to clock each CPU much higher for a
short period of time than it could be successfully clocked
continuously.  Physical CPUs with poor cooling could even be given a
shorter timeslice.

John.
