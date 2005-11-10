Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVKJCX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVKJCX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbVKJCX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:23:56 -0500
Received: from gold.veritas.com ([143.127.12.110]:26168 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751441AbVKJCXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:23:55 -0500
Date: Thu, 10 Nov 2005 02:22:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051109181022.71c347d4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:23:55.0303 (UTC) FILETIME=[CC78EB70:01C5E59D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Andrew Morton wrote:
> 
> It does everything we want.

I don't think so: the union leaves us just as vulnerable to some
subsystem using fields of the other half of the union, doesn't it?

Which is not really a problem, but is a part of what's worrying you.

> Of course, it would be nice to retain 2.95.x support.  The reviled
> page_private(() would help us do that.  But the now-to-be-reviled
> page_mapping() does extraneous stuff, and we'd need a ton of page_lru()'s.
> 
> So it'd be a big patch, converting page->lru to page->u.s.lru in lots of
> places.
> 
> But I think either a big patch or 2.95.x abandonment is preferable to this
> approach.

Hmm, that's a pity.

Hugh
