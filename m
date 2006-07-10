Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWGJHIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWGJHIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWGJHIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:08:09 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:53675 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161361AbWGJHIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:08:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=te/NnarAtFUFmnNQBJrrCW7vrpWcfspch9iZes3B2Xi9zlghBBajErXNpq8T2GE1xbV5EU/haUjSwg05LKsJHeJdOEePFAv6q7M83AdwTPHFNJVeHtrxffTYO3VPON09vMYxdEJBxp34ji700LT7FEP5XAhG9l5LzPik4rGSU5U=  ;
Message-ID: <44B1F9E3.5030701@yahoo.com.au>
Date: Mon, 10 Jul 2006 16:55:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux list <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1
References: <200607101308.26291.kernel@kolivas.org>
In-Reply-To: <200607101308.26291.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> I see the merge window closed and swap prefetch got bypassed again. I'd like 
> to believe it was an oversight but far more likely that Andrew remains 
> undecided about whether it should go in or not.
> 
> No bug reports have come from it in 6 months, the code has remained unchanged 
> for 3 months, it is as unobtrusive as a driver that is not compiled in 
> when !CONFIGed and there are numerous reports from satisfied users (even ones 
> that made it to the scary grounds of lkml). The only thing that happens is 
> Nick keeps threatening to review it over and over and over and....

I was going to review it again, but I noticed it has still has comments
(from Hugh and I, I believe) which still haven't been implemented. Like
duplicating most of read_swap_cache_async. I thought you might have some
improvements on the way, so I hadn't bothered yet.

But... excuse me? I *threaten* to review it? I volunteered to review it a
couple of times and found several problems. But OK if you take that as a
threat, then I won't review it.

And I haven't seen any numbers to show it even works in ideal conditions
after I told you how to fix the watermark code, let alone the real world
situations in which it is supposed to help (not that that seems to be a
showstopper to merging stuff like this, though)

I personally won't advocate it, but I wouldn't be upset if it goes
in... it isn't entirely unobtrusive: it is pretty close to the core mm,
and will have to be maintained as such. Mainly in Hugh's area, so he
would have a final veto there.

> 
> I'm not sure what else needs to happen?
> 

Probably if nothing happens, it sounds like Andrew will merge it
eventually.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
