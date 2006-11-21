Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966428AbWKUUIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966428AbWKUUIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934195AbWKUUIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:08:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934171AbWKUUIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:08:06 -0500
Date: Tue, 21 Nov 2006 12:07:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC 1/7] Remove declaration of sighand_cachep from slab.h
Message-Id: <20061121120723.5b880f72.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611211151300.30359@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
	<20061118054347.8884.36259.sendpatchset@schroedinger.engr.sgi.com>
	<20061118172739.30538d16.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0611200817020.16173@schroedinger.engr.sgi.com>
	<20061121000743.bb9ea2d0.akpm@osdl.org>
	<Pine.LNX.4.64.0611211133300.30133@schroedinger.engr.sgi.com>
	<20061121114901.54a36e4b.akpm@osdl.org>
	<Pine.LNX.4.64.0611211151300.30359@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 11:56:33 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 21 Nov 2006, Andrew Morton wrote:
> 
> > spose so, although I wouldn't bother about the typedef->#define change.  
> > We just keep on plugging away at it until one day we can just remove the typedef.
> 
> You do have script that can replace a string throughout the kernel 
> right?

Nope.

> 
> A patch is following that does the core things in mm and 
> include/linux/slab.h. Would you accept that patch and then do
> 
> s/kmem_cache_t/struct kmem_cache/g
> 
> over all the kernel sources?

This is one of those low-priority background activities.  Not worth
a lot of fuss.

I'd suggest that you proceeed with the original cleanups you were
proposing, except use `struct kmem_cache' in header files rather than
kmem_cache_t in .c files.

Then, as a separate and later exercise someone (maybe you) can raise
patches to do the kmem_cache_t->kmem_cache conversion.  They should go
through maintainers hence they should be appropriately split and they will
take months to all get to mainline.  Once this is all completed we can remove the
typedef.
