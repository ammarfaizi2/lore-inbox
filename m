Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUJOWUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUJOWUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJOWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:20:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:4062 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263778AbUJOWUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:20:11 -0400
Date: Fri, 15 Oct 2004 15:19:34 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 039 release
Message-ID: <20041015221934.GA27685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 039 version of udev.  It can be found at:
 	kernel.org/pub/linux/utils/kernel/hotplug/udev-039.tar.gz

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ for any questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

This release fixes a few major bugs:
	- the config file and manpage are now properly generated
	- wait_for_sysfs is updated for lots of new devices
	- firmware downloading should now work properly, sorry about
	  that, udev shouldn't have stopped that from happening...
	- scsi_id bug fix update.

Thanks to everyone who has send me patches for this release, a full list
of everyone, and their changes is below.

udev development is done in a BitKeeper repository located at:
	bk://linuxusb.bkbits.net/udev

Daily snapshots of udev from the BitKeeper tree can be found at:
	http://www.codemonkey.org.uk/projects/bitkeeper/udev/
If anyone ever wants a tarball of the current bk tree, just email me.

thanks,

greg k-h


Summary of changes from v038 to v039
============================================

Greg Kroah-Hartman:
  o Hopefully fix the vcs issue in wait_for_sysfs
  o take out & from wait_for_sysfs_test that I previously missed
  o add very nice cdsymlinks scripts
  o add some helper scripts for dvb and input devices
  o add debian config files
  o let the extras/ programs build "pretty" also
  o tweak the ccdv program to handle files in subdirectories being built
  o crap, I messed up the 'sed' instances pretty badly, this fixes the config and man page mess
  o fix broken 'make -j5' functionality

Kay Sievers:
  o swich attribute open() to simple stat()
  o wait_for_sysfs update for /class/firmware and /class/net/irda devices
  o fix unusual sysfs behavior for pcmcia_socket
  o remove sleeps from udev as it is external now
  o delete udevruler?
  o Makefile fix

Patrick Mansfield:
  o update udev to scsi_id 0.7
  o pass SYSFS setting down for extras builds
  o move assignments past local variables


