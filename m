Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVIHWVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVIHWVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVIHWVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:21:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:64188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965037AbVIHWVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:21:32 -0400
Date: Thu, 8 Sep 2005 15:21:06 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru
Subject: [GIT PATCH] W1 patches for 2.6.13
Message-ID: <20050908222105.GA6633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some w1 patches that have been in the -mm tree for a while.
They add a new driver, and fix up the netlink logic a lot.  They also
add a crc16 implementation that is needed.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing lists, if
anyone wants to see them.

thanks,

greg k-h

 drivers/w1/Kconfig        |   16 ++
 drivers/w1/Makefile       |    7 
 drivers/w1/ds_w1_bridge.c |   24 +--
 drivers/w1/dscore.c       |  161 +++++++++++----------
 drivers/w1/dscore.h       |   10 -
 drivers/w1/w1.c           |  336 ++++++++++++++++++++++++++++-----------------
 drivers/w1/w1.h           |   22 ++
 drivers/w1/w1_ds2433.c    |  339 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/w1/w1_family.c    |   11 -
 drivers/w1/w1_family.h    |    7 
 drivers/w1/w1_int.c       |   28 +--
 drivers/w1/w1_io.c        |   24 +++
 drivers/w1/w1_io.h        |    1 
 drivers/w1/w1_netlink.c   |   26 +++
 drivers/w1/w1_netlink.h   |    2 
 drivers/w1/w1_smem.c      |   53 -------
 drivers/w1/w1_therm.c     |   49 +++---
 include/linux/crc16.h     |   44 +++++
 lib/Kconfig               |    8 +
 lib/Makefile              |    3 
 lib/crc16.c               |   67 +++++++++
 21 files changed, 898 insertions(+), 340 deletions(-)


Evgeniy Polyakov:
  W1: w1_netlink: New init/fini netlink callbacks.
  w1: Detouching bug fixed.
  w1: Fixed 64bit compilation warning.
  w1: hotplug support.
  W1: Sync with w1/ds9490 tree.
  w1: Added add/remove slave callbacks.
  w1: Added inline functions on top of container_of().
  w1: Added w1_reset_select_slave() - Resets the bus and then selects the slave by
  w1_ds2433: Added crc16 protection and read caching.
  lib/crc16: added crc16 algorithm.
  w1: Decreased debug level.
  w1: Added DS2433 driver.
  w1: Added DS2433 driver - family id update.
  w1: added private family data into w1_slave strucutre.


