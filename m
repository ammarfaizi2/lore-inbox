Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWAIQ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWAIQ5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWAIQ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:57:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964878AbWAIQ5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:57:14 -0500
Date: Mon, 9 Jan 2006 08:57:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
cc: "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       Martin Langhoff <martin.langhoff@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: RE: git pull on Linux/ACPI release tree
In-Reply-To: <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601090850350.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Linus Torvalds wrote:
>
> One thing we could do is to make it easier to apply a patch to a 
> _non_current_ branch.
>   [ ... ]
> Do you think that kind of workflow would be more palatable to you? It 
> shouldn't be /that/ hard to make git-apply branch-aware... (It was part of 
> my original plan, but it is more work than just using the working 
> directory, so I never finished the thought).

Btw, this is true in a bigger sense: the things "git" does have largely 
been driven by user needs. Initially mainly mine, but things like 
"git-rebase" were from people who wanted to work as "sub-maintainers" (eg 
Junio before he became the head honcho for git itself).

But if there are workflow problems, let's try to fix them. The "apply 
patches directly to another branch" suggestion may not be sane (maybe it's 
too confusing to apply a patch and not actually see it in the working 
tree), but workflow suggestions in general are appreciated.

We've made switching branches about as efficient as it can be (but if the 
differences are huge, the cost of re-writing the working directory is 
never going to be low). But switching branches has the "confusion factor" 
(ie you forget which branch you're on, and apply a patch to your working 
branch instead of your development branch), so maybe there are other ways 
of doing the same thing that might be sensible..

So send suggestions to the git lists. Maybe they're insane and can't be 
done, but while I designed git to work with _my_ case (ie mostly merging 
tons of different trees and then having occasional big batches of 
patches), it's certainly _supposed_ to support other maintainers too..

		Linus
