Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313606AbSDJTZT>; Wed, 10 Apr 2002 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313622AbSDJTZT>; Wed, 10 Apr 2002 15:25:19 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57218 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313606AbSDJTZR>; Wed, 10 Apr 2002 15:25:17 -0400
Date: Wed, 10 Apr 2002 13:24:51 -0600
Message-Id: <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <20020410184010.GC3509@turbolinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Apr 10, 2002  09:33 -0600, Richard Gooch wrote:
> > Even though I'm using persistent superblockss, which is supposed to
> > allow one to move devices from one controller to another, I can't
> > use my RAID) set in this configuration. Looks like a bug.
> > 
> > md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable, removing from array!
> > md: md0, array needs 6 disks, has 5, aborting.
> 
> Note that this appears to be your real problem.

No. I tested all 6 partitions used in the RAID set. They are all
available.

> > Note the following line from the kernel logs above:
> > md: can not import scsi/host6/bus0/target0/lun0/part2, has active inodes!
> > 
> > Well, that's no surprise, as this partition has /usr! And this
> > partition isn't even mentioned in the /etc/raidtab file. But I note
> > that it has the same device number in this (the broken) configuration
> > as /dev/sd/c0b0t1u0p2 has in the working configuration.
> 
> That is a red herring, I think.

Then what *is* the problem?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
