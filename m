Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVD1HZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVD1HZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVD1HZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:25:52 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:61607 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261329AbVD1HYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:24:25 -0400
To: davidsen@tmr.com
CC: linuxram@us.ibm.com, lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <426FFC30.1060700@tmr.com> (message from Bill Davidsen on Wed, 27
	Apr 2005 16:55:12 -0400)
Subject: Re: [PATCH] private mounts
References: <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu><20050426094727.GA30379@infradead.org> <1114630811.4180.20.camel@localhost> <426FFC30.1060700@tmr.com>
Message-Id: <E1DR3NT-0005L0-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 09:24:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you point out a solution could be worse that what it cures. 
> There are clearly problems with mount over, but imagine that a user does 
> an invisible mount over /mnt, doesn't that prevent other mounts which 
> are usually made, like /mnt/cdrom, /mnt/loopN, etc?

As previously explained, user mounts are only allowed on directories
for which the user has full write access.  Exactly for this reason.

> Every time someone suggests a solution it seems to open a new path to 
> possible abuse. And features which only work with a monotonic kernel 
> rather than modules would seem to indicate that the feature is nice but 
> the implementation might benefit from more thinking time.

Huh?  Where did modularitly come into this?

> Frankly the whole statement that the controversial code MUST go in now 
> and could be removed later sounds like a salesman telling me I MUST sign 
> the contract today, but he will let me out of it if I decide it was a 
> mistake.

The point of this thread is to find a solution to a problem.  The
discussion is turning up very interesting viewpoints and I'm
understanding the problem better and better, and I think other people
are too.

While I disagree with the view taken by Christoph H., I'm now also
thankful to him for stiring up the mud, because it ended up with a lot
of useful ideas.

In the end I'd like a solution that everybody is happy with.  That
means I'm not going to give up searching because someone said, that
the current solution is crappy.

Do you understand my position?

> I'm not against the feature, but a lot of people I consider competent 
> seem to find the implementation controversial, which argues for waiting 
> until more eyes are on the code.

Yes.  I'm not going to ask Andrew to merge the code until I feel that
everybody concerned is happy with it.  No matter how many release
cycles it takes.

> If the rest of the code is useless without the controversial part,
> maybe it should all stay a patch to use or not as people decide.

It has been distributed separately from the kernel for 3 years now.
So people _can_ try it out.

Thanks,
Miklos
