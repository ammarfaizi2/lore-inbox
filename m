Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUCCAKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCCAKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:10:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:50062 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261794AbUCCAJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:09:59 -0500
Date: Tue, 2 Mar 2004 16:09:57 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 021 release
Message-ID: <20040303000957.GA11755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 021 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz

(Yes, there was no 020 release announcement, that tarball had a number
of build issues that prevented rpms from being generated, hence the need
for a 021 release.  A certain new Ximian/SuSE/Novell employee owes me
some beer now that he broke the build and I had to fix it...)

rpms built against Red Hat FC2-test1 are available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-021-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-021-1.src.rpm

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs


I think udev is pretty much mature now.  The TODO list is pretty much
empty, and I've integrated in all of the assorted patches that the
different distros were using.  If there's anything missing from udev, or
any patches that I've missed, please let me and the people at the
linux-hotplug-devel mailing list know about it.


Major changes from the 019 version:
	- new variable $local for the udev.permission file allows
	  permissions to be set for the currently logged in user.
	- new binary, udevstart, to help out people with distros that
	  needed the udev_start program to have a few /dev entries be
	  created before it could run.
	- new udevinfo functionality (can handle the symlinks correctly
	  now.)
	- number of other small fixes.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v020 to v021
============================================

Kay Sievers:
  o install udevinfo in /usr/bin
  o blacklist pcmcia_socket

Greg Kroah-Hartman:
  o fix udev.spec to find udevinfo now that it has moved to /usr/bin
  o Fix another problem with Makefile installing initscript
  o fix the Makefile to install the init script into the proper directory
  o make spec file turn off selinux support by default
  o 020 release TAG: v020


Summary of changes from v019 to v020
============================================

<christophe.varoqui:free.fr>:
  o multipath update

Kay Sievers:
  o man page udevstart
  o cleanup udevstart
  o bugfix for local user
  o unlink bugfix
  o TODO update
  o clarify udevinfo device walk
  o udevinfo symlink reverse query
  o fix stroul endptr use
  o add $local user spport for permissions
  o udev - man page update
  o udev - fix debug info for multiple rule file config
  o udev - kill udevd on install
  o udev - activate formt length attribute
  o udev - safer sprintf() use

<md:linux.it>:
  o no error on enoent
  o escape dashes in man pages
  o remove usage of expr in ide-devfs.sh

<rml:ximian.com>:
  o automatically install correct initscript
  o update documetation for $local

Andrey Borzenkov:
  o Add symlink only rules support

Greg Kroah-Hartman:
  o update the TODO list as we already have a devfs config file
  o make start_udev use udevstart binary
  o install udevstart
  o Remove Debian permission files as the Debian maintainer doesn't seem to want to share :(
  o update the Gentoo rules files
  o Add Red Hat rules and permissions files
  o add udevstart to the ignore list
  o add udevstart program based on a old patch from Harald Hoyer <harald@redhat.com>
  o unlink the file before we try to create it
  o Merge greg@bucket:/home/greg/src/udev into kroah.com:/home/greg/src/udev
  o 019_bk mark
  o 018 release TAG: v019

