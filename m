Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132573AbRDAWfq>; Sun, 1 Apr 2001 18:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132575AbRDAWfg>; Sun, 1 Apr 2001 18:35:36 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:37417 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S132573AbRDAWfV>; Sun, 1 Apr 2001 18:35:21 -0400
Message-Id: <4.3.2.7.2.20010401153355.00b5d630@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 01 Apr 2001 15:34:35 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: bug database braindump from the kernel summit
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:54 AM 4/1/01 -0700, Larry McVoy wrote:
>     - one key observation: let bugs "expire" much like news expires.  If
>       nobody has been whining enough that it gets into the high signal
>       bug db then it probably isn't real.  We really want a way where no
>       activity means let it expire.

I have a couple of suggestions that may improve the bug tracking process 
without needing a bug czar or driving everyone crazy.

1)  The idea of letting a bug "expire" is a good one.  One way to do this 
is to incorporate some form of user-base moderation into the bug 
database.  Unlike some of the forum systems, there's no reason why we can't 
have tiers of moderators:  "maintainers" are the clearinghouse people for 
certain portions of the Linux kernel source tree and should have a larger 
voice as to whether a bug is important, redundant, or completely off 
base.  "contributors" are people recognized as having contributed in one 
way or another to the source tree (or, as the bug systems grows to 
encompass documentation, the documentation tree) and could serve as a 
"citizens advisory group" to speed the process of sorting the wheat from 
the chaff.  Also, a "contributor" would be able to "take ownership" of the bug.

2)  One of the big problems is recognizing that a particular bug has 
already been reported, and more importantly getting some sort of link 
between the new bug and the old bug.  When I ran a DVT operation, the 
developers found this linkage to be extremely useful in order to trace the 
source of bugs, especially really obscure ones that cut across a number of 
modules.

3)  In the commercial software world, there is a requirement that a bug be 
verified by someone "in house" -- in other words, a bug isn't a bug until 
someone can reproduce it.  This is a key item in separating the noise from 
the signal.  Again, the group-moderation system would permit quick 
identification of repeatable bugs.

4)  Using an NNTP interface would be interesting.  "Follow-ups" could 
consist of observations, commands, and requests for additional information 
from the bug report that isn't visible from the basic NNTP tree.  If you 
want to see more about a bug, the tree representation could let you pick 
and choose what you want to look at.  For someone who prefers to have 
everything to hand, a command would say "email sections a, b, ... to me 
(with "me" defined in the NNTP headers) and those sections would be mailed 
to the individual.

5)  Most important, the person originally submitting the bug should have an 
easy way of saying "never mind."  Existing search commands in the NNTP 
interface could make this a very easy chore for the infrequent contributor.

EXPIRING:  It's one thing to do an expire a la standard NNTP conventions, 
but it's quite another to do something "smarter".  I see a couple of things 
that would have to enter into a decision whether to expire a bug from the 
pending-status list:

a)  The bug needs to be present for more than a set amount of time without 
overt activity.
b)  A person trying to replicate the bug should be able to extend the 
time-out -- some bugs take longer to replicate than others.  If you don't 
allow for this, the bug could be expired before it can be verified, and the 
verifier has to work harder (assuming they even bother) to extract the bug 
from the data mine and get it to where a code guy can get to it.
c)  A maintainer should be able to sink a bogus bug early, especially if no 
one has owned up to trying to replicate it or fix it.  Contributors can 
heartily declare a bug "bogus", and if enough do so the bug could be sunk 
early.  Also, if enough people say "I can't replicate this bug" that's a 
good sign you have a piece of noise.

 From my own experience in commercial shops, I'd say that we could start 
with an expire time of two weeks, and if necessary adjust it.  Weighting 
for each of the metrics for expiring bugs could be set experimentally.  The 
goal is that a maintainer can squash bugs NOW, and the community could 
actively squash bugs in 24 hours.

IS THE BUG FIXED:  When a bug is declared "fixed" the bug tracking system 
needs to alert everyone who has submitted the bug and replicated it.  This 
notification would then let those people (those who are still interested) 
see if the patch really fixes the bug.  If it does, confirmation of a bug 
fix would be included, and that would help Alan & Co. to determine what 
patches should go in.

Just a few random thoughts on the whole process -- but I suspect others 
have already thought of these things.  I'd be interested in working on 
this, day job willing.

Stephen Satchell
satch@fluent-access.com

