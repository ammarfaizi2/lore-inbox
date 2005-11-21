Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVKUV4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVKUV4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVKUV4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:56:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:42953 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751099AbVKUV4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:56:06 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0511211336440.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <1132607776.26560.23.camel@gaston>
	 <Pine.LNX.4.64.0511211336440.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 08:53:14 +1100
Message-Id: <1132609994.26560.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 13:38 -0800, Linus Torvalds wrote:

> The point is, it's _not_ a valid irq for 99.9% of all machines and drivers 
> that have ever been tested.

It is a valid irq for a wide range of embedded devices.

> Also, if you don't agree that 0 is special in the C language, then you're 
> just strictly _wrong_. It's an undeniable fact that zero _is_ special.

And ? I really don't agree that just because 0 "looks kewl", we should
enforce that and add some dodgy remapping all over the place.

It's not like it was difficult to fix the few drivers that make bogus
assumptions and use NO_IRQ instead ...

Ben.


