Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTLEXCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTLEXCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:02:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:7891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264592AbTLEXCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:02:34 -0500
Date: Fri, 5 Dec 2003 15:02:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: nathans@sgi.com, neilb@cse.unsw.edu.au, manfred@colorfullife.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1070665046.1802.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.58.0312051458540.9125@home.osdl.org>
References: <mnet1.1070665046.1802.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003 pinotj@club-internet.fr wrote:
>
> 1. Is it still usefull to get all the backtraces of the last xfs oops ?

No, I'm assuming that was due to the slab interaction.

> 2. I will test patch-slab and patch-xfs on test11,
> CONFIG_DEBUG_PAGEALLOC (only). Test on XFS root and ext3 with "small"
> and "big" kernels.

Sounds good.

> 3. What about patch-bio of Manfred ? I didn't have much time to try it
> yet but seems to stabilize too. Should I use it alone or with the others
> patchs ?

It would be interesting to hear as much as possible about this: if
Manfred's bio patch makes a difference, it's less intrusive than mine, and
as such interesting.

On the other hand, despite the small size of Manfred's patch, it does have
a big impact: since 128 bytes is a "watermark" for the slab debugging, the
patch which appears less intrusive does in fact still cause a big amount
of changes.

Anyway, the more you feel like testing, the better. But use your own
judgements.

Thanks a lot for the effort, btw,

		Linus
