Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCXMwa>; Sun, 24 Mar 2002 07:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292385AbSCXMwU>; Sun, 24 Mar 2002 07:52:20 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:34713 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291531AbSCXMwF>; Sun, 24 Mar 2002 07:52:05 -0500
Message-Id: <5.1.0.14.2.20020324124410.02927620@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 24 Mar 2002 12:52:53 +0000
To: Pavel Machek <pavel@suse.cz>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: Stevie O <stevie@qrpff.net>, Pavel Machek <pavel@suse.cz>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20020324112418.GA15934@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:24 24/03/02, Pavel Machek wrote:
>Hi!
>
> > >> I disagree, and here's the main reasons:
> > >>
> > >> * fadvise(2) usefulness extends past open(2).  It may be useful to call
> > >> it at various points during runtime.
> > >
> > >open(/proc/self/fd/0, O_NEW_FLAGS)?
> >
> > So to use fadvise(), the system must have /proc mounted?
>
>I think it is way more feasible than adding new syscall.

Sorry but it is silly. (-; What's wrong with open("filename", O_FLAGS); 
followed by fcntl(); if you want to modify them after opening. That is a 
lot cleaner than going via proc in such a way...

posix_fadvise() can then be implemented in userspace and that can go via 
fcntl(). That way we have the best of both worlds.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

