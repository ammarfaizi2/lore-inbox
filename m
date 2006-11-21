Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031337AbWKUTtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031337AbWKUTtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031356AbWKUTtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:49:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031337AbWKUTtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:49:35 -0500
Date: Tue, 21 Nov 2006 11:49:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC 1/7] Remove declaration of sighand_cachep from slab.h
Message-Id: <20061121114901.54a36e4b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611211133300.30133@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
	<20061118054347.8884.36259.sendpatchset@schroedinger.engr.sgi.com>
	<20061118172739.30538d16.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0611200817020.16173@schroedinger.engr.sgi.com>
	<20061121000743.bb9ea2d0.akpm@osdl.org>
	<Pine.LNX.4.64.0611211133300.30133@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 11:36:19 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 21 Nov 2006, Andrew Morton wrote:
> 
> > Use `struct kmem_cache' instead of `kmem_cache_t' and lo, you can
> > forward-declare it in the header file without having to include slab.h.
> > 
> > Patches which rid us of kmem_cache_t are always welcome..
> 
> Ok. So this patch would be acceptable?
> 
> 
> Remore kmem_cache_t from mm.
> 
> This patch removed all uses of kmem_cache_t from the code in mm/*.
> The typedef is replaced with a define to allow other code to compile.
> 

spose so, although I wouldn't bother about the typedef->#define change.  
We just keep on plugging away at it until one day we can just remove the typedef.

