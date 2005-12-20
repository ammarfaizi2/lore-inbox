Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVLTThT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVLTThT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVLTThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:37:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53769 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750938AbVLTThR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:37:17 -0500
Date: Tue, 20 Dec 2005 19:37:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051220193700.GD24199@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au> <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <43A81DD4.30906@yahoo.com.au> <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain> <20051220192018.GB24199@flint.arm.linux.org.uk> <1135107155.2952.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135107155.2952.30.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 08:32:35PM +0100, Arjan van de Ven wrote:
> 
> > So, to sum up, if this path is persued, mutexes will be a bloody
> > disaster on ARM.  We'd be far better off sticking to semaphores
> > and ignoring this mutex stuff.
> 
> on x86 the fastpath is the same for both basically.. is there a
> fundamental reason it can't be for ARM?

If we're talking about implementing mutexes as a semaphore, then they
will be identical.  But what's the point of that?  It's a semaphore
which is just called a mutex.

So you might as well just save the patch noise and do nothing instead.
It seems to me that you'll get _exactly_ the same result with a lot
less effort.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
