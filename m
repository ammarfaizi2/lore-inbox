Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSKODgH>; Thu, 14 Nov 2002 22:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSKODgH>; Thu, 14 Nov 2002 22:36:07 -0500
Received: from ns.suse.de ([213.95.15.193]:3848 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265681AbSKODgH>;
	Thu, 14 Nov 2002 22:36:07 -0500
Date: Fri, 15 Nov 2002 04:43:00 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
Message-ID: <20021115044300.C20764@wotan.suse.de>
References: <3DD3FCB3.40506@us.ibm.com> <3DD40719.5030108@pobox.com> <3DD428C3.4030700@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD428C3.4030700@us.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 02:50:43PM -0800, Dave Hansen wrote:
> Jeff Garzik wrote:
> >VGA and serial are certainly not hammer+ia32-specific.  Make the generic 
> >parts generic...   the arch-specific components would need to change 
> >early-foo base addresses perhaps, but otherwise, it's pretty generic.
> 
> Take 2.
> 
> - Move the x86_64 early_printk.c into kernel/
> - move some of the basic defines into linux/early_printk.h and
>   asm-{i386,x86_64}/early_printk.h
> - run the setup in start_kernel() before setup_arch()

That's overkill. Most architectures have an early_printk equivalent in 
firmware. Only i386 and x86-64 are not lucky enough to have one 
that is usable from the CPU mode linux uses.

-Andi
