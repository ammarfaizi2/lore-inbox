Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSGYRpq>; Thu, 25 Jul 2002 13:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGYRpq>; Thu, 25 Jul 2002 13:45:46 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:18121 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316532AbSGYRpo>; Thu, 25 Jul 2002 13:45:44 -0400
Message-Id: <5.1.0.14.2.20020725181909.00b02c70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Jul 2002 18:39:32 +0100
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: RE: 2.5.28 and partitions
Cc: Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0207251245530.17621-100000@weyl.math.psu.edu
 >
References: <5.1.0.14.2.20020725133331.00aa69b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:50 25/07/02, Alexander Viro wrote:
>On Thu, 25 Jul 2002, Anton Altaparmakov wrote:
>
> > At 12:44 25/07/02, Alexander Viro wrote:
> > >Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> > >device should seek professional help of the kind they don't give on l-k...
> >
> > Why? What is wrong with large devices/file systems? Why do we have to 
> break
> > up everything into multiple devices? Just because the kernel is "too lazy"
> > to implement support for large devices? Nobody cares if 64bit code is
>
>Large filesystem => troubles with backups, even more troubles with restoring
>after disk failure, yadda, yadda.
>
> > database server and we can live with that. At least our applications deal
> > with GiBs of data for each experiment, which is shifted over Gigabit
> > ethernet to/from a SQL database backend stored on a huge RAID array, so we
> > are completely i/o bound.
> >
> > It's one database, and it's huge. And it's going to get bigger as 
> people do
> > more experiments. We need mkfs.<whatever> on a huge device... We are just
> > lucky that our current RAID array is under 2TiB se we haven't hit the
> > "magic" barrier quite yet. But at 1.4TiB we are not far off...
>
>... and backups of your database are done on...?

UTO Ultrium attached via SCSI to the file server. Or they will be once we 
get Arcserve for Linux with support for the Ultrium which should hopefully 
be in the near future...

>"RAID" doesn't mean that data is safe.  It means that some class of
>failures will not be immediately catastrophic, but that's it - both
>hardware and software arrays _do_ go tits up.  Just ask hpa for story
>of the troubles on kernel.org.

Indeed. Hence the Ultrium tape based backup...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

