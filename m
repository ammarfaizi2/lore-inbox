Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbRE1MBb>; Mon, 28 May 2001 08:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbRE1MBV>; Mon, 28 May 2001 08:01:21 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:24228 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261297AbRE1MBL>; Mon, 28 May 2001 08:01:11 -0400
Message-Id: <5.1.0.14.2.20010528125630.04729ba0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 28 May 2001 13:01:53 +0100
To: Martin von Loewis <loewis@informatik.hu-berlin.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [Linux-ntfs] Re: [Linux-NTFS-Dev] Re: ANN: NTFS new 
  release available (1.1.15)
Cc: yuri@acronis.com, linux-kernel@vger.kernel.org,
        Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <200105281110.NAA28612@pandora.informatik.hu-berlin.de>
In-Reply-To: <3B11E3F1.1090400@acronis.com>
 <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010527123154.00a96640@pop.cus.cam.ac.uk>
 <200105271253.OAA22557@pandora.informatik.hu-berlin.de>
 <3B11E3F1.1090400@acronis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:10 28/05/2001, Martin von Loewis wrote:
> > >That would not work: NT would split individual runs across extends
> > >(i.e. split them in the middle). Did I misunderstand, or do you have a
> > >solution for that as well.
> > >
> > Are you sure that it's true? My NTFS resizer interprets parts of runlist
> > stored in different FILE records independently and I never experienced
> > any problems with that.
>
>I'm sure it could happen on NT 3.1. Maybe MS has fixed it since.

Hm, in that case I think I will implement it the way I was thinking and I 
will assume that it can't happen any more. - I will add some kind of sanity 
check at the beginning to catch problems and scream to the syslog which we 
can remove later.

Does anyone know what NTFS version the NT 3.1 / 3.51 volumes had? If I know 
I can make sure we don't mount such beasts considering we know the driver 
would fail on them... - I am aware of only one person stil using NT 3.51 
and he doesn't believe in the NTFS Linux driver any more, so I guess we can 
just say we support NT 4.0 and above only.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

