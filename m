Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRG0OVg>; Fri, 27 Jul 2001 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRG0OV1>; Fri, 27 Jul 2001 10:21:27 -0400
Received: from [208.187.172.194] ([208.187.172.194]:13594 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S268856AbRG0OVN>; Fri, 27 Jul 2001 10:21:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joshua Schmidlkofer <menion@srci.iwpsd.org>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 08:18:12 -0600
X-Mailer: KMail [version 1.2]
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>
MIME-Version: 1.0
Message-Id: <0107270818120A.06707@widmers.oce.srci.oce.int>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I've almost quit using reiser, because everytime I have a power outage, the 
last 2 or three files that I've editted, even ones that I haven't touched in 
a while, will usually be hopelessly corrupted.  The '<file>~' that Emacs 
makes is usually fine though.   It seems to be that any open file is 
in danger.  I don't know if this is normal, or not, but I switched to XFS on 
several machines.  I have nothing against reiser.  I assumed that these 
problems were due to immaturity.... 

   One more thing - All my computers with Reiser as '/'  on them had a 
disturbingly long boot time.   From the time when the Redhat startup scripts 
began, it was.... hideously slow.   I thought nothing of it, blaming bash, 
etc, Until I switched to ext2 on all those.  Now the boot time is...  SUPER 
fast.  [3 Computers, 1 K6-2, a Pentium III, and a Pentium II, all 128+meg, 
and IDE] I currently have 3 computers running reiserfs left, all are using 
MySQL databases. 
    Once,  I lost power in on my SQL box, [it was blessedly during a 
period of no use.]  I had to rebuild all the indexes.  Not  only THAT, but 
what happens to that box if I lose power whilst in the middle of operations?  
I am working on the migration plan to move that to XFS because of these 
concerns. [However, I am doing a better job of testing with XFS first.]

  I think that Reiser is cool, and has neat ideology, but I am un-nerved by 
this behaviour.

js


>
> Yup. I know ext2 can do it. I expect a filesystem to not foul up my data
> when something happens. Especially not shuffle around sectors in several
> files. I can understand that the changes I made are not on disc, I can
> even understand it if my files are gone, but not when it corrupts my data.
> That just plain sucks.
>
> A friend of mine has had crashes as well (not reiser related btw), where
> files he was using at the time suddenly contained different pieces of
> different files. It's just plain annoying. The reason why *I* use(d)
> reiserfs was the fact that I thought that it would protect my data when
> something does crash. From my experience, it doesn't, and I'd rather wait
> a couple of minutes for ext2 to fsck than use reiserfs and be sure I can
> start all over again.
>
> Regards,
>
> Bas Vermeulen
