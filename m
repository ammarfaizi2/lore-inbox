Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313653AbSDJWtO>; Wed, 10 Apr 2002 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313919AbSDJWtN>; Wed, 10 Apr 2002 18:49:13 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59523 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313653AbSDJWtN>; Wed, 10 Apr 2002 18:49:13 -0400
Date: Wed, 10 Apr 2002 16:49:06 -0600
Message-Id: <200204102249.g3AMn6u02921@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <20020410220939.GF23513@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk writes:
> On Wed, Apr 10, 2002 at 03:39:09PM -0600, Richard Gooch wrote:
> > Mike Fedyk writes:
> > > On Wed, Apr 10, 2002 at 02:37:48PM -0600, Richard Gooch wrote:
> > > > 
> > > > The device is set up (i.e. SCSI host driver is loaded) long before I
> > > > do raidstart /dev/md/0
> > > 
> > > But kernel auto-detection doesn't depend on the raidstart command.  If
> > > things are setup correctly, you can remove that from your init scripts.
> > 
> > I'm not (explicitely) using auto-detection. When I insmod the raid0
> > module, there are no messages about finding devices. All I get is:
> > md: raid0 personality registered as nr 2
> > 
> > Only when I run raidstart do I get kernel messages about the devices.
> > 
> > In any case, I should be able to move my devices around (especially
> > if /etc/raidtab is still correct), whether or not autostart is
> > running. The behaviour I'm observing is a bug (I assume it's not a
> > mis-feature, since the raidstart man page tells me that moving devices
> > around should be safe).
> 
> Ehh, I ran into this a while ago.  When you compile raid as modules
> it doesn't use the raid superblocks for anything except for
> verification.  I took a quick glance at the source and the
> auto-detect code is ifdefed out if you compiled as a module.

Exactly where is this? A scan with find and grep don't reveal this.

> Ever since I have had raid compiled into my kernels.

This is my relevant .config:
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
