Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbULPVCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbULPVCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbULPVCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:02:01 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:57304 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262017AbULPVA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:00:58 -0500
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, alan@lxorguk.ukuu.org.uk, Ian.Pratt@cl.cam.ac.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "Thu, 16 Dec 2004 10:26:52 PST."
             <20041216102652.6a5104d2.akpm@osdl.org> 
Date: Thu, 16 Dec 2004 21:00:52 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I guess if we were to go the way which Ian is proposing it would be
> 
> a) Add arch/xen
> 
> b) Spend N weeks integrating xen into arch/i386, while also separately
>    maintaining arch/xen.
> 
> c) Remove arch/xen
> 
> So...  why not skip a), c) and half of b)?

That's not quite what I'm proposing. 

Once arch/xen is in the tree, we'd start submitting patches that
try and unify more of arch xen and i386 to reduce the number of
files that we have to modify. 

I think we'd then have to make a decision as to whether merging
i386 and xen/i386 is feasible. Further, we'd have to make a
decision as to whether what is really wanted is a single kernel
that's able to boot-time switch between native i386 and xen,
rather than just having a single source base. The two options
would probably result in rather different implementations.

In short, merging is far from trivial, and its not even clear
quite what is wanted. 

I'm not convinced that maintaining xen/i386 in its current form
is going to be as hard as Andi thinks. We already share many
files unmodified from i386. Keeping i386 and xen/i386 in sync is
fairly mechanical: we can apply most of the patches to i386 to
xen/i386 directly. 


Ian
