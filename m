Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131524AbRBUDuV>; Tue, 20 Feb 2001 22:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131522AbRBUDuM>; Tue, 20 Feb 2001 22:50:12 -0500
Received: from p5.usnyc1.stsn.com ([199.106.216.5]:1541 "EHLO
	nychoteldns01.stsn.com") by vger.kernel.org with ESMTP
	id <S131501AbRBUDt6>; Tue, 20 Feb 2001 22:49:58 -0500
Date: Wed, 21 Feb 2001 14:49:17 +1100
Message-Id: <200102210349.f1L3nHE03110@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux LVM Development list <lvm-devel@sistina.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
In-Reply-To: <20010221021252.A932@athlon.random>
In-Reply-To: <20010220234219.B2023@athlon.random>
	<200102210031.f1L0VQU15564@webber.adilger.net>
	<20010221021252.A932@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> On Tue, Feb 20, 2001 at 05:31:25PM -0700, Andreas Dilger wrote:
> > The reason why the IOP was changed was because the VG_CREATE ioctl now
> > depends on the vg_number in the supplied vg_t to determine which VG minor
> > number to use.  The old interface used the minor number of the opened
> > device inode, but for devfs the device inodes don't exist until the VG
> > is created...  If you run an older kernel with new tools, you can only
> > use the first VG.
> 
> Ah, I was reading the patch incidentally against 2.2 patch where devfs support
> is not included, so I wasn't thinking the devfs way ;). Thanks for the
> explanation.
> 
> I assume it's not possible to mknod on top of devfs.  So then we
> could use a temporary device in /var/tmp or whatever for that.
> However those workarounds tends to be ugly.

You definately can mknod(2) on devfs.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
