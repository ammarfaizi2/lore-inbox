Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVAQV6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVAQV6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVAQVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:54:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:14752 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262903AbVAQVtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:19 -0500
Date: Mon, 17 Jan 2005 13:44:12 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] AOE and Block fixes for 2.6.11-rc1
Message-ID: <20050117214412.GA28400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some AOE driver fixes and a block /proc file updates for
2.6.11-rc1.  All of these patches have been posted to lkml, and been in
the past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/block-2.6

Individual patches will follow, sent to the linux-kernel list.

thanks,

greg k-h

 Documentation/aoe/aoe.txt    |   41 ++++++++++++++++++------------
 Documentation/aoe/mkdevs.sh  |    9 ++++--
 Documentation/aoe/mkshelf.sh |    8 +++---
 Documentation/aoe/status.sh  |   21 ++++++++++++---
 drivers/block/aoe/aoe.h      |    8 ++++--
 drivers/block/aoe/aoeblk.c   |   57 +++++++++++++++++++++++++++++--------------
 drivers/block/aoe/aoechr.c   |    2 -
 drivers/block/aoe/aoedev.c   |   24 +++---------------
 drivers/block/aoe/aoemain.c  |   47 ++++++++++++++++++++++++-----------
 drivers/block/aoe/aoenet.c   |   21 ++++++---------
 drivers/block/genhd.c        |   37 +++++++++------------------
 include/linux/genhd.h        |    6 ++++
 12 files changed, 164 insertions(+), 117 deletions(-)
-----


Ed L. Cashin:
  o aoe: fix __init calling __exit
  o aoe: don't sleep with interrupts on

Greg Kroah-Hartman:
  o Block: move struct disk_attribute to genhd.h
  o Block: Remove block_subsys.rwsem usage

