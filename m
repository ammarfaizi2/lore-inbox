Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUA1PS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUA1PS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:18:29 -0500
Received: from ns.suse.de ([195.135.220.2]:480 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266018AbUA1PSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:18:25 -0500
Date: Wed, 28 Jan 2004 16:18:24 +0100
From: Andi Kleen <ak@suse.de>
To: Martin Polak <mpolak@gup.jku.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
Message-Id: <20040128161824.3a2cd2c5.ak@suse.de>
In-Reply-To: <40176C85.90009@gup.jku.at>
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel>
	<p73fze1fdk4.fsf@nielsen.suse.de>
	<40176C85.90009@gup.jku.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 09:02:13 +0100
Martin Polak <mpolak@gup.jku.at> wrote:

> Andi Kleen wrote:
> > Jan Kasprzak <kas@informatics.muni.cz> writes:
> > 
> > You don't say if you run a 32bit or a 64bit kernel. I will assume 64bit.
> >  
> > 
> >>Is it normal? How can I set up some IRQ balancing (or at least hard-wire
> >>3ware for CPU1 and eth0 for CPU0)?
> > 
> > 
> > Run irqbalanced
> >  
> > 
> Well I posted that thing two weeks ago, occuring on a dual 240 
> K8T-Master from MSI, and yes: running irqbalance works fine, but still I 
> believe that there is some sort of weirdness in initialization code of 
> the kernel (2.6), because on 2.4 Kernels smp-affinity defaults to every 
> cpu and on 2.6 it doesnt.

Opteron doesn't support irq balancing in hardware (at least not with the 
AMD chipset). 2.4/x86-64 kernels didn't have it neither.

Some version of 32bit kernels do automatic irq balancing in the kernel though.

-Andi
