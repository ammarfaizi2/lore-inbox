Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWFTJze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWFTJze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWFTJze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:55:34 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:16311 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932543AbWFTJze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:55:34 -0400
Date: Tue, 20 Jun 2006 11:54:55 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
In-Reply-To: <20060619202354.GD26759@redhat.com>
Message-ID: <Pine.LNX.4.61.0606201143370.2481@yvahk01.tjqt.qr>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
 <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Let's assume that we have a less than moderate fan failure that causes
> > > the CPU to heat up beyond the critical limit...
> > > That might result in - you guessed it - crashes or doublefaults.
> > > In which case we enter the corresponding handler and do... what?
> > 
> > A CPU without a fan will go into
> > a cold, cold, shutdown, requiring a hardware reset to get it out of
> > that latched, no internal clock running, mode.
>
>Wrong.
>

Fact: The fan of a Sony Vaio U3 (TM5800 CPU) increases its speed when:
- I'm in the BIOS (seems programmed using busy-wait)
- kernel panic
- or worse

IOW, whenever it is not executing HLT.
What do we learn? No automatic shutdown, at least not into a cool state.

> > In the first place, when the Intel and AMD CPUs overheat, they
> > shut down. 

Can't confirm this either. The same behavior as with the TM5800 (above 
list) can be experienced with (also autonomic fans) with AMD K6
(preferably VIA Apollo boards).

>cpu_relax() and friends aren't going to save a box in light of
>a fan failure in my experience.  
>However for a box which has locked up (intentionally)
>running instructions that do save power in a loop has obvious advantages.


Jan Engelhardt
-- 
