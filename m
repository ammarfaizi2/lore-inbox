Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270330AbUIJVxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270330AbUIJVxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbUIJVxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:53:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:31662 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270214AbUIJVxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:53:14 -0400
Date: Fri, 10 Sep 2004 14:52:44 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 031 release
Message-ID: <20040910215244.GA23734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 031 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-031.tar.gz

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

This release fixes a lot of little bugs since the 030 release.  I might
have missed a few patches that were sent to me, and if you don't see
your patch/fix included in here, please resend it.

Major changes since 030:
 	- lots of minor bugfixes
	- udevstart is now a symlink to udev
	- added a new %e modifier
	- lots of rule fixes and cleanups based on user reports.
Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

 Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v030 to v031
============================================

<arun:codemovers.org>:
  o udev - read long lines from config files overflow fix

<ballarin.marc:gmx.de>:
  o Update the FAQ with info about hardlink security

<david:fubar.dk>:
  o compatibility symlinks for udev

David Weinehall:
  o Minor POSIX-fixes for udev

Greg Kroah-Hartman:
  o add symlink for video rule
  o add a "first" list to udevstart and make it contain the class/mem/ devices
  o fix compiler warning in udevtest.c
  o Fix old-style pty breakage in rules file for tty device
  o add rules for i386 cpu devices
  o add permission for legotower usb devices

Kay Sievers:
  o Fix naming ethernet devices in udevstart
  o update udev_volume_id
  o let /sbin/hotplug execute udev earlier
  o pass SEQNUM trough udevd
  o fix manpages based on esr's spambot

Martin Schlemmer:
  o add microcode rule to permissions.gentoo file

Michael Buesch:
  o Try to provide a bit of security for hardlinks to /dev entries

Olaf Hering:
  o udevsend depends on udev_lib.o

Tom Rini:
  o fix UDEV_NO_SLEEP
  o clean up start_udev a bit
  o Make udev/udevstart be one binary
  o Add 'asmlinkage' to udev-030

