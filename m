Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTJUQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJUQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:34:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:16314 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263184AbTJUQeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:34:23 -0400
Date: Tue, 21 Oct 2003 09:28:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 004 release
Message-ID: <20031021162856.GA1030@kroah.com>
Reply-To: linux-hotplug-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've released the 004 version of udev.  It can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-004.tar.gz

Thanks to Robert Love, there are now rpms available at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-004-1.i386.rpm
with the source rpm at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-004-1.src.rpm

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run properly.

The major changes since the 003 release are:
	- MAJOR speedups over the previous version.  No more "sleep(1)"
	  always, we now wait for the "dev" file to show up, and not
	  blindly guess.
	- partitions now work again.
	- removal of devices that were named differently from the kernel
	  name work properly.
	- proper spec file.
	- a man page with real content.
	- sync up with current version of libsysfs.

Many thanks to Dan Stekloff, Kay Sievers, and Robert Love for their help
with patches for this release.  I really appreciate it.

The full ChangeLog can be found below.
 
The udev FAQ can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ
 
Development of udev is done in a BitKeeper tree available at:
	bk://kernel.bkbits.net/gregkh/udev/

If anyone ever wants a snapshot of the current tree, due to not using
BitKeeper, or other reasons, is always available at any time by asking.

thanks,

greg k-h


Summary of changes from v003 to v004
============================================


Daniel E. F. Stekloff:
  o new version of libsysfs patch

Greg Kroah-Hartman:
  o 004 release
  o major database cleanups
  o Changed test.block and test.tty to take ACTION from the command line
  o don't sleep if 'dev' file is already present on device add
  o fix comment about how the "dev" file is made up
  o more database work.  Now we only store the info we really need right now
  o add BUS= bug to TODO list so it will not get forgotten
  o spec file changes
  o test.block changes
  o ok, rpm likes the "_" character instead of "-" better
  o change the version to 003-bk to keep things sane with people using the bk tree
  o got "remove of named devices" working
  o fix segfaults when dealing with partitions

Kay Sievers:
  o man file update
  o man page update

Robert Love:
  o udev: mode should be mode_t
  o udev: trivial trivialities
  o udev: cool test scripts again
  o udev spec file symlink support
  o udev: cool test scripts
  o udev spec file bits

