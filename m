Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269956AbRHENUg>; Sun, 5 Aug 2001 09:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269958AbRHENU0>; Sun, 5 Aug 2001 09:20:26 -0400
Received: from pD9504018.dip.t-dialin.net ([217.80.64.24]:38640 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S269956AbRHENUL>; Sun, 5 Aug 2001 09:20:11 -0400
Message-ID: <3B6D4738.6F77A5E0@pcsystems.de>
Date: Sun, 05 Aug 2001 15:16:40 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3/reiserfs: ext3fine, reiser got OOPS!
In-Reply-To: <3B6CAE4E.17850717@pcsystems.de> <20010805172718.B20716@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>     I 've been using ext3 and reiserfs for somedays with 2.4.7. Using
>     mkreiserfs I recieved some null pointer problems and recieved a
>     kernel oops.
>
> Odd --- nobody else has reported this.  Can you plese supply more
> details (ksymoops) such that these bugs may be fixed.

Retrying it...
Seems like it is _not_ reproduceable currently!
The mkreiserfs ran through it without any problems!
If I can reproduce it again, I will send all
informations.


>     While ext3 is mounted as fast as ext2, reiserfs seems is slower.
>
> Slower to mount? Or slower to use?

Mount and delete.

reiserfs

I created 200000 empty files, and then deleted them.

ext2: creating took a very long time, I aborted (was about 7 minutes)
reiserfs: creating was done in about 3 minutes

ext2: deleting started with find | xargs rm, no problem.

reiserfs: started deleting, recieved NULL pointer
(kernel oops)



>     ext3, 10 GB: ~ 0.5 seconds reisferfs 10 GB: ~ 3-5 seconds
>
> Probably journal replay, still, you might have slow disks.

It's been the same disk.
and i don't think it was a reply, because I created the
filesystem some seconds before.

> A journal
> reply for me of 60+ events takes about 1 second on a single spindle
> (SCSI, U160).

Hmm.... I used udma33 :(

> Do it really matter (within reason) which fs mounts and is made
> faster?  It's not something you do every other minute.

You are right. I was only surprised that the so called
fast reiserfs takes soo long at mounting.

>     While running there occured some problems with reiserfs.
>
> Such as?

It was impossible to delete the files on the one partition.
(see above) The problem is, after I reformated the partition
it was not reproduceable.

It seems there are some strange things in reiserfs, which
happen at special situations.


Nico

