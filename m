Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262540AbTCIQpS>; Sun, 9 Mar 2003 11:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262542AbTCIQpS>; Sun, 9 Mar 2003 11:45:18 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39887 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262540AbTCIQpQ>; Sun, 9 Mar 2003 11:45:16 -0500
Date: Sun, 09 Mar 2003 08:55:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <8200000.1047228943@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303091609440.5042-100000@serv>
References: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com><Pine.LNX.4.44.0303090504140.32518-100000@serv> <m14r6ck6jd.fsf@frodo.biederman.org> <Pine.LNX.4.44.0303091609440.5042-100000@serv>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > This is actually a key feature I want to see in a SCM system - the ability 
>> > to keep multiple developments within the same repository. I want to pull 
>> > other source tress into a branch and compare them with other branches and 
>> > merge them into new branches.
>> 
>> In a distributed system everything happens on a branch.
> 
> That's true, but with bk you have to use separate directories for that, 
> which makes cross references between branches more difficult.
> 
>> > I agree, what I was trying to say is that the SCCS format makes a few 
>> > things more complex than they had to be.
>> 
>> I don't know, if the problem really changes that much.  How do
>> you pick a globally unique inode number for a file?  And then
>> how do you reconcile this when people on 2 different branches create
>> the same file and want to merge their versions together?
> 
> Unique identifier are needed for change sets anyway and if you decide 
> during merge, that two files are identical, at least one branch has to 
> carry the information that these identifiers point to the same file.
> 
>> So as a very rough approximation.
>> - Distribution is the problem.
> 
> I would rather say, that it's only one (although very important) problem.

I think it's possible to get 90% of the functionality that most of us
(or at least I) want without the distributed stuff. If that's 10% of
the effort, would be really nice to have the auto-merging type of
functionality at least.

If the "maintainer" heirarchy was a strict tree structure, where you 
send patches to your parent, and receive them from your children, that
doesn't seem to need anything particularly fancy to me. 

Personally, I just collect together patches mainly from IBM people here, 
test them for functionality and performance, and sync up with Linus every 
new release by reapplying them on top of the new tree, and fix the conflicts 
by hand. Then I just email the patches as flat diffs to Linus. If I could 
get some really basic auto-merge functionality, that would get rid of 90% 
of the work, even if it only worked 95% of the time, and showed me what 
it had done that patch couldn't have done by itself. I don't see why that 
requires all this distributed stuff. If I resync with the latest -bk 
snapshot just before I send, the chances of Linus having to do much merge
work is pretty small.

I'm sure Bitkeeper is better than that, and has all sorts of fancy features,
and perhaps Linus even uses some of them. But if I can get 90% of that for
10% of the effort, I'd be happy. Some way to pass Linus some basic metadata
like changelog comments would be good (at the moment, I just slap those atop
the patch, and he edits them, but a basic perl script could hack off a 
"comment to Linus" section from a "changelog section", which might save
Linus some editing).

Andrew and Alan seem to work pretty well with flat patches too - Larry
seemed to imply that he thought the merge part of the problem was easy
enough in a non-distributed system ... if anything existant has or could 
have that without the distributed stuff and the complexity, would be cool.

If I'm missing something fundamental here, it wouldn't suprise me ;-)

M.
