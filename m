Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266343AbUAVSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUAVSP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:15:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:56502 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266343AbUAVSPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:15:49 -0500
Date: Thu, 22 Jan 2004 10:15:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 014 release
Message-ID: <20040122181550.GA14725@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 014 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-014.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-014-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-014-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

Major changes from the 013 version:
	- speed!  This version is _much_ faster than the 013 release.
	  Thanks to Ananth Narayan for the libsysfs changes (and udev
	  patch) that enabled this.
	- there's a new program called udevinfo in the extras/ directory
	  that helps in determining the sysfs information for a specific
	  device.  This is useful in writing new udev rules.
	- the %D modifier is now gone.  People who were using it to
	  provide a devfs naming scheme will need to rewrite their rules
	  (look at the examples on the linux-hotplug-devel mailing list
	  for more details.)
	- lots of little changes and bug fixes.

Thanks again to everyone who has send me patches for this release, a
full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v013 to v014
============================================

<ananthmg:rediffmail.com>:
  o libsysfs update for refresh + namedev.c changes

<christophe.varoqui:free.fr>:
  o udev-013/extras/multipath update

<flamingice:sourmilk.net>:
  o minor patch for devfs rules

Kay Sievers:
  o udev - program to query all device attributes to build a rule
  o set default owner/group in db - update
  o udev - reverse user query options
  o udev - kill %D from udev-test.pl
  o add udev logging to info log
  o udev - mention format string escape char in man page

Greg Kroah-Hartman:
  o misc code cleanups
  o fixup logging.h to handle different logging options properly
  o clean up the logging patch a bit to make the option more like the other options
  o remove the %D modifier as it is not longer needed
  o remove unneeded keyboard rule
  o add usb_host and pci_bus to the class blacklist
  o added input device rules to udev.rules and udev.rules.devfs

Hanna V. Linder:
  o set default owner/group in db
  o small cut n paste error fix

Patrick Mansfield:
  o update udev scsi_id to scsi_id 0.3

