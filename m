Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbRBUQpF>; Wed, 21 Feb 2001 11:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbRBUQoz>; Wed, 21 Feb 2001 11:44:55 -0500
Received: from www.pcxperience.com ([199.217.242.242]:59124 "EHLO
	gannon.zelda.pcxperience.com") by vger.kernel.org with ESMTP
	id <S129619AbRBUQol>; Wed, 21 Feb 2001 11:44:41 -0500
Message-ID: <3A93F020.8519513D@pcxperience.com>
Date: Wed, 21 Feb 2001 10:43:12 -0600
From: "James A. Pattie" <james@pcxperience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: klink@clouddancer.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com> <20010220212149.5960E682A@mail.clouddancer.com> <0102210053570Y.00763@dox> <20010221034936.49B42682A@mail.clouddancer.com> <3A93D46E.73CAA2B8@pcxperience.com> <20010221161948.1FFD1682A@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colonel wrote:

>    Sender: james@pcxperience.com
>    Date: Wed, 21 Feb 2001 08:45:02 -0600
>    From: "James A. Pattie" <james@pcxperience.com>
>
>    Colonel wrote:
>
>    >    >    There seem to be several reports of reiserfs falling over when memory is
>    >    >    low.  It seems to be undetermined if this problem is actually reiserfs
>    >    > or MM related, but there are other threads on this list regarding similar
>    >    > issues. This would explain why the same disk would work on a different
>    >    > machine with more memory.  Any chance you could add memory to the box
>    >    > temporarily just to see if it helps, this may help prove if this is the
>    >    > problem or not.
>    >    >
>    >    >
>
>    When the machine stopped responding, the first time, I let it go over the weekend
>    (2 days+) and it still didn't recover.  I never saw a thrashing effect.  The
>    initial memory values were 2MB free memory, < 1MB cache.  I never really looked at
>    the cache values as I wasn't sure how they affected the system.  when the system
>    was untarring my tarball, the memory usage would get down < 500kb and swap would be
>    around a couple of megs usually.
>
> Well, it still looks like you have a good test case to resolve the
> problem.  Can you add memory per the above request?
>
> I should drop out of this, it seems I had a one time event.  Something
> to keep in mind is /boot should either be ext2 or mounted differently
> under reiser (check their website for details).  You should probably
> try the Magic SysREQ stuff to see what's up at the time of freeze.
> You should probably run memtest86 to head off questions about your
> memory stability.

I added memory yesterday and got it to work after having 64MB in the system.  the free
memory (cache/buffer) was over 30MB.  I didn't have any problems then.

After I got everything installed, I bumped the memory back to 48MB and it is running
fine.  I don't have the 17+MB ramdisk taking up the memory anymore, so the system has >
15MB of cache/buffer available at all times, even running ssh, sendmail, squid,
firewalling, etc.


>
>
> Just to check on the raid setup, the drives are on separate
> controllers and there is not a slow device on the same bus?  I've been
> running the "2.4" raid for a couple years and that was the usual
> problem.  Reiserfs is probably more aggressive working the drive and
> it may tend to unhide other system problems.
>

They are on seperate controllers.  The second controller has the CD-ROM drive (32x) which
should be faster than the hard drive (since the drives are older).

>
> --
> "... being a Linux user is sort of like living in a house inhabited by
> a large family of carpenters and architects. Every morning when you
> wake up, the house is a little different. Maybe there is a new turret,
> or some walls have moved. Or perhaps someone has temporarily removed
> the floor under your bed." - Unix for Dummies, 2nd Edition

--
James A. Pattie
james@pcxperience.com

Linux  --  SysAdmin / Programmer
PC & Web Xperience, Inc.
http://www.pcxperience.com/



