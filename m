Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVEUAKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVEUAKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVEUAKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:10:33 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:12776 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261613AbVEUAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:10:21 -0400
Subject: [GIT PATCH] SCSI Bug Fixes for 2.6.12-rc4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 20 May 2005 19:10:11 -0500
Message-Id: <1116634211.5174.89.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents the accumulated set of fixes that solve the aic7xxx
problems that have been cropping up recently.

The patch is available from

rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6.git

The short changelog is

Christoph Hellwig:
  o aic7xxx: remove usage of obsolete typedefs
  o remove dma_mask hacks
  o aic7xxx: remove Linux 2.4 ifdefs
  o aic7xxx: remove some DV leftovers

James Bottomley:
  o aic7xxx: fix U160 mode
  o aic7xxx: add back locking
  o aic7xxx: make correct use of slave_alloc/destroy and remove the per device timer
  o aic7xxx: remove the completeq
  o aic7xxx: remove the last vestiges of the runq
  o remove aic7xxx busyq
  o correct aic7xxx period setting routines
  o implement parameter limits in the SPI transport class

And the diffstat:

 drivers/scsi/aic7xxx/aic7770_osm.c     |   52 -
 drivers/scsi/aic7xxx/aic7xxx_osm.c     | 1402 +++++++--------------------------
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |  169 ---
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |   11 
 drivers/scsi/aic7xxx/aic7xxx_proc.c    |   13 
 drivers/scsi/aic7xxx/aiclib.c          |    1 
 drivers/scsi/scsi_transport_spi.c      |  188 +++-
 include/scsi/scsi_transport_spi.h      |    6 
 8 files changed, 531 insertions(+), 1311 deletions(-)

James

