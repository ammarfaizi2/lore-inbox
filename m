Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRGaX30>; Tue, 31 Jul 2001 19:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269537AbRGaX3R>; Tue, 31 Jul 2001 19:29:17 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:7940 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269538AbRGaX3K>; Tue, 31 Jul 2001 19:29:10 -0400
Date: Tue, 31 Jul 2001 15:39:27 -0600
Message-Id: <200107312139.f6VLdRp00491@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: dcinege@psychosis.com
Cc: linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: md.c - devfs naming fix.
In-Reply-To: <3B1AF531.C31CB45C@psychosis.com>
In-Reply-To: <3B1AF531.C31CB45C@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dave Cinege writes:
> This is a multi-part message in MIME format.

Yuk! MIME!

> Changes:
> 	Cleaned a few printk's
> 
> 	Removed a meaningless ifndef.
> 
> 	Moved md= name_to_ kdev_t() processing from md_setup() to
> 	md_setup_drive. Rewrote it and added devfs_find_handle() call
> 	to support devfs names for md=. 
> 
> The devfs_find_handle() code is now redundant in my patch and
> fs/super.c::mount_root(). It probably should be moved directly into
> name_to_kdev_t(), no? If this was done the md= code would have
> worked as is, except for the devfs code choking on the trailing ','
> in the device_names list. (Richard, want to check for this in the
> future?)

What is this patch trying to fix? I've been running devfs with MD
devices for a long time and have no problems. My raidtab lists devfs
device names (in fact, the /dev/sd/* variants created by devfsd) and
it seems to work fine.

> This diff is against md.c in 2.4.4.
> Comments/testing please.

Have you received any other comments? I've not tracked this.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
