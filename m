Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVCAXk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVCAXk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCAXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:40:58 -0500
Received: from gprs215-167.eurotel.cz ([160.218.215.167]:2708 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262133AbVCAXkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:40:07 -0500
Date: Wed, 2 Mar 2005 00:39:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301233952.GG2062@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301020722.6faffb69.akpm@osdl.org> <20050301022116.2bbd55a0.akpm@osdl.org> <20050301105625.GH1345@elf.ucw.cz> <20050301123522.1bb8cfec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301123522.1bb8cfec.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Relocating pagedir | 
> > > Reading image data (8157 pages): 100% 8157 done.
> > > Stopping tasks: ====|                           
> > > Freeing memory... done (0 pages freed)
> > > Freezing CPUs (at 1)...Sleeping in:   
> > >  [<c0103c1d>] dump_stack+0x19/0x20 
> > >  [<c0133c7f>] smp_pause+0x1f/0x54 
> > >  [<c010ee27>] smp_call_function_interrupt+0x3b/0x60
> > >  [<c01037d4>] call_function_interrupt+0x1c/0x24    
> > >  [<c0101111>] cpu_idle+0x55/0x64               
> > >  [<c05929ed>] start_secondary+0x71/0x78
> > >  [<00000000>] 0x0                      
> > >  [<cffa5fbc>] 0xcffa5fbc
> > > ok                      
> > > double fault, gdt at c1203260 [255 bytes]
> > > NMI Watchdog detected LOCKUP on CPU1, eip c0133c96, registers:
> 
> Note the double fault.

Yes, I can see it, it scares me. SMP swsusp is not in good state
because I do not have easy access to SMP or HT hardware. I guess I'll
just have to get into suse at the night and steal some P4 ;-).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
