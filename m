Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbRAJECV>; Tue, 9 Jan 2001 23:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131933AbRAJECM>; Tue, 9 Jan 2001 23:02:12 -0500
Received: from cs2732-110.austin.rr.com ([24.27.32.110]:2545 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130548AbRAJEB6>; Tue, 9 Jan 2001 23:01:58 -0500
Message-ID: <3A5B9B9E.E38A810C@flash.net>
Date: Tue, 09 Jan 2001 17:15:42 -0600
From: Rob Landley <landley@flash.net>
Organization: Boundaries Unlimited
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Learn from minix: fork ramfs.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Argh!  Linus replies to my post and my cc: to the linux-kernel was to
rutgers.edu.  Teach me to post on three hours of sleep, it's like
getting a hole-in-one with nobody around...)

Linus said in Re: Patch (repost): cramfs memory corruption fix

> I wonder what to do about this - the limits are obviously useful,
> as would the "use swap-space as a backing store" thing be. At the
> same time I'd really hate to lose the lean-mean-clean ramfs. 

So fork ramfs already.  Copy the snapshot you like as an educational
tool, call it skeletonfs.c or some such, and let the current code evolve
into something more useful.

Seems to me a dude named Andrew was in a similar situation a decade or
so back, and decided to resist all change in the name of having a clear
educational example.  Patch pressure built up past the "reimplementation
from scratch threshold event horizon thingy" (the tanenbaum-torvalds
barrier), at which point the code forked under its own weight anyway.

Saves a lot of bother to do it now, if you ask me.  You'll wind up with
a new ramfs one way or the other.  People will keep writing it as long
as it's not there.  (The whole "why climb mount everest" thing, you
know.)

I could, of course, be totally wrong about this...

Rob
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
