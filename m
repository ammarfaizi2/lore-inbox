Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbUKLW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUKLW7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKLW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:59:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16634 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262649AbUKLW7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:59:00 -0500
Date: Fri, 12 Nov 2004 14:58:51 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] More Driver Core patches for 2.6.10-rc1
Message-ID: <20041112225850.GA6550@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few driver core and sysfs patches and fixes for 2.6.10-rc1.
They fix some minor bugs in sysfs, add some more environment variables
to /sbin/hotplug to make userspace easier, and shrink the size of struct
device.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 arch/arm/common/locomo.c        |    3 ---
 arch/arm/common/sa1111.c        |   23 +++++++++++++++--------
 arch/arm/mach-sa1100/neponset.c |   23 +++++++++++++++--------
 drivers/base/bus.c              |    2 +-
 drivers/base/class.c            |    6 ++++++
 drivers/base/core.c             |   21 +++++++++++++++++++++
 drivers/block/genhd.c           |    6 ++++++
 drivers/video/aty/aty128fb.c    |   10 +++++-----
 drivers/video/aty/atyfb_base.c  |   10 +++++-----
 drivers/video/aty/radeon_pm.c   |    6 +++---
 fs/sysfs/dir.c                  |    8 ++++----
 include/linux/device.h          |    5 -----
 include/linux/kobject_uevent.h  |    1 +
 lib/kobject_uevent.c            |    8 +++++---
 14 files changed, 87 insertions(+), 45 deletions(-)
-----

Anil Keshavamurthy:
  o Add KOBJ_ONLINE

David Brownell:
  o driver core: shrink struct device a bit

Greg Kroah-Hartman:
  o sysfs: fix odd patch error
  o driver core: fix up some missed power_state changes from David's patch

Kay Sievers:
  o print hotplug SEQNUM as unsigned
  o add the bus name to the hotplug environment
  o add the driver name to the hotplug environment

Maneesh Soni:
  o sysfs: fix duplicate driver registration error

Milton D. Miller II:
  o fix sysfs backing store error path confusion

