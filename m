Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbUKRK2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbUKRK2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKRK0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:26:14 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:41944 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262719AbUKRKXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:23:53 -0500
To: Andi Kleen <ak@suse.de>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: Re: Xen 2.0 VMM patches 
In-reply-to: Your message of "18 Nov 2004 05:50:54 +0100."
             <p73k6sj221d.fsf@brahms.suse.de> 
Date: Thu, 18 Nov 2004 10:23:50 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUjSB-0005II-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ian Pratt <Ian.Pratt@cl.cam.ac.uk> writes:
> 
> >   arch-xen    : large patch to add arch/xen and include/asm-xen 
> 
> This is 32bit only right? Do you plan a 64bit guest too? 
> If yes, you would end up with two arch-xens in the end.

We have an x86_64 guest port in progress, hence the current
directory structure below arch/xen. There's a fair bit of
arch/xen-specific code that we can share between the ports.

> Also are the differences to the native architecture really that big that a 
> separate architecture makes sense? It's a lot of long term work to maintain
> a Linux architecture.

We've experimented with doing thing the other way round, having
xen a sub architecture of i386, but it was _really_ messy.

I firmly believe that having a separate arch/xen is the best
approach for the moment. In the future, it might make sense to
merge arch xen into i386, but to do this cleanly would require
significant restructuring of i386. I think that's something we
could move toward after everyone's gotten comfortable with having
arch xen in the tree. 

The fact that arch xen is self contained actually makes it easier
for us to maintain in some respects. We've been tracking 2.6
releases for some time without too much difficulty.


Best,
Ian

