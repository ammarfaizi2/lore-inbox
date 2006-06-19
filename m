Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWFSWcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWFSWcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWFSWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:32:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41179 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964956AbWFSWcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:32:22 -0400
Date: Tue, 20 Jun 2006 00:16:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619221655.GB1648@openzaurus.ucw.cz>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> while looking for loop places to apply cpu_relax() to, I found the
> following gems:
> 
> arch/i386/kernel/crash.c/crash_nmi_callback():
> 
>         /* Assume hlt works */
>         halt();
>         for(;;);
> 
>         return 1;
> }
> 
> arch/i386/kernel/doublefault.c/doublefault_fn():
> 
>         for (;;) /* nothing */;
> }
> 
> Let's assume that we have a less than moderate fan failure that causes
> the CPU to heat up beyond the critical limit...
> That might result in - you guessed it - crashes or doublefaults.
> In which case we enter the corresponding handler and do... what?
> Exactly, we accelerate the CPUs happy march into bit heaven by letting it

...
> Am I completely missing something here?

Yes. You are missing that modern hw already protects itself. See my  blog on planet.kernel.org.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

