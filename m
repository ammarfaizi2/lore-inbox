Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWGUUqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWGUUqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 16:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWGUUqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 16:46:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12207 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751167AbWGUUqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 16:46:16 -0400
Message-ID: <44C12F0A.1010008@namesys.com>
Date: Fri, 21 Jul 2006 13:46:18 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: the " 'official' point of view" expressed by kernelnewbies.org regarding
 reiser4 inclusion
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is http://wiki.kernelnewbies.org/WhyReiser4IsNotIn truly the "official"
point of view as claimed by its author?  An interesting method of
expression for it.  I heard about it from a user who suggested that I
respond before it got slashdotted.

Let me ask that one compare and contrast the ext4 integration procedure
outlined by Ted Tso, with the procedure experienced by other
filesystems.  The code isn't even written, benchmarked, or tested yet,
and it is going into the kernel already so that its developers don't
have to deal with maintaining patches separate from the tree.  Wow. 
Kind of hard to argue that it is not politically differentiated, isn't it?

Consider what happened with XFS as the article writer mentions.  I met
the original XFS team, led by two very senior developers (Jim Grey, and
another fellow whose name I am blanking on, forgive me, I learned much
from him in just a few conversations).  They were kind enough to
instruct me on what ideas I should take from XFS, and you know what, I
listened.  Reiser4's allocate on flush is the result of their kind
instruction.  I then took it a bit further, like a good student, and
Reiser4 also has balance on flush, compress on flush, etc.

These guys wanted to port XFS to Linux, but there was a problem, which
was that IRIX was better in some ways than Linux, and XFS depended on
those advantages.  Now I met them, and I have to tell you that it was
pretty obvious that these guys knew what they were doing.  Suggest that
these guys needed supervision --- sorry, no way, we needed their
supervision.  What happened?  They got hassled.  Instead of learning
from them, welcoming into our community two very senior developers who
knew a lot more than any of us about the topics they chose to speak
about, they got hassled, they get ignored, they felt rejected, and left
the Linux community forever, never to return.  XFS is still with us, but
the loss of those two could only have been devastating for their
project.    I think the whole kernel community suffered from their loss.

Linux has a problem, which is that with success it is attracting people
with more skill than what it started with, and it is not doing a very
good job of handling that.  In fact, it downright stinks at it, behaving
in the worst way it could choose for handling that.  We have lost quite
a number of FS developers who just don't want to deal with people who
know less than they do but are obnoxious and disrespectful to
submissions because they enjoy powertripping.  We lost David Mazieres,
for example, because he is very very bright, is one of DARPA's most
promising security researchers, and he does not want to be bothered with
Viro et al. so he develops for BSD instead.  Linus, if you really want
to prove that Linux welcomes talented people, go sweet talk Mazieres
into giving Linux another try, you might succeed if you try.  The odd
thing is that Viro is not obnoxious at all in person.  lkml suffers from
email disease, and we need to make conscious efforts to reduce that.

Regarding distros accepting filesystems first, that is just completely
backwards from what it ought to be.  Linus, I respect you a lot, but I
know this one is your idea, and some things I disagree with you on. 
Distros are marketed towards people who do not know how to tar and untar
if an FS is dropped.  A reasonable approach would be to say that any
filesystem marked as experimental can be dropped at any time, so if you
aren't able to tar and untar the partition it is on when a new kernel
comes out, you should not use experimental filesystems.  Then most
distros will not make the experimental FS visible to users who don't
press three buttons acknowledging that they were warned....  Linspire's
view is pretty simple, they need to know that Reiser4 will be accepted
BEFORE they make their distro depend on it.  This is being responsible
to their users.  I could go ask Debian, etc., to include Reiser4, but it
is the wrong way, so I am shy about it.

I am not saying that ext4 should not be accepted as an experimental FS,
I don't even really believe that ext4 should only be accepted when it is
higher performance than Reiser4, I am saying that the process should be
the same for everyone.  Reiser4 is the upgrade for ReiserFS V3, in which
we fix all of V3's flaws without disturbing the mission critical servers
using V3 by changing the V3 code underneath them.  (Things like the bug
affecting MythTV users on V3 at the moment just should not be
happening.  Experiments belong in V4, and I wish there was more respect
for my views on this.).  V4 contains bug fixes for several V3 bugs that
are too deep to fix without deep rewrite, and since V3 does not have
plugins, disk format changes should not get added to a stable branch. 
When submitted Reiser4 was more stable than V3 was when it was
accepted.  (This is because we now have a much better test suite.   I
would never submit code that I know has a bug unfixed.  At the moment we
can crash Reiser4 using our test suite, as some of the linux kernel
inclusion related changes made recently were extensive, I hope we have
that bug fixed by next week.)

We should develop a culture in which acceptance is more based on whose
code measurably performs well than on who is friends with whom.  We
should not think that such a culture will develop without an effort
being made to grow it.

Actually, if we just had a few more akpms to go around, things would be
a lot better..... oh well.  We need to recruit more people like him. 
You can't really have code reviewed by persons less experienced and
proven than those being reviewed, it just doesn't work too well.  Linux
needs to look outward more, and welcome persons who have proven
themselves in other arenas as though we were lucky to get their time. 
Because we are.  Maybe when we don't have people with the expertise to
review something, we should go outside the Linux community, like the way
academic journals will solicit outside reviewers for particular articles
as they need them.  Our current attitude resembles that of BSD before it
lost the market to Linux, I remember it well, there was a reason why I
developed for Linux instead.

Avoiding the problems that some large corporations have with politics
does not happen automatically as a result of it being free software, it
requires as much effort as it does in the successful large
corporations.  Non-profits are in no way immune to being harmed by
internal politics.

If it is true that Reiser4 is likely to go in for 2.6.19, this is good
to hear, though an odd source to hear it from.  If it is true, then I
will skip lobbying distros to accept Reiser4 before the kernel does,
because really it makes little sense for them to do so.

Hans
