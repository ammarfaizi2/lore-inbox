Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313573AbSDJVel>; Wed, 10 Apr 2002 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313856AbSDJVek>; Wed, 10 Apr 2002 17:34:40 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14329
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313573AbSDJVek>; Wed, 10 Apr 2002 17:34:40 -0400
Date: Wed, 10 Apr 2002 14:36:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
Message-ID: <20020410213645.GE23513@matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca> <20020410184010.GC3509@turbolinux.com> <200204101924.g3AJOp113305@vindaloo.ras.ucalgary.ca> <20020410193812.GE3509@turbolinux.com> <200204102037.g3AKbmT14222@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 02:37:48PM -0600, Richard Gooch wrote:
> Andreas Dilger writes:
> > On Apr 10, 2002  13:24 -0600, Richard Gooch wrote:
> > > Andreas Dilger writes:
> > > > On Apr 10, 2002  09:33 -0600, Richard Gooch wrote:
> > > > > Even though I'm using persistent superblockss, which is supposed to
> > > > > allow one to move devices from one controller to another, I can't
> > > > > use my RAID) set in this configuration. Looks like a bug.
> > > > > 
> > > > > md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable,
> > > > >      removing from array!
> > > > > md: md0, array needs 6 disks, has 5, aborting.
> > > > 
> > > > Note that this appears to be your real problem.
> > > 
> > > No. I tested all 6 partitions used in the RAID set. They are all
> > > available.
> > 
> > Well, MD seems to think it is unavailable...  I would check the
> > codepath that generates this message and see why it is happening.
> > Maybe it is a timing issue or something, that MD autostart is
> > starting before this device is set up or something?  I don't know.
> 
> The device is set up (i.e. SCSI host driver is loaded) long before I
> do raidstart /dev/md/0

But kernel auto-detection doesn't depend on the raidstart command.  If
things are setup correctly, you can remove that from your init scripts.
