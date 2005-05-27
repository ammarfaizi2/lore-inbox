Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVE0WFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVE0WFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVE0WFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:05:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:37015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262620AbVE0WEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:04:43 -0400
Date: Fri, 27 May 2005 15:06:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: ALSA official git repository
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505271502240.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org> <20050527135124.0d98c33e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Andrew Morton wrote:
>
> Yes, I'll occasionally do patches which were written by "A" as:
> 
> From: A
> ...
> Signed-off-by: B
> 
> And that comes through email as:
> 
> 
> ...
> From: <akpm@osdl.org>
> ...
> From: A
> ...
> Signed-off-by: B
> 
> 
> which means that the algorithm for identifying the author is "the final
> From:".

No, the algorithm is:
 - the email author, _or_ if there is one, the top "From:" in the body.

And the rule is that you never remove (or add to) an existing From:, since 
the author doesn't change from being passed around.

Put another way: authorship is very different from sign-off. The sign-off 
gets stacked, the authorship is constant, and thus the rules are 
different.

Also, authorship is more important than sign-off-ship, so authorship goes 
at the top, while sign-offs go at the bottom.

> I guess the bug here is the use of From: to identify the primary author,
> because transporting the patch via email adds ambiguity.

No it doesn't, the email "from" just ends up being the "default" if no 
explicit authorship is noted.

> Maybe we should introduce "^Author:"?

It would still have the same rules, so it wouldn't change anything but the 
tag, so I don't think there is any real advantage to it.

		Linus
