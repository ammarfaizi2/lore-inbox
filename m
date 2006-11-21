Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030726AbWKUII0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbWKUII0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030727AbWKUIIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:08:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:5042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030726AbWKUIIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:08:25 -0500
Date: Tue, 21 Nov 2006 00:07:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC 1/7] Remove declaration of sighand_cachep from slab.h
Message-Id: <20061121000743.bb9ea2d0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611200817020.16173@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
	<20061118054347.8884.36259.sendpatchset@schroedinger.engr.sgi.com>
	<20061118172739.30538d16.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0611200817020.16173@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 08:20:13 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Sat, 18 Nov 2006, Stephen Rothwell wrote:
> 
> > Is there no suitable header file to put this in?
> 
> There is only a single file that uses sighand_cachep apart from where it 
> was defined. If we would add it to signal.h then we would also have to
> add an include for slab.h just for this statement.

That's one of the reasons why typedefs are bad.

Use `struct kmem_cache' instead of `kmem_cache_t' and lo, you can
forward-declare it in the header file without having to include slab.h.

Patches which rid us of kmem_cache_t are always welcome..
