Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbUKRKXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUKRKXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUKRKWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:22:41 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:15064 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262718AbUKRKSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:18:34 -0500
To: Andrew Morton <akpm@osdl.org>
cc: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>, Keir.Fraser@cl.cam.ac.uk,
       haveblue@us.ibm.com, Ian.Pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value 
In-Reply-To: Your message of "Thu, 18 Nov 2004 02:14:19 PST."
             <20041118021419.0c0d1dad.akpm@osdl.org> 
Date: Thu, 18 Nov 2004 10:18:28 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1CUjMz-0005DI-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk> wrote:
> >
> > We forwarded the patches around
> >  so many different people for comment before sending them to lkml that
> >  somewhere along the line something bad happned.
> 
> Just send 'em to linux-kernel first-up and cc everyone else.  That way you
> avoid duplication of effort and everyone is on the same page.
> 
> I'm still struggling to understand the rationale behind the mem.c change
> btw.  io_remap_page_range() _is_ remap_page_range() (or, now,
> remap_pfn_range()) on x86.  So whatever the patch is supposed to be doing,
> it's a no-op.

We need to sync up to the current BK tree and see what needs to be
done. If remap_pfn_range() is arch-dep and only used in contexts where
you want to remap real physical address ranges (not "kernel physical"
address ranges) then we can reimplement remap_pfn_range() and remove
that CONFIG_XEN part of mem.c.

 -- Keir
