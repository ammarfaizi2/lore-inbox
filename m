Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVKUVwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVKUVwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVKUVwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:52:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbVKUVwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:52:21 -0500
Date: Mon, 21 Nov 2005 13:51:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Mackerras <paulus@samba.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <20051121213527.GA6452@elte.hu>
Message-ID: <Pine.LNX.4.64.0511211350010.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu>
 <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <20051121213527.GA6452@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Nov 2005, Ingo Molnar wrote:
> 
> oh well [*]. Then it's gotta be the !dev->irq.valid thing i guess. 

No it's not.

The ppc PCI probing could trivilly just turn a 0 into 256 (or equivalent), 
and mask off the low 7 bits when installing the handler.  They know the 
interrupt is _really_ 0 from other sources (ie they have a different 
firmware, with explicit callbacks, and/or hardcoded knowledge).

		Linus
