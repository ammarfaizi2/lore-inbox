Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUE1V2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUE1V2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUE1V1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:27:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:18861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261875AbUE1V0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:43 -0400
Date: Fri, 28 May 2004 14:25:11 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core fixes for 2.6.7-rc1
Message-ID: <20040528212511.GA12470@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some driver core fixes for 2.6.7-rc1.  This set of patches also
includes the removal of the smbios driver, which the author wanted to
have removed after realizing that it was not needed.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/firmware/smbios.c    |  248 -------------------------------------------
 drivers/firmware/smbios.h    |   53 ---------
 drivers/base/power/resume.c  |    7 -
 drivers/base/power/runtime.c |   10 +
 drivers/base/power/suspend.c |   34 +++--
 drivers/firmware/Kconfig     |    8 -
 drivers/firmware/Makefile    |    1 
 drivers/firmware/smbios.c    |    2 
 fs/sysfs/dir.c               |   12 +-
 fs/sysfs/inode.c             |    7 +
 fs/sysfs/symlink.c           |  135 ++++++++++++++++-------
 fs/sysfs/sysfs.h             |    7 -
 include/linux/pm.h           |    1 
 13 files changed, 148 insertions(+), 377 deletions(-)
-----

<tpoynor:mvista.com>:
  o Fix for leave-runtime-suspended-devices-off-at-system-resume.patch
  o Leave runtime suspended devices off at system resume
  o Device runtime suspend/resume fixes

Greg Kroah-Hartman:
  o Minor coding style fixups in resume code and added a bit of debugging help
  o Report which device failed to suspend
  o Remove the smbios driver as it is not needed

Maneesh Soni:
  o fix-sysfs-symlinks.patch

Rene Herman:
  o missing closing \n in printk

