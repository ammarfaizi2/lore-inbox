Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbTDDO0q (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDDOZl (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:25:41 -0500
Received: from modemcable169.53-202-24.mtl.mc.videotron.ca ([24.202.53.169]:57860
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263701AbTDDOUE (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 09:20:04 -0500
Date: Fri, 4 Apr 2003 09:26:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5-vanilla scribbles on memory on 8quad during boot
In-Reply-To: <20030404141037.GD993@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0304040925120.30262-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304040221510.30262-100000@montezuma.mastecende.com>
 <20030404141037.GD993@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, William Lee Irwin III wrote:

> On Fri, Apr 04, 2003 at 02:26:18AM -0500, Zwane Mwaikambo wrote:
> > This is all averted by my 'purge panic in as assign_irq_vector' 
> > patch, as well as my not so invasive pernode idt/vector patch.
> > Total of 32 processors activated (31453.18 BogoMIPS).
> > ENABLING IO-APIC IRQs
> >  printing eip:
> > c010c954
> > *pde = 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0060:[<c010c954>]    Not tainted
> > EFLAGS: 00010202
> > EIP is at set_intr_gate+0x14/0x30
> > eax: 00606f20   ebx: 07070707   ecx: 07070707   edx: c0138e00
> > esi: c0136f20   edi: 0000000c   ebp: 00000127   esp: c3c9ff40
> > ds: 007b   es: 007b   ss: 0068
> 
> Hmm, this is ugly. As it would otherwise panic(), what workaround was
> this done with?

This one was hit when an index into a NR_IRQS array went out of bounds due 
to the high irq count. I put in an 'if (irq > NR_IRQS) continue' in the 
workaround patch.

	Zwane
-- 
function.linuxpower.ca
