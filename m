Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVAGHKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVAGHKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVAGHKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:10:48 -0500
Received: from havoc.gtf.org ([63.115.148.101]:44171 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261289AbVAGHKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:10:33 -0500
Date: Fri, 7 Jan 2005 02:10:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: libata-dev queue updated
Message-ID: <20050107071032.GA15229@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent changes:
* ICH7 support added (via Intel)
* add DMA blacklist, needed for good PATA support
* update to latest kernel, 2.6.10-bk9



BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.10-bk9-libata-dev1.patch.bz2

This will update the following files:

 drivers/pci/quirks.c         |    6 
 drivers/scsi/Kconfig         |   18 +
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ahci.c          |    8 
 drivers/scsi/ata_adma.c      |  636 +++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ata_piix.c      |   15 
 drivers/scsi/libata-core.c   |  128 +++++++
 drivers/scsi/libata-scsi.c   |  409 +++++++++++++++++++++++++
 drivers/scsi/libata.h        |    2 
 drivers/scsi/pata_pdc2027x.c |  694 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   56 +++
 drivers/scsi/sata_via.c      |  202 +++++++++---
 include/linux/ata.h          |    1 
 include/linux/libata.h       |    2 
 include/scsi/scsi.h          |    3 
 15 files changed, 2110 insertions(+), 72 deletions(-)

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

<jason.d.gaston:intel.com>:
  o SATA support for Intel ICH7

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o [libata] add DMA blacklist
  o [libata] add new driver ata_adma
  o [libata sata_via] add support for VT6421 SATA
  o [libata sata_via] minor cleanups
  o [libata pdc2027x] update for upstream struct device conversion
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

Tobias Lorenz:
  o libata-scsi: get-identity ioctl support

