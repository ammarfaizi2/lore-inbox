Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVLVQ6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVLVQ6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVLVQ6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:58:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10939 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932206AbVLVQ6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:58:34 -0500
Date: Thu, 22 Dec 2005 11:58:33 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051222164415.GA10628@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221156210.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222115329.GA30964@infradead.org>
 <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
 <20051222154012.GA6284@elte.hu>
 <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain>
 <20051222164415.GA10628@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > > i'm curious, how would this ARMv6 solution look like, and what would be 
> > > the advantages over the atomic swap based variant?
> > 
> > On ARMv6 (which can be SMP) the atomic swap instruction is much more 
> > costly than on former ARM versions.  It however has ll/sc instructions 
> > which allows it to implement a true atomic decrement, and the lock 
> > fast path would look like: [...]
> 
> but couldnt you implement atomic_dec_return() with the ll/sc 
> instructions? Something like:

NO.  My first example was atomic_dec_return based.  The second is 
lighter and fulfill the semantics of arch_mutex_fast_lock() but is not a 
common atomic primitive.


Nicolas
