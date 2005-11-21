Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVKUXBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVKUXBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKUXBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:01:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:37578 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751235AbVKUXBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:01:34 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
In-Reply-To: <Pine.LNX.4.64.0511211418391.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
	 <1132610802.26560.44.camel@gaston>
	 <Pine.LNX.4.64.0511211418391.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 09:58:44 +1100
Message-Id: <1132613925.26560.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So you could just make the ppc PCI probing do
> 
> 	dev->irq = PCI_IRQ_BASE + node->intrs[0].line;
> 
> and suddenly 0 works equally well for you as it does on a regular PC. 
> 
> Notice? Magic. Suddenly "0" means "No irq" on ppc too.

Not really, we also need to fix the interrupt controller code among
others...

Ben.


