Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVCAUjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVCAUjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCAUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:37:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:57540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbVCAUfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:35:46 -0500
Date: Tue, 1 Mar 2005 12:35:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-Id: <20050301123522.1bb8cfec.akpm@osdl.org>
In-Reply-To: <20050301105625.GH1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz>
	<20050301020722.6faffb69.akpm@osdl.org>
	<20050301022116.2bbd55a0.akpm@osdl.org>
	<20050301105625.GH1345@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > Resume on SMP locks up.
> 
> Does it work on UP kernel on same hardware?

yup.

> NMI watchdog is problem
> for suspend, it takes long to do various phases. Can you disable it
> for testing?

Will try to remember to do that.

> > Relocating pagedir | 
> > Reading image data (8157 pages): 100% 8157 done.
> > Stopping tasks: ====|                           
> > Freeing memory... done (0 pages freed)
> > Freezing CPUs (at 1)...Sleeping in:   
> >  [<c0103c1d>] dump_stack+0x19/0x20 
> >  [<c0133c7f>] smp_pause+0x1f/0x54 
> >  [<c010ee27>] smp_call_function_interrupt+0x3b/0x60
> >  [<c01037d4>] call_function_interrupt+0x1c/0x24    
> >  [<c0101111>] cpu_idle+0x55/0x64               
> >  [<c05929ed>] start_secondary+0x71/0x78
> >  [<00000000>] 0x0                      
> >  [<cffa5fbc>] 0xcffa5fbc
> > ok                      
> > double fault, gdt at c1203260 [255 bytes]
> > NMI Watchdog detected LOCKUP on CPU1, eip c0133c96, registers:

Note the double fault.

