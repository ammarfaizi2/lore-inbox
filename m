Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVBJRwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVBJRwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVBJRwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:52:06 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:2726 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262176AbVBJRv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:51:59 -0500
Subject: [BK PATCH] SCSI bug fixes for 2.6.11-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 12:51:45 -0500
Message-Id: <1108057905.7361.21.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of four bug fixes each with a corresponding user oops
report and one well tested driver update.

The patch is available at

bk://linux-scsi.bkbits.net/scsi-rc-fixes-2.6

The short changelog is

Andreas Herrmann:
  o zfcp: bugfixes (without kfree) for -bk

Andrew Vasquez:
  o qla2xxx: fix BUG's for smp_processor_id() on interrupt

Christoph Hellwig:
  o cciss: handle scsi_add_host failure

James Bottomley:
  o SCSI: fix HBA removal problem with transport classes

Seokmann Ju:
  o megaraid_mbox 2.20.4.3 patch

and the diffstat is:

 Documentation/scsi/ChangeLog.megaraid  |  104 ++++++++
 drivers/block/cciss_scsi.c             |   15 -
 drivers/s390/scsi/zfcp_erp.c           |    6 
 drivers/s390/scsi/zfcp_fsf.c           |   37 +--
 drivers/scsi/megaraid/Kconfig.megaraid |    1 
 drivers/scsi/megaraid/mega_common.h    |    3 
 drivers/scsi/megaraid/megaraid_ioctl.h |    1 
 drivers/scsi/megaraid/megaraid_mbox.c  |  403 ++++++++++++++++++++++++++++++++-
 drivers/scsi/megaraid/megaraid_mbox.h  |   24 +
 drivers/scsi/megaraid/megaraid_mm.c    |   39 +++
 drivers/scsi/megaraid/megaraid_mm.h    |    5 
 drivers/scsi/qla2xxx/qla_isr.c         |    4 
 drivers/scsi/scsi_transport_fc.c       |    3 
 drivers/scsi/scsi_transport_iscsi.c    |    4 
 drivers/scsi/scsi_transport_spi.c      |    3 
 15 files changed, 604 insertions(+), 48 deletions(-)

James


