Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbULKCBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbULKCBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULKCBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:01:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43739 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261908AbULKCBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:01:15 -0500
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
	series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
	 <1102712732.3264.73.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
	 <1102723114.4774.9.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102726628.4948.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Dec 2004 00:57:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 01:23, Linus Torvalds wrote:
> > Until the 10,000th event it actually seems to work rather happily
> > without that change.
> 
> I suspect you never tried the level-triggered case.

Level triggered has never been supported. Putting a single disable_irq
in doesn't change the fact it doesn't work because the IRQ is never
re-enabled.


