Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVKVHyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVKVHyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKVHyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:54:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932411AbVKVHyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:54:13 -0500
Date: Mon, 21 Nov 2005 23:54:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [patch 9/12] mm: page_state opt
Message-Id: <20051121235405.2b6ce561.akpm@osdl.org>
In-Reply-To: <20051121124235.14370.92215.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
	<20051121124235.14370.92215.sendpatchset@didi.local0.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> -#define mod_page_state_zone(zone, member, delta)				\
>  -	do {									\
>  -		unsigned offset;						\
>  -		if (is_highmem(zone))						\
>  -			offset = offsetof(struct page_state, member##_high);	\
>  -		else if (is_normal(zone))					\
>  -			offset = offsetof(struct page_state, member##_normal);	\
>  -		else								\
>  -			offset = offsetof(struct page_state, member##_dma);	\
>  -		__mod_page_state(offset, (delta));				\
>  -	} while (0)

I suppose this needs updating to know about the dma32 zone.
