Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVCHS0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVCHS0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVCHS0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:26:17 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:35489 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261497AbVCHS0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:26:10 -0500
Date: Tue, 8 Mar 2005 11:27:29 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: Robert Love <rml@novell.com>, Imanpreet Arora <imanpreet@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Question regarding thread_struct
In-Reply-To: <2cd57c9005030810144cfc0b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503081127070.30824@montezuma.fsmlabs.com>
References: <c26b959205030809044364b923@mail.gmail.com> 
 <1110302000.23923.14.camel@betsy.boston.ximian.com> 
 <c26b959205030809271b8a5886@mail.gmail.com>  <1110302922.28921.3.camel@betsy.boston.ximian.com>
 <2cd57c9005030810144cfc0b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Coywolf Qi Hunt wrote:

> On Tue, 08 Mar 2005 12:28:42 -0500, Robert Love <rml@novell.com> wrote:
> > On Tue, 2005-03-08 at 22:57 +0530, Imanpreet Arora wrote:
> > 
> > > This has been a doubt for a couple of days, and I am wondering if this
> > > one could also be cleared. When you say kernel stack, can't be resized
> > >
> > >
> > > a)       Does it mean that the _whole_ of the kernel is restricted to
> > > that 8K or 16K of memory?
> > 
> > Actually, 4K or 8K these days for x86.  But, no, it means that EACH
> > PROCESS is constrained to the kernel stack.  The stacks are per-process.
> > The kernel never "runs on its own" -- it is always in the context of a
> > process (which has its own kernel stack) or an interrupt handler (which
> > either shares the previous process's stack or has its own stack,
> > depending on CONFIG_IRQSTACKS).
>  
> 
> CONFIG_IRQSTACKS seems only on ppc64. Is it good to add for other archs too?

i386 and x86_64 also have IRQ stacks
