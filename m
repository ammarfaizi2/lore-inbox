Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270028AbUJTLQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270028AbUJTLQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269974AbUJTLLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:11:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:39839 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269917AbUJTLIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:08:06 -0400
Subject: Re: New consolidate irqs vs . probe_irq_*()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20041020120140.J1047@flint.arm.linux.org.uk>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
	 <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston>
	 <20041020100103.G1047@flint.arm.linux.org.uk>
	 <1098269455.20955.1.camel@gaston>
	 <20041020120140.J1047@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098270373.21028.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 21:06:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 21:01, Russell King wrote:
> On Wed, Oct 20, 2004 at 08:50:56PM +1000, Benjamin Herrenschmidt wrote:
> > > yenta_socket has always used it.  Its rather fundamental to the way
> > > that the PCMCIA core has worked for the last I don't know how many
> > > years.
> > > 
> > > Nothing new.  Maybe something in PPC64 land broke recently?
> > 
> > No, what happened is that until the big irq unification, ppc and ppc64
> > probe_* were no-ops. Probing of "ISA" irqs is a big no-no on most non
> > x86 architectures.
> 
> Well, I've no plans to rewrite that bit of PCMCIA anytime soon,
> especially as my time is very precious over the next two months
> or so.

I'm not asking you to do so :)

> Remember that PCMCIA effectively has its own IRQ router which requires
> the PCMCIA code to know which IRQs are physically connected and which
> aren't.  Unfortunately, there's no way to get that information as far
> as I know except by the published method in the code.

It's fine if the probe_* thing does nothing, though we could imagine a
specific arch callback at one point...

> So even if I had time to look at this, I doubt anything would change.
> I think it's a necessary evil.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

