Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313654AbSDJTjm>; Wed, 10 Apr 2002 15:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313657AbSDJTjl>; Wed, 10 Apr 2002 15:39:41 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:57336 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313654AbSDJTjk>; Wed, 10 Apr 2002 15:39:40 -0400
Date: Wed, 10 Apr 2002 13:38:12 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
Message-ID: <20020410193812.GE3509@turbolinux.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca> <20020410184010.GC3509@turbolinux.com> <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2002  13:24 -0600, Richard Gooch wrote:
> Andreas Dilger writes:
> > On Apr 10, 2002  09:33 -0600, Richard Gooch wrote:
> > > Even though I'm using persistent superblockss, which is supposed to
> > > allow one to move devices from one controller to another, I can't
> > > use my RAID) set in this configuration. Looks like a bug.
> > > 
> > > md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable,
> > >      removing from array!
> > > md: md0, array needs 6 disks, has 5, aborting.
> > 
> > Note that this appears to be your real problem.
> 
> No. I tested all 6 partitions used in the RAID set. They are all
> available.

Well, MD seems to think it is unavailable...  I would check the codepath
that generates this message and see why it is happening.  Maybe it is a
timing issue or something, that MD autostart is starting before this
device is set up or something?  I don't know.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

