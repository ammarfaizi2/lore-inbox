Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVLOACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVLOACH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVLOACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:02:07 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:60081 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932403AbVLOACG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:02:06 -0500
Subject: [GIT PATCH] final SCSI fixes for 2.6.15-rc5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 16:01:49 -0800
Message-Id: <1134604909.11150.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These should (hopefully) represent the last few urgent bug fixes that
have shown up.  The fixes are available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Andrew Vasquez:
  o qla2xxx: Correct short-WRITE status handling
  o qla2xxx: Correct mis-handling of AENs

Brian King:
  o fix double free of scsi request queue

Dave Boutcher:
  o ibmvscsi kexec fix

James Bottomley:
  o Consolidate REQ_BLOCK_PC handling path (fix ipod panic)

Jens Axboe:
  o fix panic when ejecting ieee1394 ipod

Mark Lord:
  o Fix incorrect pointer in megaraid.c MODE_SENSE emulation

Matthew Wilcox:
  o Negotiate correctly with async-only devices

Michael Reed:
  o fix OOPS due to clearing eh_action prior to aborting eh command

And the diffstat:

 drivers/scsi/ibmvscsi/ibmvscsi.h      |    2 +-
 drivers/scsi/ibmvscsi/iseries_vscsi.c |    3 ++-
 drivers/scsi/ibmvscsi/rpa_vscsi.c     |    8 +++++++-
 drivers/scsi/megaraid.c               |    2 +-
 drivers/scsi/qla2xxx/qla_def.h        |   10 +---------
 drivers/scsi/qla2xxx/qla_init.c       |    6 +++---
 drivers/scsi/qla2xxx/qla_isr.c        |   15 +++++++++++++++
 drivers/scsi/scsi_error.c             |    7 ++++++-
 drivers/scsi/scsi_lib.c               |   33 +++++++++++++++++++++------------
 drivers/scsi/scsi_scan.c              |    1 -
 drivers/scsi/sd.c                     |   16 +---------------
 drivers/scsi/sr.c                     |   20 +++-----------------
 drivers/scsi/st.c                     |   19 +------------------
 drivers/scsi/sym53c8xx_2/sym_hipd.c   |    4 ++--
 include/scsi/scsi_cmnd.h              |    1 +
 15 files changed, 65 insertions(+), 82 deletions(-)

James


