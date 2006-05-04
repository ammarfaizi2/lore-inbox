Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWEDBfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEDBfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 21:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWEDBfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 21:35:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750835AbWEDBfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 21:35:10 -0400
Date: Wed, 3 May 2006 18:31:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linda Walsh <lkml@tlinx.org>
cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
In-Reply-To: <44594AA9.8020906@tlinx.org>
Message-ID: <Pine.LNX.4.64.0605031829300.4086@g5.osdl.org>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
 <44594AA9.8020906@tlinx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 May 2006, Linda Walsh wrote:
> 
> >  - it gives you only a very limited view into what is actually going on.
> 
>    ???  In what way?  I don't think we need a *complex* view of what
> is going on.

The block-based view is a very simple one, but it's _too_ simple. It 
doesn't actually tell the user what is happening. It doesn't tell you why 
the request happened in the first place, so it leaves you no way to really 
do anything sane about it.

You can't prefetch (because the indexing is wrong), and you can't actually 
even analyze it (because you don't know any background to what you're 
seeing). In short, you can't _do_ anything with it.

			Linus
