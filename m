Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313500AbSDJSlk>; Wed, 10 Apr 2002 14:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313504AbSDJSlj>; Wed, 10 Apr 2002 14:41:39 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:52472 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313500AbSDJSlj>; Wed, 10 Apr 2002 14:41:39 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 10 Apr 2002 12:40:10 -0600
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
Message-ID: <20020410184010.GC3509@turbolinux.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2002  09:33 -0600, Richard Gooch wrote:
> Even though I'm using persistent superblockss, which is supposed to
> allow one to move devices from one controller to another, I can't
> use my RAID) set in this configuration. Looks like a bug.
> 
> md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable, removing from array!
> md: md0, array needs 6 disks, has 5, aborting.

Note that this appears to be your real problem.

> Note the following line from the kernel logs above:
> md: can not import scsi/host6/bus0/target0/lun0/part2, has active inodes!
> 
> Well, that's no surprise, as this partition has /usr! And this
> partition isn't even mentioned in the /etc/raidtab file. But I note
> that it has the same device number in this (the broken) configuration
> as /dev/sd/c0b0t1u0p2 has in the working configuration.

That is a red herring, I think.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

