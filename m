Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVJEWZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVJEWZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbVJEWZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:25:43 -0400
Received: from [203.171.93.254] ([203.171.93.254]:19843 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030397AbVJEWZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:25:42 -0400
Subject: Re: [swsusp] separate snapshot functionality to separate file
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <434443D9.3010501@colitti.com>
References: <20051002231332.GA2769@elf.ucw.cz>
	 <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz>
	 <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz>
	 <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz>
	 <434443D9.3010501@colitti.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128550878.10363.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 06 Oct 2005 08:21:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo et al.

On Thu, 2005-10-06 at 07:21, Lorenzo Colitti wrote:
> Pavel Machek wrote:
> >> Pavel, at the PM summit, we agreed to work toward getting Suspend2
> >> merged. I've been working since then on cleaning up the code, splitting
> >> the patches up nicely and so on. In the meantime, you seem to have gone
> >> off on a completely different tangent, going right against what we
> >> agreed then.
> > Sorry about that. At pm summit, I did not know if uswsusp was
> > feasible. Now I'm pretty sure it is (code works and is stable).
> 
> Ok, excuse me for butting in.
> 
> I would just like to give the point of view of a user.
> 
> I have been using suspend2 probably at least once a day for about a year 
> now, and I love it. I have had zero cases of data corruption, and it's 
> fast, effective, and reliable. I can't say the same about the in-kernel 
> swsusp. When I tried it (once), a few months ago:
> 
> - It was dog slow because it doesn't use compression
> - Even though it's dog slow, it doesn't save all RAM
>    - Therefore the machine is dog slow after resume
> - It doesn't have a decent UI
> - There is no way to abort suspend once it's started. (Whatever others
>    may say, this /is/ useful, especially when you've forgotten something
>    and you're in a hurry and don't have two more minutes to waste waiting
>    for a suspend/resume cycle.)
> 
> These points /do/ matter to users: after all, if we all had time to 
> waste we'd never use suspend or S3, we'd just reboot all the time...
> 
> I have been waiting for swsusp2 to be merged ever since I started  using 
> it. When I read about the discussion at the PM summit, I hoped that this 
> would finally happen. Now I see that it's not, and instead work is going 
> to continue on what is - or at least seemed to be when I tried it - an 
> inferior implementation. From my point of view as a user, this seems 
> silly. There may be all the technical reasons in the world to dislike 
> suspend2; on these, I defer to everyone else, since I'm no kernel 
> hacker. But from the point of view of a user, well, suspend2 is much better.
> 
> So, instead of working on getting swsusp, which is still far behind in 
> terms of functionality, up to the level of suspend2, why not work 
> together on merging swsusp2, which is fast, stable and provides what 
> users want and need?

Thanks for the support.

Just to clarify a little, the main reason (from my point of view) that
Suspend2 hasn't been merged prior to now is that I haven't asked for
that. I have sought code reviews a couple of times, and have really
appreciated the feedback. But so far I haven't sought for the code to be
merged. This has been for a number of reasons:

First, I've been seeking to make it as mature and bug free as I can
prior to the merge so that the merge itself creates as few problems as
possible. Part of this has involved spending a long time cleaning up
code, improving the commenting and so on.

Second, getting it in a form that Andrew and Linus can use involves
preparing a git tree for them to pull from, and this requires splitting
the patches up into discrete functions and pairs of functions. Doing
this and writing descriptions for each patch has also taken a long time,
especially because Suspend is by no means the only thing I do with my
life (although my wife sometimes feels otherwise!).

So, then, at least part of the blame for Suspend2 not being merged yet
must lie with me, sorry. I am seeking to address this, and trying not to
be too much of a perfectionist, but it will take a little bit longer
yet.

Of course even when I think I'm ready, it doesn't mean others will
agree, so don't expect it to happen the instant I become satisfied :).

Regards,

Nigel

> 
> Cheers,
> Lorenzo


