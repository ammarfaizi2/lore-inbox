Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293164AbSCOTLB>; Fri, 15 Mar 2002 14:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSCOTKo>; Fri, 15 Mar 2002 14:10:44 -0500
Received: from bitmover.com ([192.132.92.2]:47825 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293162AbSCOTKX>;
	Fri, 15 Mar 2002 14:10:23 -0500
Date: Fri, 15 Mar 2002 11:10:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020315111022.S29887@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020315103914.M29887@work.bitmover.com> <Pine.LNX.4.33.0203151039440.29289-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0203151039440.29289-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 15, 2002 at 11:01:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the thing is that if you do it my way, you _can_ have it both ways.
> 
> If you do it your way, you cannot.

By "your way" you mean "the current way", right?  In which case, the future
option I described is OK, right?  Or am I still missing something?

> Note that there is another way to do all this too: it would be quite nice
> (and probably not too hard) to create a filesystem that exports a BK
> archive, so that you could do something like
> 
> 	mount -o ro -tbk /home/BK/repository/xxxx xxx

I already did this a long time ago, and how the files are stored is completely
orthogonal.  I used the user level NFS server and you could do a 

	mount -o ro,rev=v.2.5.5 -tnfs /home/BK/repository/xxxx v2.5.5

and it worked just fine.  I personally hate this because there is no way that
I have ever seen to make filesystem semantics == SCM semantics.  It turns into
a hack for read/write.  If it made you happy to do this for read only, hey,
there's a nice newbie project.

> > 
> > One gotcha, and we'll fix this now that I think of it, is that this only
> > greps the revision history.
> 
> Oh, I've tried exactly that, and it doesn't work at all for a few reasons. 
> 
> Try
> 
> 	bk -r grep torvalds

Whoops, sorry, try it with -Ur, the -U says "user files only, skip the BK crud"

bk -Ur grep torvalds
CREDITS 1.1     E: torvalds@transmeta.com
README  1.1        them to me (torvalds@transmeta.com), and possibly to any other
SubmittingDrivers       1.1             <torvalds@transmeta.com>.
SubmittingPatches       1.1     Linux kernel.  His e-mail address is torvalds@transmeta.com.  He gets
oops-tracing.txt        1.1     From: Linus Torvalds <torvalds@transmeta.com>
CREDITS 1.1       Linus Torvalds <torvalds@transmeta.com>
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
