Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbREPQ0Y>; Wed, 16 May 2001 12:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbREPQ0O>; Wed, 16 May 2001 12:26:14 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:12293 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S261996AbREPQZ7>;
	Wed, 16 May 2001 12:25:59 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
From: Miles Lane <miles@megapathdsl.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B028063.67442F62@idb.hist.no>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
	<3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> 
	<3B028063.67442F62@idb.hist.no>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 16 May 2001 09:30:46 -0700
Message-Id: <990030651.932.3.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2001 15:28:03 +0200, Helge Hafting wrote:
> Oystein Viggen wrote:
> > 
> > Quoth Helge Hafting:
> > 
> > > This could be extended to non-raid use - i.e. use the "raid autodetect"
> > > partition type for non-raid as well.  The autodetect routine could
> > > then create /dev/partitions/home, /dev/partitions/usr or
> > > /dev/partitions/name_of_my_choice
> > > for autodetect partitions not participating in a RAID.
> > 
> > What happens if I insert a hard drive from another computer which also
> > has partitions named "home", "usr", and soforth?
> 
> This is the problem with all sorts of ID-based naming.  In this case
> the kernel could simply change the conflicting names a bit,
> and leave the cleanup to the administrator.  (Who probably
> is around as he just inserted those disks....)
> 
> The current scheme have problems if you move a disk
> from one controller to another, or in some cases
> if you merely add a new one.  So the question becomes - 
> what is most likely to go wrong?  And you can be
> smart and name your partitions /usr21042001, /home03042001
> and so on in order to minimize the risk of conflicts.

Well, a usermode solution might be to add support for having the
filesystem utilities generate and detect partition IDs.  Then the disks
could be moved from one controller to another, but mount could scan
partition IDs and associate mount points on matching IDs rather than on
/dev/hdX or /dev/sdX.

Or is this a ridiculous idea?

    Miles

