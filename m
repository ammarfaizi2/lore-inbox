Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbULKTvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbULKTvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbULKTvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:51:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13789 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261622AbULKTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:51:18 -0500
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
	series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.58.0412111041440.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
	 <1102712732.3264.73.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
	 <1102723114.4774.9.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org>
	 <1102726628.4948.1.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412102020190.31040@ppc970.osdl.org>
	 <1102774756.7267.17.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412111041440.31040@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102790805.8194.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Dec 2004 18:46:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 18:45, Linus Torvalds wrote:
> The interpreter idea is somewhat interesting, especially if the "language"
> can be actually "compiled" into some threaded format or similar. I suspect 
> that a number of special devices that you don't want to maintain a 
> real kernel module for could be handled that way.

The example I gave is sufficient for vblank on every video card that was
looked at (which is the main X interest for the Xsync extensions). You
also only have to turn the descriptor from "type, size" into function
pointer to get good performance .. at least I think that will be the
case

	if((op->func(op->offset) & op->mask) != op->value)
		return IRQ_NONE;

> However, I also suspect that such a thing would eventually explode with 
> special cases and support for new features people want, to the point 
> where it gets quite complex, and a kernel module might be easier after all ;)

For some devices most definitely. The simple descriptors unfortunately
will degenerate into ACPI otherwise.

Alan

