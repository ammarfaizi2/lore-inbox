Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWAYLAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWAYLAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWAYLAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:00:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37355 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751116AbWAYLAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:00:32 -0500
Date: Wed, 25 Jan 2006 12:00:31 +0100
From: Nick Piggin <npiggin@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC] non-refcounted pages, application to slab?
Message-ID: <20060125110031.GC30421@wotan.suse.de>
References: <20060125093909.GE32653@wotan.suse.de> <84144f020601250230s2d5da5d9jf11f754f184d495b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020601250230s2d5da5d9jf11f754f184d495b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:30:03PM +0200, Pekka Enberg wrote:
> Hi Nick,
> 
> On 1/25/06, Nick Piggin <npiggin@suse.de> wrote:
> > This is probably not worthwhile for most cases, but slab did strike me
> > as a potential candidate (however the complication here is that some
> > code I think uses the refcount of underlying pages of slab allocations
> > eg nommu code). So it is not a complete patch, but I wonder if anyone
> > thinks the savings might be worth the complexity?
> >
> > Is there any particular code that is really heavy on slab allocations?
> > That isn't mostly handled by the slab's internal freelists?
> 
> I certainly hope not. For heavy users, the slab allocator should grow
> caches enough to satisfy most allocations from the them. Also, I think

I figured this would usually be the case.

> we want to keep the reference counting for slab pages so that we can
> use kmalloc'd memory in the block layer.
> 

Does that happen now? Where is it needed (nbd or something I guess?)

Nick

