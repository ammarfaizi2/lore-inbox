Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRL0Vxn>; Thu, 27 Dec 2001 16:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRL0Vx2>; Thu, 27 Dec 2001 16:53:28 -0500
Received: from bitmover.com ([192.132.92.2]:48798 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S282693AbRL0VxR>;
	Thu, 27 Dec 2001 16:53:17 -0500
Date: Thu, 27 Dec 2001 13:53:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227135316.N25698@work.bitmover.com>
Mail-Followup-To: Troy Benjegerdes <hozer@drgw.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011227123344.H25698@work.bitmover.com> <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com> <20011227125028.J25698@work.bitmover.com> <20011227154318.F25200@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011227154318.F25200@altus.drgw.net>; from hozer@drgw.net on Thu, Dec 27, 2001 at 03:43:18PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 03:43:18PM -0600, Troy Benjegerdes wrote:
> > Yes, and it works great for easy merges.  It sucks for complicated merges.
> > BK can help you a great deal with those merges.  
> 
> There is a point to be made though that if *Linus* has to do a complicated 
> merge, the 'patch' that caused the merge should probably be suspect in the 
> first place.

That doesn't work for a stream of N patches, which is exactly what a 
maintainer deals with.  In order for your way to work, Linus has to do 
a release each time he applies a patch (or more accurately, before he
tries to apply a patch which touches the same files).

> The person sending the patch should be the one responsible for resolving a
> complicated merge. 

Actually, no.  If you are making a simple change and a set of complicated
changes have been made, I don't want you, the naive developer in this
example, doing the merge.  I, the maintainer in this example, am much
more able to make the right call on the merge.

It's pretty pointless to argue which way is better because the answer is
"it depends".  So you want a system that lets you do it the right way
no matter what that right way is.

Regardless, BK doesn't enforce either model, it can do either way, and it
could send the patch and the merge as another patch, allowing Linus to
redo the merge or accept the merge.  

> If BK makes that easier, great. HOWEVER, I don't really
> want Linus to be using some tool that does automerging.. No SCM system and
> automerge tool is going to understand what the code *means*, unless it's 
> got a compiler integrated into it.

You can turn the automerging off in BK, it's a command line option to 
pull and resolve.   I tend to agree with you that automerging gets you
in trouble, I look at each diff myself.

> I've had some strange things happen on a BK automerge in the past, and I
> don't trust any automated system that doesn't understand the code to not
> make some subtle semantic mistake. (Mind you, when strange things
> happened, the code usually worked, and I didn't notice until I tried to
> *manually* prepare a 'patch' to send upstream)

I think you may be comparing against the older automerge code.  We rewrote
all of that and it's only in the bk-2.1.x series under the Dev directory
in the download area.

We've actually looked at each and every one of the merges in the PPC/Linux
tree and made sure the new code did the right thing.  I'm not advocating 
that you use it or not, you can choose, but if you see a "strange thing"
using bk-2.1.x then tell us, if it's wrong, we'll fix it.  We've run about
40,000 merges through the new code so we're reasonably sure we have covered
the bases but if you can show us where we haven't, we'll thank you and then
fix it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
