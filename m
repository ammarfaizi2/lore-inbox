Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280959AbRKGUhK>; Wed, 7 Nov 2001 15:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKGUhC>; Wed, 7 Nov 2001 15:37:02 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:56197 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280959AbRKGUgx>; Wed, 7 Nov 2001 15:36:53 -0500
Message-Id: <5.1.0.14.2.20011107203345.02af5378@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 07 Nov 2001 20:36:43 +0000
To: Andreas Dilger <adilger@turbolabs.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ext3 vs resiserfs vs xfs
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011107132552.J5922@lynx.no>
In-Reply-To: <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
 <E161Y87-00052r-00@the-village.bc.nu>
 <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:25 07/11/2001, Andreas Dilger wrote:
>On Nov 07, 2001  19:40 +0000, Anton Altaparmakov wrote:
> > Yes, that makes a lot of sense. After the reset I went into my own kernel
> > with both ext2 and ext3 compiled into it. However, before the reboot, I 
> was
> > still in the RH kernel (99% sure it was so, but my memory might be
> > deceiving me).
> >
> > Is there any Right Way(TM) to fix this situation considering I want to 
> have
> > both ext2 and ext3 in my kernels (apart from the obvious of changing the
> > order fs are called during root mount in the kernel)?
>
>If both ext2 and ext3 are compiled into the kernel, then ext3 will try first
>to mount the root fs.  If there is no journal on this fs (check this with
>tune2fs -l <dev>, and look for "has_journal" feature), then it will be
>mounted as ext2.  If you are doing strange things with initrd and modules,
>then there is more chance to have problems.

Will check. Thanks for info.

>I don't know why you would want to go back to ext2 if you have ext3 in your
>kernel, but if so, there is a patch to add a "rootfstype" parameter which
>allows you to select the fstype to try and mount your root fs as.  It looks
>like it is in Linus' 2.4.13 kernel at least (don't know when it went in).

Well one good reason is I don't trust ext3 because it is new and I haven't 
used it before. (You can call me paranoid all you want...) Before I start 
trusting it with my really important data, I would rather use ext3 for a 
while on /, /usr and other non-important partitions (they can be 
reinstalled, /home cannot...)

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

