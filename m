Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313760AbSDJUh5>; Wed, 10 Apr 2002 16:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313805AbSDJUh4>; Wed, 10 Apr 2002 16:37:56 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4227 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313760AbSDJUhz>; Wed, 10 Apr 2002 16:37:55 -0400
Date: Wed, 10 Apr 2002 14:37:48 -0600
Message-Id: <200204102037.g3AKbmT14222@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <20020410193812.GE3509@turbolinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Apr 10, 2002  13:24 -0600, Richard Gooch wrote:
> > Andreas Dilger writes:
> > > On Apr 10, 2002  09:33 -0600, Richard Gooch wrote:
> > > > Even though I'm using persistent superblockss, which is supposed to
> > > > allow one to move devices from one controller to another, I can't
> > > > use my RAID) set in this configuration. Looks like a bug.
> > > > 
> > > > md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable,
> > > >      removing from array!
> > > > md: md0, array needs 6 disks, has 5, aborting.
> > > 
> > > Note that this appears to be your real problem.
> > 
> > No. I tested all 6 partitions used in the RAID set. They are all
> > available.
> 
> Well, MD seems to think it is unavailable...  I would check the
> codepath that generates this message and see why it is happening.
> Maybe it is a timing issue or something, that MD autostart is
> starting before this device is set up or something?  I don't know.

The device is set up (i.e. SCSI host driver is loaded) long before I
do raidstart /dev/md/0

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
