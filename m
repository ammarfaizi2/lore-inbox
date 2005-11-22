Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVKVIIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVKVIIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVKVIIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:08:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964890AbVKVIIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:08:42 -0500
Date: Tue, 22 Nov 2005 00:08:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 9/12] mm: page_state opt
Message-Id: <20051122000833.4463e108.akpm@osdl.org>
In-Reply-To: <4382DF04.3000001@yahoo.com.au>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
	<20051121124235.14370.92215.sendpatchset@didi.local0.net>
	<20051121235405.2b6ce561.akpm@osdl.org>
	<4382DF04.3000001@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> >>-#define mod_page_state_zone(zone, member, delta)				\
> >> -	do {									\
> >> -		unsigned offset;						\
> >> -		if (is_highmem(zone))						\
> >> -			offset = offsetof(struct page_state, member##_high);	\
> >> -		else if (is_normal(zone))					\
> >> -			offset = offsetof(struct page_state, member##_normal);	\
> >> -		else								\
> >> -			offset = offsetof(struct page_state, member##_dma);	\
> >> -		__mod_page_state(offset, (delta));				\
> >> -	} while (0)
> > 
> > 
> > I suppose this needs updating to know about the dma32 zone.
> > 
> 
> Ah I didn't realise DMA32 is in the tree now. I think you're right.

It means adding a new field to /proc/vmstat of course.  Presumably someone
uses that file occasionally.

> I'll rebase this patchset when such an update is made. If you'd like
> I could look at doing said DMA32 update for you?

Sometime..
