Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWFVS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWFVS3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWFVS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:29:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:62601 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751877AbWFVS3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:29:50 -0400
Date: Thu, 22 Jun 2006 11:26:45 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [GIT PATCH] W1 patches for 2.6.17
Message-ID: <20060622182645.GB5668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some w1 patches that have been in the -mm tree for a very long
time.  They do a variety of cleanups and bugfixes.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/w1/masters/ds2490           |   18 +
 Documentation/w1/w1.generic               |   18 +
 Documentation/w1/w1.netlink               |   98 +++++++
 drivers/w1/Kconfig                        |   14 +
 drivers/w1/Makefile                       |    4 
 drivers/w1/masters/Kconfig                |   27 +-
 drivers/w1/masters/Makefile               |    7 
 drivers/w1/masters/ds2482.c               |   24 +-
 drivers/w1/masters/{dscore.c => ds2490.c} |  434 ++++++++++++++++++++---------
 drivers/w1/masters/ds_w1_bridge.c         |  174 ------------
 drivers/w1/masters/dscore.h               |  166 -----------
 drivers/w1/slaves/Kconfig                 |    2 
 drivers/w1/slaves/w1_ds2433.c             |   21 -
 drivers/w1/slaves/w1_smem.c               |    1 
 drivers/w1/slaves/w1_therm.c              |   13 -
 drivers/w1/w1.c                           |  263 ++++++++++++------
 drivers/w1/w1.h                           |   41 ++-
 drivers/w1/w1_family.c                    |   18 +
 drivers/w1/w1_family.h                    |    3 
 drivers/w1/w1_int.c                       |   16 -
 drivers/w1/w1_io.c                        |   31 +-
 drivers/w1/w1_io.h                        |    3 
 drivers/w1/w1_netlink.c                   |  219 ++++++++++++---
 drivers/w1/w1_netlink.h                   |   35 ++
 include/linux/connector.h                 |    5 
 include/linux/netlink.h                   |    2 
 26 files changed, 909 insertions(+), 748 deletions(-)
 create mode 100644 Documentation/w1/masters/ds2490
 create mode 100644 Documentation/w1/w1.netlink
 rename drivers/w1/masters/{dscore.c => ds2490.c} (67%)
 delete mode 100644 drivers/w1/masters/ds_w1_bridge.c
 delete mode 100644 drivers/w1/masters/dscore.h

---------------

Adrian Bunk:
      drivers/w1/w1.c: fix a compile error

Andrew Morton:
      w1 exports
      w1: warning fix

Evgeniy Polyakov:
      w1: Added default generic read/write operations.
      w1: Replace dscore and ds_w1_bridge with ds2490 driver.
      w1: Userspace communication protocol over connector.
      w1: Move w1-connector definitions into linux/include/connector.h
      w1: netlink: Mark netlink group 1 as unused.
      w1: Make w1 connector notifications depend on connector.
      w1: Use mutexes instead of semaphores.
      W1: cleanups
      W1: possible cleanups
      w1: clean up W1_CON dependency.

Jean-Luc Leger:
      W1: fix dependencies of W1_SLAVE_DS2433_CRC

