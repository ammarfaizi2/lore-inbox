Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbUKOGpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUKOGpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKOGpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:45:36 -0500
Received: from havoc.gtf.org ([69.28.190.101]:40665 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261532AbUKOGog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:44:36 -0500
Date: Mon, 15 Nov 2004 01:44:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [SATA] libata-2.4 queue updated
Message-ID: <20041115064434.GA14469@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(This is waiting for Marcelo's next 2.4 release, before going upstream)

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.4

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.28-rc3-libata1.patch.bz2

This will update the following files:

 drivers/scsi/Config.in        |    1 
 drivers/scsi/Makefile         |    1 
 drivers/scsi/ahci.c           | 1043 ++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ata_piix.c       |   16 
 drivers/scsi/libata-core.c    |  336 +++++++++----
 drivers/scsi/libata-scsi.c    |   90 +--
 drivers/scsi/libata.h         |    7 
 drivers/scsi/sata_nv.c        |   16 
 drivers/scsi/sata_promise.c   |   67 +-
 drivers/scsi/sata_sil.c       |    8 
 drivers/scsi/sata_sis.c       |    9 
 drivers/scsi/sata_svw.c       |    7 
 drivers/scsi/sata_sx4.c       |   13 
 drivers/scsi/sata_uli.c       |    9 
 drivers/scsi/sata_via.c       |    3 
 drivers/scsi/sata_vsc.c       |   13 
 include/linux/ata.h           |   44 -
 include/linux/libata-compat.h |   66 ++
 include/linux/libata.h        |   61 +-
 include/linux/mm.h            |    5 
 20 files changed, 1554 insertions(+), 261 deletions(-)

through these ChangeSets:

Bartlomiej Zolnierkiewicz:
  o libata PIO bugfix
  o make ATAPI PIO work
  o arbitrary size ATAPI PIO support bugfixes
  o [libata] arbitrary size ATAPI PIO support
  o REQUEST_SENSE support for ATAPI

Christoph Hellwig:
  o fix sata_svw compile

Jeff Garzik:
  o [libata] bump versions, add MODULE_VERSION() tags
  o [libata] remove dependence on PCI (2.4 stub version)
  o Remove silly comment from linux/ata.h
  o Resync linux/ata.h with 2.6.x
  o Add nth_page() helper
  o [libata ahci] bump version to 1.00
  o [libata] add ssleep() function
  o [libata] cosmetic: make syncing with 2.6 easier
  o [libata] use kunmap_atomic() correctly
  o [libata] return ENOTTY rather than EOPNOTSUPP for unknown-ioctl
  o [libata] fix minor 2.6 backport problems
  o [libata] add AHCI driver

Jeremy Higdon:
  o per-port LED control for sata_vsc

Mark Lord:
  o Export ata_scsi_simulate() for use by non-libata drivers

Matthijs Melchior:
  o [libata ahci] fix rather serious (and/or embarassing) bugs

Meelis Roos:
  o ata.h undefined types in USB

Nishanth Aravamudan:
  o scsi/ahci: replace schedule_timeout() with msleep()/ssleep()

Tobias Lorenz:
  o [libata sata_promise] s/sata/ata/

