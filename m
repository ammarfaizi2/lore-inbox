Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbUKTSDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUKTSDm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUKTSDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:03:42 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:61868 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S263137AbUKTSDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:03:41 -0500
To: Christoph Hellwig <hch@infradead.org>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN 
In-reply-to: Your message of "Sat, 20 Nov 2004 16:31:10 GMT."
             <20041120163110.GB19099@infradead.org> 
Date: Sat, 20 Nov 2004 18:03:27 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CVZa4-0001jT-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -42,7 +42,12 @@ extern void tapechar_init(void);
> >   */
> >  static inline int uncached_access(struct file *file, unsigned long addr)
> 
> Any chance you could just move uncached_access() to some asm/ header for
> all arches instead of making the ifdef mess even worse?

I suppose a generic definition could go in asm-generic/iomap.h
with per-architecture definitions in asm/io.h.  However, I think
it would make sense to wait until PAT support gets added and then
think through exactly what needs doing rather than reorganising
things now.

Ian
