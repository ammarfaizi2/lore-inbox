Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263398AbTCNR2I>; Fri, 14 Mar 2003 12:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263401AbTCNR2H>; Fri, 14 Mar 2003 12:28:07 -0500
Received: from mail-3.tiscali.it ([195.130.225.149]:42916 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263398AbTCNR2G>;
	Fri, 14 Mar 2003 12:28:06 -0500
Date: Fri, 14 Mar 2003 18:38:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Message-ID: <20030314173848.GH1375@dualathlon.random>
References: <20030314090825.GB1375@dualathlon.random> <200303141437.11589.m.c.p@wolk-project.de> <200303141810.54234.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303141810.54234.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 06:10:54PM +0100, Marc-Christian Petersen wrote:
> On Friday 14 March 2003 14:39, Marc-Christian Petersen wrote:
> 
> Hi Andrea,
> 
> > > Only in 2.4.21pre5aa1: 22_sched-deadlock-mmdrop-1
> > > 	Backport from 2.5 (in a more icache friendy way) an anti-deadlock
> > > 	fix for the o1 scheduler that can otherwise send a cross IPI with
> > > 	irq disabled.
> 
> > I get _tons_ of these messages:
> >
> > Initializing RT netlink socket
> > rq->prev_mm was c025b0e0 set to c025b0e0 - swapper
> > dffddf4c c0115786 c023b1a0 c025b0e0 c025b0e0 dffdc24e dffddfbc dffce02c
> >        dffdc000 00000000 dffdc000 dffddfbc c0105000 0008e000 c01072bd
> > 00000700 c0125d00 c02916a8 dffddfbc c0105000 0008e000 00000002 c01e0018
> > ....
> 
> I am going to rip out 22_sched-deadlock-mmdrop-1 because I dunno how to fix 
> this. The trace is annoying ;)

the fix for this was supposed to be included in the o1 scheduler patch,
there is been clearly a merging error, just drop the #ifdef CONFIG_SMP
around schedule_tail in arch/i386/kernel/entry.S and it'll work fine.

Andrea
