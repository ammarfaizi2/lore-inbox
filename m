Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTJQKdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTJQKdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:33:13 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:6615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263389AbTJQKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:33:10 -0400
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031017101916.B24238@flint.arm.linux.org.uk>
References: <20031009174604.GC7665@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org>
	 <20031015171411.GH610@krispykreme>
	 <20031017101916.B24238@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1066386735.4777.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 12:32:16 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 11:19, Russell King wrote:
> On Thu, Oct 16, 2003 at 03:14:11AM +1000, Anton Blanchard wrote:
> > >From memory at least x86, alpha, ppc32 and ppc64 worked with Andrey's
> > irq consolidation patches. I'll be pushing for it in 2.7 together with
> > some macros to abstract away irq_desc[NR_IRQS] completely. (it will
> > make it easier to support 24 bit irqs on ppc64 and should allow sparc64
> > to use the consolidated irq code).
> 
> (CC list snipped)
> 
> >From what I heard, benh was seriously considering changing ppc64 IRQ
> stuff in 2.7 to use something like the system we have in ARM.

It's on my list of things to investigate once I've reached OzLabs, indeed.

Right now, I have horrible hacks for the "second" OpenPIC in G5s, and
we are indeed reaching the limits of our current irq model. I don't know
yet what direction I will take though. I'm also considering the possibility
of merging ppc32 and ppc64 archs :)

Ben.


