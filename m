Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSDZSuO>; Fri, 26 Apr 2002 14:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314123AbSDZSuO>; Fri, 26 Apr 2002 14:50:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15232 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314106AbSDZSuN>; Fri, 26 Apr 2002 14:50:13 -0400
Date: Fri, 26 Apr 2002 14:50:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@ucw.cz>,
        Michael Dreher <dreher@math.tu-freiberg.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre7: rootfs mounted twice
In-Reply-To: <Pine.LNX.4.44.0204270145140.6483-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.3.95.1020426144850.12616A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Jeff Chua wrote:

> On Fri, 26 Apr 2002, Alexander Viro wrote:
> 
> >
> >
> > On Fri, 26 Apr 2002, Pavel Machek wrote:
> >
> > > > does statfs("/", &buf); for both.  Surprise, surprise, results of
> > > > two calls of statf2(2) are identical - what with arguments being
> > > > the same both times - and refer to the filesystem where your "/"
> > > > lives.  I.e. to ext3.
> > >
> > > df might be wrong, but lets say that this /proc/mounts become
> > > interesting. This could not have happened in the past. That means you
> >
> > This _could_ happen in past - as the matter of fact, I can reproduce it
> > on any 2.4 kernel.  Mount something over the root of already mounted
> > filesystem and watch the show.
> >
> > Now, we could disable showing rootfs in /proc/mounts and it might be a
> > good idea for 2.4,  I'm not all that sure that it's a right thing, though.
> 
> 
> This happens all the time if you use initrd ramdisk and switch to hard
> disk during boot up.
> 
> 2.4.19-pre6 is ok, but 2.4.19-pre7 is not.
> 
> Jeff.
> 

In 2.4.18, it looks like this when booting initrd and switching
to a hard disk. This looks okay.

/dev/root.old /initrd ext2 rw 0 0
/dev/root / ext2 rw 0 0
/dev/sdc1 /alt ext2 rw 0 0
/dev/sdc3 /home/users ext2 rw 0 0
none /proc proc rw 0 0
/dev/sda1 /dos/drive_C msdos rw 0 0
/dev/sda5 /dos/drive_D msdos rw 0 0


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

