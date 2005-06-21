Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVFUPOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVFUPOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVFUPNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:13:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:39908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262100AbVFUPKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:10:34 -0400
Date: Tue, 21 Jun 2005 08:10:19 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050621151019.GA19666@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235403.45bf9613.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:54:03PM -0700, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> >  Just in time for a July release, here's a patch series that removes
> >  devfs from the kernel tree as promised.
> 
> Whimper.

Heh, you said you wanted me to merge my stuff before yours :)

> Maybe we should cook this in -mm for a bit, get a feeling for how many
> users hate us, and how much?

There might be some complaints.  But I doubt they would be from anyone
running a -mm tree as those people kind of know the current status of
things in the kernel.  There have been numerous warnings as to the fact
that this was going away, and I waited a _year_ to do this.

Also, no disto uses devfs only (gentoo is close, but offers users udev
and a static /dev also.)

> patches/areca-raid-linux-scsi-driver-fix.patch
> patches/areca-raid-linux-scsi-driver.patch

Shouldn't be hard

> patches/bk-ide-dev.patch
> patches/git-input.patch
> patches/git-mtd.patch
> patches/git-ocfs.patch

Merging will fix these

> patches/git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch

Sounds like you can drop this :)

> patches/gregkh-driver-class-02-tty.patch
> patches/gregkh-driver-class-03-input.patch
> patches/gregkh-driver-class-05-sound.patch
> patches/gregkh-driver-class-06-block.patch
> patches/gregkh-driver-class-07-char.patch
> patches/gregkh-driver-class-08-ieee1394.patch
> patches/gregkh-driver-class-09-scsi.patch
> patches/gregkh-driver-class-11-drivers.patch
> patches/gregkh-driver-class-12-the_rest.patch
> patches/gregkh-driver-ipmi-class_simple-fixes.patch
> patches/gregkh-i2c-i2c-config_cleanup-01.patch

I'll handle these

> patches/kdump-accessing-dump-file-in-linear-raw-format.patch

Should be easy.

> patches/linus.patch

Not relevant :)

> patches/md-add-interface-for-userspace-monitoring-of-events.patch
> patches/md-optimised-resync-using-bitmap-based-intent-logging.patch
> patches/post-halloween-doc.patch
> patches/st-warning-fix.patch

Again, shouldn't be that hard.

So there are probably 7 patches that need to get rediffed.  In your
normal merges, I can't see that being all that difficult :)

Or I can wait until you go next.  I didn't want these patches in the -mm
tree as they would have caused you too much work to keep up to date and
not conflict with anything else due to the size of them.

thanks,

greg k-h
