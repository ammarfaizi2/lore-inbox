Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbULJWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbULJWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULJWz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:55:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:5252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261849AbULJWz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:55:57 -0500
Date: Fri, 10 Dec 2004 14:55:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
 series
In-Reply-To: <1102712732.3264.73.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
 <1102712732.3264.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Dec 2004, Alan Cox wrote:
> 
> You can't disable_irq and return to user space - the IRQ may be shared
> by a device needed to make user space progress. 

The vm86 interrupt does not allow sharing. And it really _has_ to be 
disabled until user mode has cleared the irq source, or you'll have a very 
dead machine.

		Linus
