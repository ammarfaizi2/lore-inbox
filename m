Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbUKTK22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUKTK22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUKTK22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:28:28 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:51081 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261549AbUKTK20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:28:26 -0500
To: Chris Wedgwood <cw@f00f.org>
cc: James Morris <jmorris@redhat.com>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       davem@redhat.com
Subject: Re: [6/7] Xen VMM patch set : add alloc_skb_from_cache 
In-Reply-To: Your message of "Fri, 19 Nov 2004 22:03:30 PST."
             <20041120060330.GA23850@taniwha.stupidest.org> 
Date: Sat, 20 Nov 2004 10:28:10 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1CVSTT-0004aw-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 19, 2004 at 09:11:04PM -0500, James Morris wrote:
> 
> > Most of this is duplicated code with alloc_skb(), perhaps make a
> > function:
> >
> >   __alloc_skb(size, gfp_mask, alloc_func)
> >
> > Then alloc_skb() and alloc_skb_from_cache() can just be wrappers
> > which pass in different alloc_funcs.  I'm not sure what peformance
> > impact this might have though.
> 
> I wonder if this would have a measurable performance hit on some
> platforms where the additional call/indirection could hurt?

Could make __alloc_skb 'static inline'?

 -- Keir
