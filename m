Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269411AbRHCPba>; Fri, 3 Aug 2001 11:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269408AbRHCPbL>; Fri, 3 Aug 2001 11:31:11 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:42624 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269407AbRHCPbF>; Fri, 3 Aug 2001 11:31:05 -0400
Date: Fri, 3 Aug 2001 09:30:42 -0600
Message-Id: <200108031530.f73FUg505310@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: dcinege@psychosis.com, linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: md.c - devfs naming fix.
In-Reply-To: <15210.19054.503792.982041@notabene.cse.unsw.edu.au>
In-Reply-To: <3B1AF531.C31CB45C@psychosis.com>
	<200107312139.f6VLdRp00491@mobilix.ras.ucalgary.ca>
	<15210.19054.503792.982041@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> On Tuesday July 31, rgooch@ras.ucalgary.ca wrote:
> > Dave Cinege writes:
> > > This is a multi-part message in MIME format.
> > 
> > Yuk! MIME!
> > 
> > > Changes:
> > > 	Cleaned a few printk's
> > > 
> > > 	Removed a meaningless ifndef.
> > > 
> > > 	Moved md= name_to_ kdev_t() processing from md_setup() to
> > > 	md_setup_drive. Rewrote it and added devfs_find_handle() call
> > > 	to support devfs names for md=. 
> > > 
> > > The devfs_find_handle() code is now redundant in my patch and
> > > fs/super.c::mount_root(). It probably should be moved directly into
> > > name_to_kdev_t(), no? If this was done the md= code would have
> > > worked as is, except for the devfs code choking on the trailing ','
> > > in the device_names list. (Richard, want to check for this in the
> > > future?)
> > 
> > What is this patch trying to fix? I've been running devfs with MD
> > devices for a long time and have no problems. My raidtab lists devfs
> > device names (in fact, the /dev/sd/* variants created by devfsd) and
> > it seems to work fine.
> 
> You can start a raid array at boot time with a boot parameter like:
> 
>   md=0,/dev/somedisc,/dev/otherdisc,/dev/thatoneoverthere
> 
> However, this only worked for device names that were hard coded into
> init/main.c.  Devices which only had names in devfs couldn't be
> recognised.

Ah, OK. I suspected it was something to do with RAID autostart. OK,
makes sense.

> > Have you received any other comments? I've not tracked this.
> 
> The patch is already in Linus' tree.

Great.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
