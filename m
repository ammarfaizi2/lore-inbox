Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFOH36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFOH36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 03:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFOH36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 03:29:58 -0400
Received: from holomorphy.com ([66.93.40.71]:41110 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261239AbVFOH3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 03:29:55 -0400
Date: Wed, 15 Jun 2005 00:29:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "liyu@LAN" <liyu@ccoss.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: one question about LRU mechanism
Message-ID: <20050615072952.GB3913@holomorphy.com>
References: <1118812376.32766.4.camel@liyu.ccoss.com.cn> <20050615052530.GA3913@holomorphy.com> <1118817991.5828.23.camel@liyu.ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118817991.5828.23.camel@liyu.ccoss.com.cn>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 02:46:30PM +0800, liyu@LAN wrote:
> In 2.6.11.11, mm do not have function isolate_lru_pages(), but I
> downloaded linux-2.6.11.12.tar.bz2 source tarball, and apply follow two
> patches in order:
> patch-2.6.12-rc6
> 2.6.12-rc6-mm1
> Oh, Have any error in this process? patch program say it can not change
> some files , and save some *.rej files. but these *rej do not include
> mm/vmscan.c.
> This new function called two times in shrink_cache() and
> refill_inactive_zone(). 
> The main part of isolate_lru_pages() is 
[...]
> I think, this change that new function isolate_lru_pages() is one kind
> of refactoring (method extract ??), not one essence change. 

Agreed. Mainly I mentioned it in case the symbol was recently enough
introduced to not be visible in the sources you'd reviewed.
:

On Wed, Jun 15, 2005 at 02:46:30PM +0800, liyu@LAN wrote:
> the call:
>                 list_del(&page->lru);
> as I known, just delete its argument from list, but not its previous
> element. so, It is most newest page that just be appended to
> active_list.
> I think, may be, codes like this will be better.
[...]
> This is just my flimsy perspective.

Not so flimsy. You seem to understand things well. Unfortunately I am
the kind of person who thinks less about how things should be to be the
best they could be than about how they work now and could work for some
specific effect. I don't have any opinion about it being better or worse.


-- wli
