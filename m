Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWBHUB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWBHUB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWBHUB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:01:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35281 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030322AbWBHUB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:01:29 -0500
To: torvalds@osdl.org
Subject: [PATCHSET] more misc annotations and fixes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6vVI-0008B3-Ix@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pretty much done with assorted junk at that point...

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/viro/bird.git/ for-linus3

diffstat:
 drivers/ieee1394/sbp2.c           |   10 --------
 drivers/s390/block/dasd_devmap.c  |    8 +++---
 drivers/s390/block/dasd_eckd.c    |   20 ++++++++---------
 drivers/s390/block/dasd_fba.c     |    4 +--
 drivers/s390/block/dasd_genhd.c   |    6 ++---
 drivers/s390/char/con3215.c       |    2 -
 drivers/s390/char/ctrlchar.c      |    2 -
 drivers/s390/char/defkeymap.c     |    6 ++---
 drivers/s390/char/fs3270.c        |   12 +++++-----
 drivers/s390/char/keyboard.c      |    6 ++---
 drivers/s390/char/raw3270.c       |   32 +++++++++++++--------------
 drivers/s390/char/raw3270.h       |    2 -
 drivers/s390/char/tape_34xx.c     |    4 +--
 drivers/s390/char/tty3270.c       |   24 ++++++++++----------
 drivers/s390/char/vmlogrdr.c      |    4 +--
 drivers/s390/char/vmwatchdog.c    |    2 -
 drivers/s390/cio/ccwgroup.c       |    2 -
 drivers/s390/cio/cio.c            |    2 -
 drivers/s390/cio/cmf.c            |    8 +++---
 drivers/s390/cio/device.c         |    8 +++---
 drivers/s390/cio/qdio.c           |    2 -
 drivers/s390/crypto/z90hardware.c |    2 -
 drivers/s390/crypto/z90main.c     |   20 ++++++++---------
 drivers/s390/net/ctctty.c         |    6 ++---
 drivers/s390/net/iucv.c           |    2 -
 drivers/s390/net/qeth_main.c      |   16 ++++++-------
 drivers/s390/net/qeth_sys.c       |    4 +--
 drivers/s390/net/smsgiucv.c       |   14 ++++++------
 drivers/s390/scsi/zfcp_erp.c      |    2 -
 drivers/s390/scsi/zfcp_fsf.c      |    2 -
 drivers/s390/scsi/zfcp_scsi.c     |   38 ++++++++++++++++----------------
 drivers/video/Kconfig             |    8 +++---
 drivers/video/aty/atyfb_base.c    |   44 ++++++++++++++++++++------------------
 fs/proc/inode.c                   |    4 ---
 fs/proc/root.c                    |   17 +++++++-------
 include/asm-v850/system.h         |    2 -
 include/asm-v850/uaccess.h        |    7 ------
 37 files changed, 171 insertions(+), 183 deletions(-)

ShortLog:
Al Viro:
      Revert "aty: remove unnecessary CONFIG_PCI"
      atyfb sparc ifdefs
      sparc dependencies in drivers/video
      gcc41 fixes: v850 get_user()
      v850: cast xchg() to void in set_rmb()
      drivers/s390 misc sparse annotations
      don't mangle INQUIRY if cmddt or evpd bits are set
      fix handling of st_nlink on procfs root

