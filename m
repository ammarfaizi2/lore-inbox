Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130404AbRBUAB6>; Tue, 20 Feb 2001 19:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130410AbRBUABs>; Tue, 20 Feb 2001 19:01:48 -0500
Received: from maila.telia.com ([194.22.194.231]:60173 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S130404AbRBUABf>;
	Tue, 20 Feb 2001 19:01:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Colonel <klink@clouddancer.com>, ttsig@tuxyturvy.com
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Date: Wed, 21 Feb 2001 00:53:57 +0100
X-Mailer: KMail [version 1.2]
Cc: james@pcxperience.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com> <20010220212149.5960E682A@mail.clouddancer.com>
In-Reply-To: <20010220212149.5960E682A@mail.clouddancer.com>
MIME-Version: 1.0
Message-Id: <0102210053570Y.00763@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 February 2001 22:21, Colonel wrote:
>    From: "Tom Sightler" <ttsig@tuxyturvy.com>
>    Cc: <linux-kernel@vger.kernel.org>
>    Date: Tue, 20 Feb 2001 14:43:07 -0500
>    Content-Type: text/plain;
> 	   charset="iso-8859-1"
>
>    >    > >I'm building a firewall on a P133 with 48 MB of memory using RH
>    >    > > 7.0, latest updates, etc. and kernel 2.4.1.
>    >    > >I've built a customized install of RH (~200MB)  which I untar
>    >    > > onto
>
>    the
>
>    >    > >system after building my raid arrays, etc. via a Rescue CD which
>    >    > > I created using Timo's Rescue CD project.  The booting kernel
>    >    > > is 2.4.1-ac10, no networking, raid compiled in but raid1 as a
>    >    > > module
>    >    >
>    >    > Hmm, raid as a module was always a Bad Idea(tm) in the 2.2
>    >    > "alpha" raid (which was misnamed and is 2.4 raid).  I suggest you
>    >    > change that and update, as I had no problems with 2.4.2-pre2/3,
>    >    > nor have any been posted to the raid list.
>    >
>    >    I just tried with 2.4.1-ac14, raid and raid1 compiled in and it did
>    > the same thing.  I'm going to try to compile reiserfs in (if I have
>    > enough
>
>    room
>
>    >    to still fit the kernel on the floppy with it's initial ramdisk,
>    > etc.)
>
>    and
>
>    >    see what that does.
>
>    There seem to be several reports of reiserfs falling over when memory is
>    low.  It seems to be undetermined if this problem is actually reiserfs
> or MM related, but there are other threads on this list regarding similar
> issues. This would explain why the same disk would work on a different
> machine with more memory.  Any chance you could add memory to the box
> temporarily just to see if it helps, this may help prove if this is the
> problem or not.
>
>
> Well, I didn't happen to start the thread, but your comments may
> explain some "gee I wonder if it died" problems I just had with my
> 2.4.1-pre2+reiser test box.  It only has 16M, so it's always low
> memory (never been a real problem in the past however).  The test
> situation is easily repeatable for me [1].  It's a 486 wall mount, so
> it's easier to convert the fs than add memory, and it showed about
> 200k free at the time of the sluggishness.  Previous 2.4.1 testing
> with ext2 fs didn't show any sluggishness, but I also didn't happen to
> run the test above either.  When I come back to the office later, I'll
> convert the fs, repeat the test and pass on the results.
>
>
> [1]  Since I decided to try to catch up on kernels, I had just grabbed
> -ac18, cd to ~linux and run "rm -r *" via an ssh connection.  In a
> second connection, I tried a simple "dmesg" and waited over a minute
> for results (long enough to log in directly on the box and bring up
> top) followed by loading emacs for ftp transfers from kernel.org,
> which again 'went to sleep'.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

If these are freezes I had them too in 2.4.1, 2.4.2-pre1 fixed it for me.
Really I think it was the patch in handle_mm_fault setting TASK_RUNNING.

/RogerL

-- 
Home page:
  none currently
