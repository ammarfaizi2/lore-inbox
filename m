Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUBMBKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUBMBKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:10:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:61151 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266591AbUBMBKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:10:00 -0500
Date: Thu, 12 Feb 2004 17:10:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 017 release
Message-ID: <20040213011001.GA5247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 017 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-017.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-017-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-017-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Major changes from the 015 version:
	- lots of udevd and udevsend cleanups and tweaks.  udevd can now
	  be built with klibc, and doesn't need a lock file anymore to
	  work.
	- lots of bug fixes and other cleanups.
	- shrink the size of the database by a large amount.

In all, there is nothing major in this release, but any current users of
udev will want this version for all of the bugfixes if for nothing else.

Thanks a lot to Chris Friesen and Kay Sievers for cleaning up the udevd
and udevsend communication path and code so much.  I really appreciate
it.

Thanks also to everyone who has send me patches for this release, a full
list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v016 to v017
============================================

<azarah:nosferatu.za.org>:
  o make logging a config option

<christophe.varoqui:free.fr>:
  o more udev-016/extras/multipath
  o more udev-016/extras/multipath
  o update extras/multipath

Kay Sievers:
  o udev - keep private data out of the database?
  o better credential patch
  o udevd - client access authorization
  o compile udevd with klibc
  o udev - fix "ignore method"
  o udev - fix cdrom symlink rule
  o convert udevsend/udevd to DGRAM and single-threaded
  o udevd - kill the lockfile
  o udevd - fix socket path length
  o udevd - switch socket path to abstract namespace
  o udevd - allow to bypass sequence number
  o include used function

Greg Kroah-Hartman:
  o add udev_log to the documentation
  o fix offsetof() define in klibc
  o add some .spec file changes from Red Hat
  o update the init.d udev script based on a patch from Red Hat
  o remove the .udev.tdb when installing or uninstalling to be safe
  o remove the database at startup
  o fix bug in permission handling
  o update klibc to version .107
  o update the bitkeeper ignore file list
  o add udevtest program to build
  o fix problem where usb devices can be either the main device or the interface
  o more logging.h cleanups to be a bit more flexible
  o stop using mode_t as different libcs define it in different ways :(
  o remove some more KLIBC fixups that are no longer needed
  o let udev-test.pl run an individual test if you ask it to
  o Handle the '!' character that some block devices have
  o add a block device with a ! in the name, and a test for this
  o fix up 'make release' to use bk to build the export tree
  o fix log option code so that it actually works for all udev programs
  o finish syncing up with klibc
  o sync with latest version of klibc (0.107)
  o fix up Makefile dependancies for udev_version.h

Patrick Mansfield:
  o udev add wild card compare for ID
  o udev kill extra bus_id compares in match_id

