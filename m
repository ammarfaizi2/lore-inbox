Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTKZNW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTKZNW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:22:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:5510 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262758AbTKZNWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:22:18 -0500
Date: Wed, 26 Nov 2003 05:29:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-Id: <20031126052900.17542bb3.akpm@osdl.org>
In-Reply-To: <20031126130936.A5275@infradead.org>
References: <20031125211518.6f656d73.akpm@osdl.org>
	<20031126085123.A1952@infradead.org>
	<20031126044251.3b8309c1.akpm@osdl.org>
	<20031126130936.A5275@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Nov 26, 2003 at 04:42:51AM -0800, Andrew Morton wrote:
> > The individual patches in the broken-out/ directory are usually
> > changelogged.  This one says:
> > 
> >   It was EXPORT_SYMBOL_GPL(), however IBM's GPFS is not GPL.
> > 
> >   - the GPFS team contributed to the testing and development of
> >     invaldiate_mmap_range().
> > 
> >   - GPFS was developed under AIX and was ported to Linux, and hence meets
> >     Linus's "some binary modules are OK" exemption.
> > 
> >   - The export makes sense: clustering filesystems need it for shootdowns to
> >     ensure cache coherency.
> 
> Have you actually looked at the gpfs glue code?

Nope.

> something that digs that deep
> into the VM and VFS actually _must_ be derived work.

Could be.  I'm surprised that they need a glue layer at all actually.

> Or do wed allow people
> now to pay a developer tax to buy themselves free from GPL restrictions.

Well I think that restructuring the pagecache invalidaton in such a way
that it is useful for non-derived clustered filesytems does give one some
rights to actually use that code.  It seems a bit rude to take the code but
to make it unusable.

> I as one of the collective copytight holders of the kernel strongly disagree
> with that, it can't be true that IBM can just ignore copyright law..

Well if people have problems with it then I don't feel strongly enough
about it to dispute that, frankly.

But I do not think that making a single kernel symbol inaccessible is an
appropriate way of resolving a GPFS licensing dispute.
