Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVJQQDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVJQQDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVJQQDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:03:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932311AbVJQQDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:03:07 -0400
Date: Mon, 17 Oct 2005 09:02:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <200510171740.57614.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0510170901460.23590@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de>
 <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org> <200510171740.57614.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Andi Kleen wrote:

> On Monday 17 October 2005 17:27, Linus Torvalds wrote:
> > On Mon, 17 Oct 2005, Andi Kleen wrote:
> > > The patch is actually not quite correct - in theory node 0 could be too
> > > small to contain the full swiotlb bounce buffers.
> >
> > Is node 0 guaranteed to be all low-memory? What if it allocates stuff at
> > the end of memory on NODE(0)?
> 
> This is 64bit ... only low memory.

Ehh.. No there isn't.

PCI DMA isn't magically 64-bit, even on your Opteron. 

So low memory in this case is anything < 32 bits. How many bits the CPU 
has is immaterial.

That's the whole _point_ of swtlb, after all, so I don't see why you 
argue.

		Linus
