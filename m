Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbULKSqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbULKSqL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULKSqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 13:46:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:32712 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261978AbULKSqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 13:46:08 -0500
Date: Sat, 11 Dec 2004 10:45:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
 series
In-Reply-To: <1102774756.7267.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412111041440.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz> 
 <1102712732.3264.73.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org> 
 <1102723114.4774.9.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org> 
 <1102726628.4948.1.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0412102020190.31040@ppc970.osdl.org>
 <1102774756.7267.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Dec 2004, Alan Cox wrote:
> 
> ps: Pavel - the X folks played with several ideas for handling
> interrupts from user space that could be shared, forwarded to user space
> and handled and it always came back to either a small kernel module or
> an interpretable set of descriptions of how to test for and mask the
> IRQ, and in some cases to save several values.

The interpreter idea is somewhat interesting, especially if the "language"
can be actually "compiled" into some threaded format or similar. I suspect 
that a number of special devices that you don't want to maintain a 
real kernel module for could be handled that way.

However, I also suspect that such a thing would eventually explode with 
special cases and support for new features people want, to the point 
where it gets quite complex, and a kernel module might be easier after all ;)

		Linus
