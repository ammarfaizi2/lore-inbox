Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSBYQrd>; Mon, 25 Feb 2002 11:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291962AbSBYQrZ>; Mon, 25 Feb 2002 11:47:25 -0500
Received: from loisexc2.loislaw.com ([12.5.234.240]:6150 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S293432AbSBYQqr>; Mon, 25 Feb 2002 11:46:47 -0500
Message-ID: <4188788C3E1BD411AA60009027E92DFD063077C4@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: "'Andreas Dilger'" <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: RE: ext3 and undeletion
Date: Mon, 25 Feb 2002 10:46:42 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there work being done on a filesystem extension that allows admins to
'undelete' files similar to the way Netware does? My company uses Netware
only for that fact, and I would like to see more Linux boxes here. I have
sold them on a couple of webservers and one application server, but they
hold fast to the Netware file servers because loading a backup copy of some
file from tape is not feasable with the amount of data we have (approaching
1T). I have looked across the web and only found this:
http://www.timpanogas.com/
but I don't want a Netware filesystem running on Linux, I want a *native*
Linux filesystem (i.e. ext3) that has the ability to queue deleted files
should I configure it to. Is there such a thing? If not, do you feel it
would be worth developing into the kernel? This would make Linux much more
attractive to Netware houses I believe.

Billy Rose

-----Original Message-----
From: Andreas Dilger [mailto:adilger@turbolabs.com]
Sent: Sunday, February 24, 2002 11:08 PM
To: Steven Walter; linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion


On Feb 24, 2002  21:27 -0600, Steven Walter wrote:
> After unintentionally deleting some file, I noticed what appears to be
> an incosistency (or at least a change) in ext3.  Running debugfs and
> executing the command "lsdel", I saw no inodes listed since I last ran
> the partition as ext2.  Does ext3 not add its deleted inodes to whatever
> list ext2 does?  And can this be fixed without compromising the speed or
> data-integrity of ext3?

Known problem.  Apparently difficult to fix, unfortunately.  It's not so
much that ext2 adds deleted inodes to a list, as that it simply marks the
inode "deleted" and doesn't overwrite any of the inode data on the disk.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
