Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTLaWVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbTLaWVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:21:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:15563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265266AbTLaWVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:21:13 -0500
Date: Wed, 31 Dec 2003 14:07:56 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 012 release
Message-ID: <20031231220755.GA3828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 012 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-012.tar.gz

rpms built against Red Hat FC1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-012-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-012-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

The major changes since the 011 release are:
	- updated ide devfs compatible script
	- command line options are now available, allowing you to query
	  the udev database.  This is just a first cut, the query
	  functionality will be extended later.
	- lots of minor bug fixes and tweaks.

Thanks again to everyone who has send me patches for this release, a
full list of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of this tree used to be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
But that box seems to be down now.  Hopefully it will be restored
someday.  If anyone ever wants a tarball of the current bk tree, just
email me.

thanks,

greg k-h


Summary of changes from v011 to v012
============================================

<azarah:nosferatu.za.org>:
  o make symlink work properly if there is already a file in its place
  o Fix udev gcc-2.95.4 compat

<christophe.varoqui:free.fr>:
  o extras multipath update
  o extras multipath update

Kay Sievers:
  o mention user callable udev + options in man page
  o make udev user callable to query the database
  o depend on all .h files
  o cleanup namedev_parse debug text
  o extend exec_program[]
  o ide-devfs.sh update
  o fix for apply_format()
  o check for empty symlink string
  o 'ide' missing in bus_files[]
  o small trivial cleanup of latest changes

<mbuesch:freenet.de>:
  o introduce signal handler

<rml:ximian.com>:
  o udev spec file update

Greg Kroah-Hartman:
  o minor grammer fixes for the udev_vs_devfs document
  o move the dbus config file to etc/dbus-1/system.d/
  o move the config files to etc/udev to clean up main directory a bit
  o add Gentoo versions of the rules and permissions files
  o if using glibc, link dynamically, as no one like 500Kb udev binaries
  o minor change to udev_vs_devfs document
  o added udev vs devfs supid document to the tree
  o move the signal handling registration to after we have initialized enough stuff
  o make ide-devfs.sh executable in the tree
  o udev.permissions.debian - forgot the dm nodes
  o update the udev.permissions.debian file with new entries
  o added udev.init script for the Linux From Scratch project

