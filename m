Return-Path: <linux-kernel-owner+w=401wt.eu-S1760777AbWLHRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760777AbWLHRSb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760778AbWLHRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:18:31 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4488 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760777AbWLHRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:18:30 -0500
Date: Fri, 8 Dec 2006 17:18:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208171816.GG31068@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	David Howells <dhowells@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org,
	akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 09:06:00AM -0800, Christoph Lameter wrote:
> On Fri, 8 Dec 2006, David Howells wrote:
> 
> > > It is the most universal atomic instruction that I know of.
> > 
> > I think TAS-type things and XCHG-type things are more common.
> 
> Huh? The most popular architectures are i386 x86_64 sparc ia64 etc which 
> all have one or the other form of cmpxchg (some issues with early sparc 
> and i386).

According to the latest figures, 621 million ARM processors were
shipped in Q3, which equates to about 78 processors per second.
(taken from http://www.arm.com/news/15300.html).

I'd like to know the figures for these other so-called "popular
architectures".

But in any case that's an utterly irrelevant point to the argument
at hand.

> > In fact I think more things have LL/SC than have CMPXCHG.
> 
> LL/SC can be easily used to come up with a cmpxchg equivalent.

As proven previously the reverse is also true.  And as shown previously
the cheaper out of the two for all platforms is the LL/SC based
implementation, where the architecture specific implementation can
be _either_ LL/SC based or cmpxchg based depending on what is
supported in their hardware.

I'm going to keep saying this until people get it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
