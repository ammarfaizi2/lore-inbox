Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUIOQKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUIOQKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIOQKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:10:15 -0400
Received: from [69.28.190.101] ([69.28.190.101]:28051 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266648AbUIOQIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:08:44 -0400
Date: Wed, 15 Sep 2004 12:08:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [sata] libata-2.6 queue updated
Message-ID: <20040915160843.GA31309@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the batch that was submitted to Andrew and Linus yesterday.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.4
		or
	bk pull bk://gkernel.bkbits.net/libata-2.6

Patches:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.28-pre3-libata2.patch.bz2
	or
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc2-bk1-libata1.patch.bz2

This will update the following files:

 drivers/pci/quirks.c        |    4 
 drivers/scsi/ata_piix.c     |   24 +--
 drivers/scsi/libata-core.c  |  308 ++++++++++++++++++++++++++------------------
 drivers/scsi/sata_nv.c      |   66 +++------
 drivers/scsi/sata_promise.c |    8 -
 drivers/scsi/sata_sil.c     |   12 -
 drivers/scsi/sata_sis.c     |   58 +++-----
 drivers/scsi/sata_svw.c     |   74 ++++++++++
 drivers/scsi/sata_sx4.c     |    8 -
 drivers/scsi/sata_via.c     |   53 ++-----
 drivers/scsi/sata_vsc.c     |    8 -
 include/linux/libata.h      |   22 +--
 12 files changed, 363 insertions(+), 282 deletions(-)

through these ChangeSets:

<ananth@broadcom.com> (04/09/14 1.1867.6.5)
   [libata sata_svw] race condition fix, new device support
   
   * address race condition WRT order of DMA-start and ATA command issue
     (see code comment for more details)
   
   * Add support for Frodo 4/8

<jgarzik@pobox.com> (04/09/14 1.1867.6.4)
   [libata] minor comment updates, preparing for iomap merge

<jgarzik@pobox.com> (04/09/13 1.1867.6.3)
   [libata] consolidate legacy/native mode init code into helpers
   
   Eliminates duplicate code in sata_nv, sata_sis, and sata_via.

<jgarzik@pobox.com> (04/09/13 1.1867.6.2)
   [libata] remove distinction between MMIO/PIO helper functions
   
   Prepare for use of new generic iomap API.

<jgarzik@pobox.com> (04/09/13 1.1867.6.1)
   [libata sata_nv] sync with 2.4
   
   Driver should be using LIBATA_MAX_PRD not ATA_MAX_PRD,
   due to iommu layer splitting.

<jgarzik@pobox.com> (04/08/23 1.1832.2.1)
   [ata piix] enable ICH5/6 combined mode quirk based on BLK_DEV_IDE_SATA

