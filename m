Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282498AbRKZUnL>; Mon, 26 Nov 2001 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbRKZUnF>; Mon, 26 Nov 2001 15:43:05 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:34483 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282498AbRKZUmp>; Mon, 26 Nov 2001 15:42:45 -0500
Message-Id: <5.1.0.14.2.20011126203413.049fa180@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 26 Nov 2001 20:42:47 +0000
To: ptb@it.uc3m.es
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Possible md bug in 2.4.16-pre1
Cc: "Alok K. Dhir" <alok@dhir.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200111261929.UAA31258@nbd.it.uc3m.es>
In-Reply-To: <000c01c1769c$187cc390$9865fea9@pcsn630778>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:29 26/11/01, Peter T. Breuer wrote:
>"Alok K. Dhir wrote:"
> > On kernel 2.4.16-pre1 software RAID (tested with levels 0 and 1 on the
> > same two drives), it is not possible to "raidstop /dev/md0" after
> > mounting and using it, even though the partition is unmounted.  Attempts
>
>Raid has been in quite a shocking state for a long while and
>often there seems nor rhyme nor reason to its behaviour. If you want
>to stick your machine in an endless loop, just try initialising a
>mirror raid device with only one of its two components currently
>working.

Define "long while"... Here RAID-0 is working fine. Admittedly the file 
server is still on kernel 2.4.10-pre14 (+ some patches) but I can't be 
bothered to reboot it to install a new kernel (uptime is growing nicely...).

When you simulate not working component of RAID-0 by marking it as such in 
/etc/raidtab it works fine for me. I know because I used it when installing 
the second disk and creating several RAID-0 arrays on my file server on the 
new disk then copying the data accross, marking the old disk partitions as 
the other working half of the raid arrays and letting md driver synchronize 
them without any problems at all... I did a lot of raidstart/stops at that 
time too without problems.

> > are rejected with "/dev/md0: Device or resource busy".  Even shutting
>
>ya, ya. Try raidhotsetfaulty for good luck and then try raidhotremove.
>(curse, splutter. Will the authors ever write some docs that make
>sense. And also document the interactions with lvm).

Hm, I should try 2.4.16 some time to see if it breaks here...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

