Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVKJT5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVKJT5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVKJT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:57:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbVKJT5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:57:02 -0500
Date: Thu, 10 Nov 2005 11:56:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051110114950.03a5946b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511101155160.4627@g5.osdl.org>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
 <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
 <20051110045144.40751a42.akpm@osdl.org> <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
 <20051110114950.03a5946b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Nov 2005, Andrew Morton wrote:
> 
> IOW we're assuming that no 32-bit architectures will obtain pagetables from
> slab?

I thought ARM does?

The ARM page tables are something strange (I think they have 1024-byte 
page tables and 4kB pages or something like that?). So they'll not only 
obtain the page tables from slab, they have four of them per page.

		Linus
