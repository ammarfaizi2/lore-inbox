Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLTWnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLTWnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVLTWnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:43:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39896 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932137AbVLTWnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:43:12 -0500
Date: Tue, 20 Dec 2005 17:43:03 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
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
Message-id: <Pine.LNX.4.64.0512201731590.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
 <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org>
 <20051220193423.GC24199@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org>
 <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Linus Torvalds wrote:

> Quite frankly, what has disgusted me about this mutex discussion is the 
> totally specious arguments for the new mutexes that just rubs me entirely 
> the wrong way.
>
[...]
>
> In other words: if people didn't mix up issues that had nothing to do with 
> this into it, I'd be happier. I've already said that a mutex that does 
> _not_ replace semaphore (and doesn't mess with naming) is acceptable. 

Oh if it is so we are in _violent_ agreement then.  I don't dispute that 
at all and I pretty agree with a separate namespace for mutexes.  
Actually I think no one contested that either.

Current semaphores can be migrated to mutexes individually when that 
makes sense to do so, separately.

With regards to my _implementation_ concerns about the proposed mutex 
patches I guess I can discuss them with Ingo (and an actual patch is 
coming to fix them).


Nicolas
