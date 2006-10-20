Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992518AbWJTGev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992518AbWJTGev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992520AbWJTGev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:34:51 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:32401 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S2992518AbWJTGeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:34:50 -0400
Message-ID: <45386E0E.7030404@drzeus.cx>
Date: Fri, 20 Oct 2006 08:34:54 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> That all sounds fine. Please just check the format for the "[GIT PULL]" 
> message: Andrew pulls peoples trees on his own and largely automatically, 
> so he doesn't much care _what_ is in the tree, but I care deeply. So I 
> want the diffstat and shortlog listings, and preferably a few sentences at 
> the top of the email describing what's going on and why things are 
> happening.
>   

I'm still learning the more fancy parts of git, but I think that would be:

git diff master..for-linus | diffstat
git log master..for-list | git shortlog

right?

> I think people have seen the messages that other people send out (eg at 
> least Greg KH tends to Cc: those messages to linux-kernel, so others can 
> see what's going on too - although not all other maintainers do that).
>
> Basically, I want to know that the thing I pull makes sense for the stage 
> I'm pulling in (ie if it's after -rc1, think about trying to explain why 
> the fixes are all important bug-fixes for example), and what it affects. 
> The diffstat is part of that, but please include any other explanations 
> that seem meaningful.
>
>   

That was the basic idea. I've been looking at these kinds of messages on
LKML, trying to deduce how people do their work.

> So there's simply no point in merging from me, unless you know that there 
> are clashes due to other development, and you actually want to fix them 
> up. You will just cause unnecessary criss-cross merges if you pull from my 
> tree after you've started development, and the history gets really really 
> messy.
>   

And in order to test for conflicts, I assume I should have a "test tree"
that I merge all my local stuff in, together with your current HEAD?

> There's several ways to handle this:
>
>  - just base your work on a certain release, and ignore all the other 
>    changes. Then, when you're ready, just ask me to pull your changes. git 
>    will just merge it up to my current version, and everything will be 
>    fine. 
>
>    (Of course, once I _have_ merged your changes, if you pull at that 
>    point, you'll just fast-forward, and there will be no unnecessary 
>    back-and-forth merging)
>
>  - If you actually want your development tree to "track" my tree, I'd 
>    suggest you have your "for-linus" branch that you put the work you want 
>    to track into, and then a plain "linus" branch which tracks _my_ tree. 
>    Then you can just fetch my tree (to keep your "linus" branch 
>    up-to-date), and if you want your development branch to track those 
>    changes, you can just do a "git rebase linus" in your "for-linus" 
>    branch.
>   

If I've understood git correctly, a rebase is a big no-no once I've
published those changes as it reverts some history. Right?

>  - If you actually notice that the stuff in my tree conflicts with the 
>    stuff you develop, _then_ you obviously want to merge (you can try to 
>    "rebase" things too and fix it up durign the rebase, but merging is 
>    often easier, and at this point the merge is no longer "unnecessary 
>    noise", it's actually a real action of you doing a real merge to handle 
>    the conflict.
>
> And hey, if there is occasionally an unnecessary merge, nobody really 
> cares. So don't be _too_ worried about it. But a clean history makes 
> things simpler to track, so I'm asking people to not generate noise that 
> simply doesn't help.
>   

A load of my mind. ;)

Big thanks for all the pointers. I have my account at kernel.org, so it
won't be long until my first [GIT PULL]. Be gentle.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

