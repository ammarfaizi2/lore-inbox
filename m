Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269935AbUJNAkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbUJNAkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269938AbUJNAkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:40:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:49861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269935AbUJNAkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:40:06 -0400
Date: Wed, 13 Oct 2004 17:39:36 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 038 release
Message-ID: <20041014003936.GA8810@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 038 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-038.tar.gz

(yes, the last announcement was for 034, things have been moving
fast...)

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

More bugfixes, and hopefully the "udev is locked in a loop taking all of
the cpu" bug is now gone.  Also, lots of wait_for_sysfs updates thanks
to all who has reported them.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h

Summary of changes from v037 to v038
============================================

<andrew.patterson:hp.com>:
  o Re: Problem parsing %s in udev rules

Greg Kroah-Hartman:
  o fix up error in building extras and libsysfs

Summary of changes from v036 to v037
============================================

<md:linux.it>:
  o small udev patch

Greg Kroah-Hartman:
  o fix compilation warning in tdb log message
  o Fix build error with klibc due to recent changes
  o merge
  o add wait_for_sysfs test script to the tarball to help people debug their boxes
  o add ipsec to wait_for_sysfs ignore list
  o added ccdv to bk ignore list
  o a few more Makefile tweaks for the quiet feature
  o Make the build silent, thanks to a helper program from ncftp
  o rename files to have '_' instead of '-' in them
  o change max time to wait in wait_for_sysfs to 10 seconds to hopefully handle some slow machines
  o add support for class/raw/ to wait_for_sysfs
  o fix up Makefile for wait_for_sysfs udev_version.h dependancy
  o remove the debian specific file, as they don't want to share with the rest of the world :(

Kay Sievers:
  o prevent deadlocks on an corrupt udev database
  o wait_for_sysfs_update

Michael Buesch:
  o fix asmlinkage
  o fix incompatible pointer type warning

Summary of changes from v035 to v036
============================================

Greg Kroah-Hartman:
  o add the error number to the error message in wait_for_sysfs to help out in debugging problems

Summary of changes from v034 to v035
============================================

Greg Kroah-Hartman:
  o added ieee1394 support to wait_for_sysfs
  o update wait_for_sysfs with a bunch more devices thanks to user reports

