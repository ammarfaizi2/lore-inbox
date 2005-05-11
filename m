Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVEKAYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVEKAYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEKAYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:24:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:17036 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261857AbVEKAYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:24:13 -0400
Date: Wed, 11 May 2005 02:28:05 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S.Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
In-Reply-To: <20050510.170946.10291902.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost>
References: <20050510161657.3afb21ff.akpm@osdl.org>
 <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org>
 <20050510.170946.10291902.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, David S.Miller wrote:

> From: Andrew Morton <akpm@osdl.org>
> Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
> Date: Tue, 10 May 2005 17:02:46 -0700
> 
> > Well I suppose I could live with a few REALLY REALLY BIG patches to do this
> > to lots of files, but if it's the old death-by-1000-cuts, I'm gonna call
> > uncle this time.
> 
> Fair enough.  One should be able to regex the majority of them
> with a check for "if *(" then ";" on the same line.
> 
Indeed.

If Andrew agrees, then I'll commit to doing this cleanup;

- no two statements on same line
- no funky spaces between function names, arguments etc.
- no spaces instead of proper tabs.
- (to a limited degree) no trailing whitespace
- perhaps other whitespace cleanups as per Codingstyle

For the entire tree.

No actual code changes - should be resonably easy to review.

Some can be semi-automated, some can't, and it'll take time and be a 
royal pain. But if Andrew will take the patches I'll do it (in some 2 
digit nr of patches (aiming for <50 - obviously guessing wildly here)).

I'll need time to do this - no matter how you cut it there are a lot of 
files, and a lot of lines - so don't expect the patch bombing to start for 
the next few weeks.
And before I embark on this venture I'd like some feedback that when I do 
turn up with patches they'll have a resonable chance of getting merged - 
this is going to be a lot of boring work, and with no commitment to merge 
anything it's not something I want to waste days on...  Sounds fair?

Ohh, and I'd be submitting all the patches to you Andrew, not individual 
maintainers/authors..


-- 
Jesper


