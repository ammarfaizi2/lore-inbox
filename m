Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131047AbQLVAGa>; Thu, 21 Dec 2000 19:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbQLVAGU>; Thu, 21 Dec 2000 19:06:20 -0500
Received: from ccs.covici.com ([209.249.181.196]:30980 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S131047AbQLVAGF>;
	Thu, 21 Dec 2000 19:06:05 -0500
Date: Thu, 21 Dec 2000 18:35:30 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: strange nfs behavior in 2.2.18 and 2.4.0-test12
In-Reply-To: <14914.36970.774601.96539@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0012211828510.840-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is my /etc/exports

/ ccs2(rw,no_root_squash)
/usr ccs2(rw,no_root_squash)
/usr/src ccs2(rw,no_root_squash)
/home ccs2(rw,no_root_squash)
/hard1 ccs2(rw,no_root_squash)
/hard2 ccs2(rw,no_root_squash)
/hard3 ccs2(rw,no_root_squash)
/hard4 ccs2(rw,no_root_squash)
/usr/bbs ccs2(rw,no_root_squash)
#


Here is the fstab file.

# /etc/fstab: static file system information.
#
# <file system>	<mount point>	<type>	<options>			<dump>	<pass>
/dev/hda2	/		ext2	defaults,errors=remount-ro	1	1
/dev/hdc2	none		swap	sw			0	0
/dev/hdc4	none		swap	sw			0	0
/dev/hdb7	none		swap	sw			0	0
proc		/proc		proc	defaults			0	0
/dev/fd0	/floppy		auto	defaults,user,noauto		0	0
/dev/cdrom	/cdrom		iso9660	defaults,ro,user,noauto		0	0
/dev/hdc3 /usr ext2 rw			1	2
/dev/hdb6 /usr/bbs ext2 rw			1	2

/dev/hda3 /usr/src ext2 rw			1	2
/dev/hda4 /home ext2 rw			1	3

and here are mounts executed out of /etc/rc.local

mount -t vfat /dev/hdb1 /hard2
mount -t vfat /dev/hdb5 /hard4
mount -t vfat /dev/hdc1 /hard3
mount -t vfat /dev/hda1 /hard1



On Fri, 22 Dec 2000, Neil Brown wrote:

> On Thursday December 21, covici@ccs.covici.com wrote:
> > On Fri, 22 Dec 2000, Neil Brown wrote:
> > 
> > > On Thursday December 21, covici@ccs.covici.com wrote:
> > > > Hi.  I am having strange nfs problems in both my 2.x and 2.4.0-test12
> > > > kernels.
> > > > 
> > > > What is happening is that when the machine boots up and exports the
> > > > directories for nfs, it complains that
> > > > 
> > > > ccs2:/ invalid argument .
> > > > 
> > > > The exports entry is
> > > > 
> > > > / ccs2(rw,no_root_squash)
> > > 
> > > Is there another export entry that exports another part of the same
> > > file system to the same client?  If so, that is your problem.
> > 
> > Well I do want to export the mount points under the file system, for
> > instance I have a partition mounted as /usr and so I have an entry
> > such as
> > /usr ccs2(rw,no_root_squash)
> > 
> > in my exports list.  Is there any other way to get this behaviour to
> > work?
> 
> Sounds like what you are doing is OK.
> If you could send complete /etc/fstab and /etc/exports, that might
> help to isolate the problem.
> 
> NeilBrown
> 

-- 
         John Covici
         covici@ccs.covici.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
