Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVLTS1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVLTS1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVLTS1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:27:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750850AbVLTS1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:27:34 -0500
Date: Tue, 20 Dec 2005 10:25:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
In-Reply-To: <43A81132.8040703@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0512201025100.4827@g5.osdl.org>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Dec 2005, Nick Piggin wrote:

> Nicolas Pitre wrote:
> > On Tue, 20 Dec 2005, Nick Piggin wrote:
> 
> > > Considering that on UP, the arm should not need to disable interrupts
> > > for this function (or has someone refuted Linus?), how about:
> > 
> > 
> > Kernel preemption.
> > 
> 
> preempt_disable() ?

Yes. It should almost always be faster than physically disabling 
interrupts anyway. Even if it's more instructions.

		Linus
