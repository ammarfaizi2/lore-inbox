Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVLAVsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVLAVsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVLAVsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:48:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:39305 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932494AbVLAVsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:48:39 -0500
Date: Thu, 1 Dec 2005 16:48:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Final 2.4.x SATA updates
Message-ID: <20051201214837.GA25256@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that ATAPI support is pretty stable, the 2.4 version of libata will
be receiving its final updates soon.  Here is the current backport,
for testing and feedback.

Please report problems -- particularly any regressions -- to
linux-ide@vger.kernel.org.  I may not be able to respond personally
to each and every bug report, but rest assured all feedback is noted.
Sometimes, solutions only become apparent after a few people report the
same problem.

The 'combined' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.4.git

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.32-libata1.patch.bz2
(available as soon as kernel.org mirrors catch up)

contains the following updates:

 drivers/pci/quirks.c          |   86 ++
 drivers/scsi/ahci.c           |  305 ++++---
 drivers/scsi/ata_piix.c       |  136 +--
 drivers/scsi/libata-core.c    | 1743 +++++++++++++++++++++++++++---------------
 drivers/scsi/libata-scsi.c    | 1635 ++++++++++++++++++++++++++++++---------
 drivers/scsi/libata.h         |   68 -
 drivers/scsi/sata_nv.c        |   86 +-
 drivers/scsi/sata_promise.c   |  166 ++--
 drivers/scsi/sata_promise.h   |   33 
 drivers/scsi/sata_qstor.c     |  114 +-
 drivers/scsi/sata_sil.c       |  100 +-
 drivers/scsi/sata_sis.c       |  146 ++-
 drivers/scsi/sata_svw.c       |   85 +-
 drivers/scsi/sata_sx4.c       |  292 +++----
 drivers/scsi/sata_uli.c       |   66 -
 drivers/scsi/sata_via.c       |  110 +-
 drivers/scsi/sata_vsc.c       |   79 +
 include/linux/ata.h           |   86 +-
 include/linux/ioport.h        |    1 
 include/linux/libata-compat.h |  102 ++
 include/linux/libata.h        |  264 ++++--
 include/linux/pci_ids.h       |    6 
 include/scsi/scsi.h           |    4 
 kernel/ksyms.c                |    1 
 kernel/resource.c             |   10 
 25 files changed, 3957 insertions(+), 1767 deletions(-)

Jeff Garzik:
      [libata] resync with kernel 2.6.13
      [libata sata_sx4] trim trailing whitespace
      [libata] resync with 2.6.14
      [libata] resync with 2.6.15-rc3
      [libata] fix build
      [libata] combined mode support, using ugly ____request_resource() hack
      [libata] fix potential oops in pdev_printk() compat helper

