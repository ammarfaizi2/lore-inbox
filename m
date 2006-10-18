Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWJRUGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWJRUGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWJRUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:06:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:6117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932111AbWJRUGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:06:44 -0400
Date: Wed, 18 Oct 2006 12:58:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core fixes for 2.6.19-rc2
Message-ID: <20061018195833.GA21808@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core and sysfs fixes for 2.6.19-rc2.

All of these patches have been in the -mm tree for a quite a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 Documentation/HOWTO                        |   20 +++++
 Documentation/feature-removal-schedule.txt |    2 -
 drivers/base/bus.c                         |  108 +++++++++++++++++-----------
 drivers/base/class.c                       |    5 +
 drivers/base/core.c                        |   26 +++++--
 drivers/base/dd.c                          |    4 +
 drivers/base/dmapool.c                     |   13 +++
 drivers/base/topology.c                    |    3 -
 fs/sysfs/file.c                            |    7 --
 9 files changed, 123 insertions(+), 65 deletions(-)

---------------

Akinobu Mita:
      driver core: kmalloc() failure check in driver_probe_device

Alan Stern:
      Driver core: Don't ignore error returns from probing

Cornelia Huck:
      driver core fixes: sysfs_create_link() retval check in class.c
      driver core fixes: bus_add_attrs() retval check
      driver core fixes: bus_add_device() cleanup on error
      driver core fixes: device_add() cleanup on error
      driver core fixes: device_create_file() retval check in dmapool.c
      driver core fixes: sysfs_create_group() retval in topology.c

Diego Calleja:
      HOWTO: bug report addition

Dominik Brodowski:
      Documentation: feature-removal-schedule typo

Duncan Sands:
      Driver core: plug device probe memory leak

Hidetoshi Seto:
      sysfs: remove duplicated dput in sysfs_update_file
      sysfs: update obsolete comment in sysfs_update_file

Jeff Garzik:
      Driver core: bus: remove indentation level

Jesper Juhl:
      Driver core: Don't leak 'old_class_name' in drivers/base/core.c::device_rename()

Matthew Wilcox:
      Fix dev_printk() is now GPL-only

