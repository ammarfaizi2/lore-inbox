Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUIJXaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUIJXaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUIJXaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:30:20 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:40601 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268035AbUIJX2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:28:33 -0400
Date: Fri, 10 Sep 2004 16:28:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040910232826.GA3302@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org> <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl> <20040910231052.GA3078@taniwha.stupidest.org> <1094854872.18282.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094854872.18282.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:21:26PM +0100, Alan Cox wrote:

> On a lot of 2.4 boxes they aren't harmless but thats 2.4 IPI
> messsage handling bugs. People sometimes assume an IPI is delivered
> once - but its not its delivered "at least once" and when you get a
> checksum error like on old dual celerons you get replays.


it sounds like leaving it as KERN_DEBUG is the right thing to do then


> > > > -			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
> > > > +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);

> This should really go.

do we want counters for this?  what about the APIC case?

