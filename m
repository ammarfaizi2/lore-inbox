Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbULBIed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbULBIed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbULBIeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:34:25 -0500
Received: from havoc.gtf.org ([69.28.190.101]:45213 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261444AbULBIeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:34:10 -0500
Date: Thu, 2 Dec 2004 03:29:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: libata-dev queue updated
Message-ID: <20041202082930.GA7512@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just updated libata-dev queue in BitKeeper, to the latest upstream kernel.

No patch yet, I'll post in a day or two.  You can generate your own
patch using Documentation/BK-usage/gcapatch script in the kernel tree.

Here's a summary of the stuff sitting in this testing queue:
* new driver ata_adma (Pacific Digital PATA and SATA)
* new hardware ULi 5281 supported in sata_uli driver
* new hardware VT6421 SATA supported in sata_via driver
* support for PATA ports on Promise SATA cards
* support for newer Promise PATA cards
* ATA passthru (read: SMART support)
* other minor stuff

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

This will update the following files:

 Documentation/DocBook/libata.tmpl |  192 ++++++++++
 drivers/scsi/Kconfig              |   18 
 drivers/scsi/Makefile             |    2 
 drivers/scsi/ahci.c               |    5 
 drivers/scsi/ata_adma.c           |  636 ++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c        |   48 ++
 drivers/scsi/libata-scsi.c        |  413 ++++++++++++++++++++++
 drivers/scsi/libata.h             |    2 
 drivers/scsi/pata_pdc2027x.c      |  694 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c       |   56 ++-
 drivers/scsi/sata_uli.c           |   51 +-
 drivers/scsi/sata_via.c           |  202 ++++++++---
 include/linux/ata.h               |    1 
 include/linux/libata.h            |    2 
 include/scsi/scsi.h               |    3 
 15 files changed, 2221 insertions(+), 104 deletions(-)

through these ChangeSets:

<albertcc:tw.ibm.com>:
  o [libata pdc2027x] fix incorrect pio and mwdma masks
  o [libata pdc2027x] remove quirks and ROM enable
  o [libata] add driver for Promise PATA 2027x

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o [libata docs] add chapter on libata driver API
  o [libata] add new driver ata_adma
  o [libata ahci] minor fixes
  o [libata sata_uli] add 5281 support, fix SATA phy setup for others
  o [libata sata_via] add support for VT6421 SATA
  o [libata sata_via] minor cleanups
  o [libata] fix DocBook bugs
  o [libata pdc2027x] update for upstream struct device conversion
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

Tobias Lorenz:
  o libata-scsi: get-identity ioctl support

