Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265732AbSKODsJ>; Thu, 14 Nov 2002 22:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSKODsJ>; Thu, 14 Nov 2002 22:48:09 -0500
Received: from holomorphy.com ([66.224.33.161]:31436 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265732AbSKODsI>;
	Thu, 14 Nov 2002 22:48:08 -0500
Date: Thu, 14 Nov 2002 19:52:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] early printk for x86
Message-ID: <20021115035225.GQ22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, Dave Hansen <haveblue@us.ibm.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <3DD3FCB3.40506@us.ibm.com> <3DD40719.5030108@pobox.com> <3DD428C3.4030700@us.ibm.com> <20021115044300.C20764@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115044300.C20764@wotan.suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>>> VGA and serial are certainly not hammer+ia32-specific.  Make the generic 
>>> parts generic...   the arch-specific components would need to change 
>>> early-foo base addresses perhaps, but otherwise, it's pretty generic.

On Thu, Nov 14, 2002 at 02:50:43PM -0800, Dave Hansen wrote:
>> Take 2.
>> - Move the x86_64 early_printk.c into kernel/
>> - move some of the basic defines into linux/early_printk.h and
>>   asm-{i386,x86_64}/early_printk.h
>> - run the setup in start_kernel() before setup_arch()

On Fri, Nov 15, 2002 at 04:43:00AM +0100, Andi Kleen wrote:
> That's overkill. Most architectures have an early_printk equivalent in 
> firmware. Only i386 and x86-64 are not lucky enough to have one 
> that is usable from the CPU mode linux uses.

Perhaps s/early_printk/prom_printf/ would pick up a few arches for free.


Bill
