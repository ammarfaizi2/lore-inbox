Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVLTT72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVLTT72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVLTT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:59:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:5058 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750836AbVLTT71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:59:27 -0500
Date: Tue, 20 Dec 2005 14:59:26 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <1135107155.2952.30.camel@laptopd505.fenrus.org>
X-X-Sender: nico@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512201456030.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
 <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <43A81DD4.30906@yahoo.com.au>
 <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
 <20051220192018.GB24199@flint.arm.linux.org.uk>
 <1135107155.2952.30.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Arjan van de Ven wrote:

> on x86 the fastpath is the same for both basically.. is there a
> fundamental reason it can't be for ARM?

ARM prior ARM architecture level 6 (which means about 99% of all ARM 
processors in the field currently) cannot do an atomic 
decrement/increment.  It must be done manually with interrupt disabled.

The only truly atomic instruction it has is a swap which lays itself 
pretty well for mutex support.


Nicolas
