Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313765AbSDZS2z>; Fri, 26 Apr 2002 14:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSDZS2y>; Fri, 26 Apr 2002 14:28:54 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:65032 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S313765AbSDZS2x>; Fri, 26 Apr 2002 14:28:53 -0400
Date: Sat, 27 Apr 2002 01:47:14 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alexander Viro <viro@math.psu.edu>
cc: Pavel Machek <pavel@ucw.cz>, Michael Dreher <dreher@math.tu-freiberg.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre7: rootfs mounted twice
In-Reply-To: <Pine.GSO.4.21.0204261326580.22065-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0204270145140.6483-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/27/2002
 01:47:02 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/27/2002
 01:47:21 AM,
	Serialize complete at 04/27/2002 01:47:21 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Alexander Viro wrote:

>
>
> On Fri, 26 Apr 2002, Pavel Machek wrote:
>
> > > does statfs("/", &buf); for both.  Surprise, surprise, results of
> > > two calls of statf2(2) are identical - what with arguments being
> > > the same both times - and refer to the filesystem where your "/"
> > > lives.  I.e. to ext3.
> >
> > df might be wrong, but lets say that this /proc/mounts become
> > interesting. This could not have happened in the past. That means you
>
> This _could_ happen in past - as the matter of fact, I can reproduce it
> on any 2.4 kernel.  Mount something over the root of already mounted
> filesystem and watch the show.
>
> Now, we could disable showing rootfs in /proc/mounts and it might be a
> good idea for 2.4,  I'm not all that sure that it's a right thing, though.


This happens all the time if you use initrd ramdisk and switch to hard
disk during boot up.

2.4.19-pre6 is ok, but 2.4.19-pre7 is not.

Jeff.



