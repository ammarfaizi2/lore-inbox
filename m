Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136142AbRAWGvA>; Tue, 23 Jan 2001 01:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136167AbRAWGuv>; Tue, 23 Jan 2001 01:50:51 -0500
Received: from clueserver.org ([206.163.47.224]:49682 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S136142AbRAWGun>;
	Tue, 23 Jan 2001 01:50:43 -0500
Date: Mon, 22 Jan 2001 23:01:14 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Trever Adams <vichu@digitalme.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <Pine.LNX.4.32.0101230026490.7610-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.10.10101222247150.3031-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Mike A. Harris wrote:

> On Mon, 15 Jan 2001, Trever Adams wrote:
> 
> >I had a similar experience.  All I can say is windows 98
> >and ME seem to have it out for Linux drives running late
> >2.3.x and 2.4.0 test and release.  I had windows completely
> >fry my Linux drive and I lost everything.  I had some old
> >backups and was able to restore at least the majority of
> >older stuff.
> >
> >Sorry and good luck.
> 
> I don't see how Windows 9x can be at fault in any way shape or
> form, if you can boot between 2.2.x kernel and 9x no problem, but
> lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
> everything.  Windows does not touch your Linux fs's, so if there
> is a problem, it most likely is a kernel bug of some kind that
> doesn't initialize something properly.

I am seeing weird reporting of size problems on a VFAT partition.

It has not corrupted anything, but a "df" shows the size to be a large
negative number.  (It worked when the drive had about 22 gigs full on the
30 gig partition, but went wonky when I deleted everything on that
partition.)

Drive is a Western Digital 307AA 30.7 gb drive.

Kernel is 2.4.0 on a P-III 650.

Partition is type "c" (Win95 FAT32 (LBA)).  Partition starts at 1 and ends
on 3739. 30033486 blocks.

/dev/hdb1    30018800 -295147905179350204416  32652912  9% /export1

df version is from fileutils-4.0.  (Mandrake package fileutils-4.0-13mdk,
which is current.)

du reports the correct amount of space used.  I can read the drive, but
the drive size reported is not correct.  Not certain if this is a problem
in 2.4.0, df, or something else. Have never seen this problem before.
(And I mount vfat partitions frequently.)  

I have not seen any file corruption on this or the other Linux partition
that stays in the drive the few and far between times I run Win 98.
(Carmageddon 3 does not run under Linux yet...)

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
