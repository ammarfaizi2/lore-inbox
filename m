Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266519AbRGLTEU>; Thu, 12 Jul 2001 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266523AbRGLTEL>; Thu, 12 Jul 2001 15:04:11 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:10979 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266519AbRGLTD7>; Thu, 12 Jul 2001 15:03:59 -0400
Message-Id: <5.1.0.14.2.20010712195903.00a83d10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 12 Jul 2001 20:04:05 +0100
To: Greg KH <greg@kroah.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Security hooks, "standard linux security" & embedded use
Cc: Hans Reiser <reiser@namesys.com>, LA Walsh <law@sgi.com>,
        reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
In-Reply-To: <20010712114729.B735@kroah.com>
In-Reply-To: <5.1.0.14.2.20010712192608.0365e588@pop.cus.cam.ac.uk>
 <3B49F602.DB39B3A@sgi.com>
 <3B4DDFD8.27C1C3D9@namesys.com>
 <5.1.0.14.2.20010712192608.0365e588@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:47 12/07/2001, Greg KH wrote:
>On Thu, Jul 12, 2001 at 07:37:36PM +0100, Anton Altaparmakov wrote:
> >
> > This seems very good in view of implementing ACL support for NTFS, too. -
> > We have all the NTFS layout knowledge to do it now. We just lack the
> > kernel/user space infrastructure.
> >
> > When designing this modular security infrastructure it would be useful if
> > it is made generic enough to allow callbacks into user space for 
> permission
> > checking.
>
>The current model lets you do whatever you want in your kernel module.
>It imposes no policy, that's up to you.

Ok, that's fair enough. A wrapper module could always be written that then 
in turn invokes user space. That's good enough for me although it makes for 
additional overhead but I guess that is not too bad.

>All the better to keep userspace callbacks for security out of my
>kernels, for that way is ripe for problems (for specific examples why,
>see the linux-security-module mailing list archives.)

Oh, sure. There are problems. I don't deny that. But I am not too sure that 
those problems outweigh the problems created by putting in huge amounts of 
code into the kernel which could live outside it just as well. - IMHO the 
kernel should be as small as possible rather than contain everything under 
the sun just because it's easier to do that way...

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

