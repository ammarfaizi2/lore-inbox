Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbULDXuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbULDXuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULDXuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:50:09 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:148 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261198AbULDXuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:50:00 -0500
To: Andrea Arcangeli <andrea@suse.de>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN 
In-reply-to: Your message of "Tue, 30 Nov 2004 19:03:37 +0100."
             <20041130180337.GT4365@dualathlon.random> 
Date: Sat, 04 Dec 2004 23:49:32 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1Cajei-00040t-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 30, 2004 at 01:16:56PM +0000, Ian Pratt wrote:
> > point it would solve our problem. I'm not sure what this would
> > mean for architectures other than i386.
> 
> Only sparc implements io_remap_page_range differently from
> remap_pte_range and from Wli answer I understand it's probably ok for
> sparc to use io_remap_page_range outside ram.

So, do we think the best /dev/mem patch is to change the call to
io_remap_page_range, and have a #ifdef for the SPARC case until
the number of arguments gets unified?

Thanks,
Ian

