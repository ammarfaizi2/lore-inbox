Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbUB1BXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbUB1BXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:23:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:16577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263234AbUB1BXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:23:04 -0500
Date: Fri, 27 Feb 2004 17:22:27 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 019 release
Message-ID: <20040228012227.GA14082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 019 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-019.tar.gz

rpms built against Red Hat FC2-test1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-019-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-019-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


Major changes from the 018 version:
	- hopefully all string handling is now correct, and audited for
	  any possible overflows.
	- user and group names now work properly if you build with klibc
	- initial SELinux support.
	- lots of small fixes (including build fixes)
	- update to scsi_id program

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h

Summary of changes from v018 to v019
============================================

Kay Sievers:
  o TODO update
  o udev - correct relative symlink
  o udev - safer string handling - part four
  o udev - safer string handling - part three
  o udev - safer string handling - part two
  o udev - man page update
  o udev - safer string handling all over the place
  o manpage update
  o udev - allow all files in a directory as the config
  o udev - simple klibc textual uid/gid handling

Andrey Borzenkov:
  o do not remove real .udev.tdb during RPM build

Greg Kroah-Hartman:
  o add new TODO item about local user permissions
  o Add initial SELinux support for udev
  o fix build for very old versions of make
  o remove limit of the number of args passed to PROGRAM
  o force udev to include the internal version of libsysfs and never the external one
  o fix up libsysfs header file usage to fix bug reports from users that have sysfsutils installed already
  o remove udevtest on 'make clean'
  o remove udevd priority TODO item, as it's not needed at all

Patrick Mansfield:
  o update udev scsi_id to scsi_id 0.4

