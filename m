Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312091AbSCQTGb>; Sun, 17 Mar 2002 14:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312101AbSCQTGW>; Sun, 17 Mar 2002 14:06:22 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:914 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S312091AbSCQTGJ>;
	Sun, 17 Mar 2002 14:06:09 -0500
Message-Id: <5.1.0.14.2.20020317190303.03289ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 17 Mar 2002 19:06:53 +0000
To: "Ken Hirsch" <kenhirsch@myself.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <00a301c1cde2$fa76fed0$0100a8c0@DELLXP1>
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
 <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:35 17/03/02, Ken Hirsch wrote:
>Anton Altaparmakov writes
> > Posix or not I still don't see why one would want that. You know what you
> > are going to be using a file for at open time and you are not going to be
> > changing your mind later. If you can show me a single _real_world_ example
> > where one would genuinely want to change from one access pattern to
>another
> > without closing/reopening a particular file I would agree that fadvise is
>a
> > good idea but otherwise I think open(2) is the superior approach.
> >
>
>Sure, a database manager can change the access pattern on every query.  If
>there's an index and not too many records are expected to match, it will use
>a random pattern, otherwise it will use sequential access.

Last time I heard serious databases use their own memmory 
management/caching in combination with O_DIRECT, i.e. they bypass the 
kernel's buffering system completely. Hence I would deem them irrelevant to 
the problem at hand...

If a database were not to use O_DIRECT I would think it would be using mmap 
so it would have madvise already... but I am not a database expert so take 
this with a pinch of salt...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

