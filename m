Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbUK3XbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUK3XbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUK3Xa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:30:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:37527 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262464AbUK3X2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:28:22 -0500
Subject: Re: [1/7] Xen VMM #3: add ptep_establish_new to make va available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <E1CZH45-0000Gk-00@mta1.cl.cam.ac.uk>
References: <E1CZH45-0000Gk-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 10:27:45 +1100
Message-Id: <1101857266.5174.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 23:05 +0000, Ian Pratt wrote:

> I'd appreciate a pointer to the patch. 

Well, I was hoping that David would reply with one :) It wasn't ported
to all archs tho, but I did ppc & ppc64, and he did x86 & sparc iirc

> It may still be of some use to distinguish between call sites
> where it is likely that mm == current->mm to avoid adding a
> futile test in all the others.

Maybe ...

 
> > Is there also a need for ptep_establish and ptep_establish_new to be 2
> > different functions ?
> 
> They allow different TLB invalidation behaviour. I guess it could
> be one function with an extra arg.

Not sure, my point is that we tend nowadays to have one abstraction per
call site, and I wonder if it's the right way to go ...

Ben.


