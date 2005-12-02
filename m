Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVLBQlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVLBQlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVLBQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:41:17 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:37068 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750818AbVLBQlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:41:16 -0500
Subject: [GIT PATCH] SCSI bug fixes for 2.6.15-rc4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 10:40:54 -0600
Message-Id: <1133541656.3497.34.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless anything else nasty turns up, these should be the final bug fixes
for 2.6.15.

They're available here

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Andreas Herrmann:
  o zfcp: fix return code of zfcp_scsi_slave_alloc
  o zfcp: fix adapter initialization

Eric Moore:
  o mptfusion: Add maintainers
  o mptfusion : dv performance fix

Heiko Carstens:
  o zfcp: fix spinlock initialization

Hugh Dickins:
  o sg: fix a bug in st_map_user_pages failure path
  o sg and st unmap_user_pages allow PageReserved
  o st: fix a bug in sgl_map_user_pages failure path

James Bottomley:
  o SPI DV: be more conservative about echo buffer usage

Mark Haverkamp:
  o aacraid: Check scsi_bios_ptabe return code

Matthew Wilcox:
  o sym2: Disable IU and QAS negotiation

Maxim Shchetynin:
  o zfcp: fix link down handling during firmware update

Vasily Averin:
  o aic7xxx: reset handler selects a wrong command


And the diffstat:

 MAINTAINERS                         |    9 ++
 drivers/message/fusion/mptbase.c    |   64 ++++++++++++++++++++
 drivers/message/fusion/mptbase.h    |    3 
 drivers/message/fusion/mptscsih.c   |   10 +++
 drivers/s390/scsi/zfcp_aux.c        |   14 ++++
 drivers/s390/scsi/zfcp_dbf.c        |    4 -
 drivers/s390/scsi/zfcp_erp.c        |   94 ++++++++++--------------------
 drivers/s390/scsi/zfcp_fsf.c        |  110 ++++++++++++++++++++----------------
 drivers/s390/scsi/zfcp_scsi.c       |    2 
 drivers/scsi/aacraid/linit.c        |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.c  |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.c  |    2 
 drivers/scsi/scsi_transport_spi.c   |   28 ++++++---
 drivers/scsi/sg.c                   |    6 -
 drivers/scsi/st.c                   |    3 
 drivers/scsi/sym53c8xx_2/sym_glue.c |    5 +
 16 files changed, 225 insertions(+), 133 deletions(-)

James


