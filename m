Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbULKBXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbULKBXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 20:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbULKBXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 20:23:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:45547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261903AbULKBXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 20:23:14 -0500
Date: Fri, 10 Dec 2004 17:23:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
 series
In-Reply-To: <1102723114.4774.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz> 
 <1102712732.3264.73.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
 <1102723114.4774.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Dec 2004, Alan Cox wrote:
>
> On Gwe, 2004-12-10 at 22:55, Linus Torvalds wrote:
> > On Fri, 10 Dec 2004, Alan Cox wrote:
> > The vm86 interrupt does not allow sharing. And it really _has_ to be 
> > disabled until user mode has cleared the irq source, or you'll have a very 
> > dead machine.
> 
> Until the 10,000th event it actually seems to work rather happily
> without that change.

I suspect you never tried the level-triggered case.

In the level-triggered case, the 10,000 interrupts happen faster than 
user-mode can even say "Whaaa?".

		Linus
