Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVBXABl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVBXABl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVBWX64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:58:56 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:38543 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261709AbVBWXwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:52:31 -0500
Message-ID: <421D1737.1050501@yahoo.com.au>
Date: Thu, 24 Feb 2005 10:52:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>     <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>     <20050217230342.GA3115@wotan.suse.de>     <20050217153031.011f873f.davem@davemloft.net>     <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>     <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>     <421B0163.3050802@yahoo.com.au> <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> I'm off to bed, but since your appetite for looking at patches
> is greater than mine, I'll throw what I'm currently testing over
> the wall to you now.  Against 2.6.11-rc4-bk9, but my starting point
> was obviously your patches.  Not yet split up, but clearly should be.

Yeah you've snuck a few other clever things in there ;)

> Includes mm/swapfile.c which you missed.  I'm inlining pmd and pud

Thanks.

> levels, but not pte and pgd levels.  No description yet, sorry.

OK - that's probably sufficient for debugging. There is only so
much that can go wrong in the middle levels... how does it look
performance wise? (I can give it a test when it gets split out)

> One point worth making, I do believe throughout that whatever the
> address layout, "end" cannot be 0 - BUG_ON(addr >= end) assures.
> 

OK after sleeping on it, I'm warming to your way.

I don't think it makes something like David's modifications any
easier, but mine didn't go a long way to that end either. And
being a more incremental approach gives us more room to move in
future (for example, maybe toward something that really *will*
accommodate the bitmap walking code nicely).

So I'd be pretty happy for you to queue this up with Andrew for
2.6.12. Anyone else?

Nick

