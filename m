Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVFVFVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVFVFVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVFVFTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:19:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:34711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262748AbVFVFMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:15 -0400
Date: Tue, 21 Jun 2005 22:11:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [GIT PATCH] W1 patches for 2.6.12
Message-ID: <20050622051133.GA28612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few w1 patches that have been in the -mm tree for the past few months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel and sensors mailing lists,
if anyone wants to see them.

thanks,

greg k-h


Evgeniy Polyakov:
  w1: fix compiler warnings
  w1: reconnect feature.
  w1: Updates the w1 documentation (w1.generic)
  w1: Adds a default family so that new slave families will show up in sysfs.
  w1: Added the triplet w1 master method and changes w1_search() to use it.
  w1: Adds a sysfs entry (w1_master_search) that allows you to disable/enable periodic searches.
  w1: Cleans up usage of touch_bit/w1_read_bit/w1_write_bit.
  w1_therm: removed duplicated family id.
  w1: new family structure.
  w1_smem: support for new simple rom family [0x81 id].
  w1: cleanups.
  w1_therm: support for ds18b20, ds1822 thermal sensors.

Greg Kroah-Hartman:
  w1: fix build issues

 Documentation/w1/w1.generic |  107 ++++++-
 drivers/w1/Kconfig          |   16 -
 drivers/w1/ds_w1_bridge.c   |    4 
 drivers/w1/matrox_w1.c      |   10 
 drivers/w1/w1.c             |  594 +++++++++++++++++++++-----------------------
 drivers/w1/w1.h             |  135 ++++++----
 drivers/w1/w1_family.c      |   10 
 drivers/w1/w1_family.h      |   20 -
 drivers/w1/w1_int.c         |   49 ++-
 drivers/w1/w1_int.h         |    6 
 drivers/w1/w1_io.c          |  117 +++++++-
 drivers/w1/w1_io.h          |    9 
 drivers/w1/w1_log.h         |    4 
 drivers/w1/w1_netlink.h     |    4 
 drivers/w1/w1_smem.c        |   50 +--
 drivers/w1/w1_therm.c       |  120 ++++++--
 16 files changed, 766 insertions(+), 489 deletions(-)
