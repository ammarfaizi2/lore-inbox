Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVIORuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVIORuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVIORuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:50:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:7619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932097AbVIORuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:50:15 -0400
Date: Thu, 15 Sep 2005 10:49:55 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: kay.sievers@vrfy.org
Subject: [ANNOUNCE] udev 070 release and change of maintainer
Message-ID: <20050915174954.GA10361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released the 070 version of udev.  It can be found at:
  	kernel.org/pub/linux/utils/kernel/hotplug/udev-070.tar.gz

udev allows users to have a dynamic /dev and provides the ability to
have persistent device names.  It uses sysfs and /sbin/hotplug and runs
entirely in userspace.  It requires a 2.6 kernel with CONFIG_HOTPLUG
enabled to run.  Please see the udev FAQ (now updated!) for any
questions about it:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ

For any udev vs devfs questions anyone might have, please see:
	kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

And there is a general udev web page at:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

This release fixes a few small bugs found in the 069 release, and marks
the change of the maintainer of udev from me to Kay Sievers
<kay.sievers@vrfy.org>.  Kay has been instrumental in getting udev as
feature complete and stable and actually working well.  Without his
help, it wouldn't be the program it is today.  He also was the one who
implemented the persistant naming policy for disks, which is now in all
of the major Linux distributions (and a few minor ones.)

I'll still be around and doing minor work on udev, but Kay is the one
who is now in charge, and I know it is in good hands.

thanks,

greg k-h

Summary of changes from v069 to v070
============================================

Amir Shalem:
  udevd: fix udevd read() calls to leave room for null byte

Edward Goggin:
  scsi_id: derive a UID for a SCSI-2 not compliant with the page 83

Greg Kroah-Hartman:
  fix nbd error messages with a gentoo rule hack
  fix scsi_id rule in gentoo config file

Jürg Billeter:
  EXTRAS/Makefile: fix install targets to match main Makefile

Kay Sievers:
  volume_id: fix error handling with failing read()
  EXTRAS: cleanup and sync all Makefiles
  add install test to 'make buildtest'
  update RELEASE-NOTES

Olivier Blin:
  fix a debug text typo in udev_rules.c
