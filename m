Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbULRR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbULRR5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbULRR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:57:44 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:51643 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261209AbULRR5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:57:42 -0500
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andi Kleen <ak@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "Fri, 17 Dec 2004 08:05:52 PST."
             <20041217160552.GZ771@holomorphy.com> 
Date: Sat, 18 Dec 2004 17:57:22 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CfipX-0005cs-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Dec 14, 2004 at 07:59:50PM +0100, Andi Kleen wrote:
> > I suspect xen64 will be rather different from xen32 anyways
> > because as far as I can see the tricks Xen32 uses to be
> > fast (segment limits) just plain don't work on 64bit
> > because the segments don't extend into 64bit space.
> > So having both in one architecture may also end up messy.
> > And i386 and x86-64 are in many pieces very different anyways,
> > I have my doubts that trying to mesh them together in arch/xen
> > will be very pretty.
> 
> I have an inkling that the xen implementors may have plots of
> additional architecture ports. If it really is x86/x86-64 -only it
> isn't worth bothering with a separate arch/ dir, but it would be if it
> were ported to a large number of architectures.

For non x86 architectures, the changes required are typically
much less, and it makes sense to integrate them into the normal
architecture tree. This is what has been done with ia64, and will
be done with ppc. i386 and x86_64 are a special case where the
extensive changes required justify having an arch xen directory
with i386 and x86_64 subtrees beneath it (although many files are
just linked from the normal architecture).

> Maybe they're modelling it after UML which has its own arch/ dir but
> then grabs assorted things from other architectures; in that event I
> wouldn't consider it so misguided.

Yep, that's the model, for the x86 family.

Ian
