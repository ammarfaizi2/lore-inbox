Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUK0Mjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUK0Mjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 07:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUK0Mjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 07:39:33 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:43680 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261195AbUK0Mjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 07:39:32 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN 
In-reply-to: Your message of "Sat, 20 Nov 2004 18:03:27 GMT."
             <E1CVZa4-0001jT-00@mta1.cl.cam.ac.uk> 
Date: Sat, 27 Nov 2004 12:39:18 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CY1rC-0007Y2-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > @@ -42,7 +42,12 @@ extern void tapechar_init(void);
> > >   */
> > >  static inline int uncached_access(struct file *file, unsigned long addr)
> > 
> > Any chance you could just move uncached_access() to some asm/ header for
> > all arches instead of making the ifdef mess even worse?
> 
> I suppose a generic definition could go in asm-generic/iomap.h
> with per-architecture definitions in asm/io.h.  However, I think
> it would make sense to wait until PAT support gets added and then
> think through exactly what needs doing rather than reorganising
> things now.

What do people think about this? Should I stick with the current
patch that adds another #ifdef to uncached_access, or should I
try pulling it out into asm-generic/iomap.h with per-arch
definitions in asm/io.h ?

Is there anyone working on PAT support? It would be good to have
their input.

Thanks,
Ian
