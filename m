Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbTCLTkt>; Wed, 12 Mar 2003 14:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTCLTkt>; Wed, 12 Mar 2003 14:40:49 -0500
Received: from bitmover.com ([192.132.92.2]:50860 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261977AbTCLTki>;
	Wed, 12 Mar 2003 14:40:38 -0500
Date: Wed, 12 Mar 2003 11:51:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312195120.GB7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nicolas Pitre <nico@cam.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Boo hoo, cry me a river.
> 
> Larry, please don't fall into that trap.

I'm not, I was just blowing off steam.  Ya gotta admit it is pretty 
unreasonable for people to complain without even checking.  I'm tailing
the history log in the CVS repository, there have been 3 or 4 downloads
since last night, that's it.  All that whining and no looking at all.

> > If you can't say something nice, now is a good time to say nothing at all
> > because we are sick and tired of dealing with people who complain far more
> > than they code.
> 
> Then why do you let them turn you down?  Why are those people so credible to 
> you so you feel you must listen to them?

Well, I agree that they should be able to get at the information in a 
neutral way.  I guess it was unrealistic, but I was expecting that people
would go download the CVS tree and poke around and see if it is what they
wanted.  We could have had a nice technical discussion about what was 
missing, if anything.  If the discussion had happened, they would have 
found out that even for the missing deltas we captured the information.

Here's an example.  Suppose the graph is like

	1.1 (torvalds) -> 1.2 (alan) -> 1.3 (sct) -> 1.4 (torvalds) 
	             \                             /
		      \-> 1.1.1.1 (davej) --------/

and we picked the straight 1.1 to 1.4 path.  When we created the CVS 1.4
delta, we knew that it was a merge delta and we needed to capture the 
data off on the branch.  We already capture the contents, the missing part
is what davej may have typed in as comments.  We capture that as well, it
looks like this:

    revision 1.342
    date: 2003/03/07 15:39:16;  author: torvalds;  state: Exp;  lines: +7 -1
    [PATCH] kbuild: Smart notation for non-verbose output

    2003/03/05 19:50:27-06:00 kai
    kbuild: Make build stop on vmlinux link error

    (Logical change 1.8166)

That particular example is from the top level Makefile, Linus merged
in Kai's work and we added the "kbuild: Make build stop on vmlinux link
error" comments from the merged in delta.  If there were more than one
delta, they get merged as well, so the rlog output is completely accurate.

So we actually captured 100% of the checkin information, both in data
files and in the pseudo ChangeSet file, not one byte of that is lost.
All we did is collapse all the branches into the longest possible straight
line, which is actually for many purposes nicer than the rats nets that
you get with BK.

Anyway, to get back to your question, what gets me down is that we did
what we believe to be the absolute perfect job.  All the data is captured,
all the checkin comments are captured, we made all the dates go forward
properly so that diffs would work, there is nothing wrong with the CVS
tree, it's perfect.  It would have been nice if people had actually
looked at it.  You can, go look at

    http://linux.bkbits.net:8080/linux-2.5/hist/Makefile

and compare it to this:

    cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs rlog linux-2.5/Makefile

Poke around, play with your favorite files, you'll see your checkin
comments, we didn't lose anything at all.  Apparently, that's too much
to ask, and that's what gets me down.  I don't expect people to say
"rah rah, you guys are great" but I did expect the people who have been
bitching non-stop that they can't get what they want would at least go
see if they could get it now.  Silence would be a more than adequate
reward as far as I'm concerned, I don't need the strokes but I am sick
of the baseless whining.  Fear not, I'll get over it.

What I expected from Ben was a polite request for a tarball of the CVS
tree so he could go convert it to SVN and see if all his checkin comments
are there.  No such request, polite or otherwise, has happened, from him
or anyone else.  So it's becoming apparent that the whole data/metadata
whatever is a red herring, they just want to flame.  Whatever, somebody
will get some good use out of the CVS trees, if I were in your shoes
I'd want them as a safety net so it's cool they exist.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
