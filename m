Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269694AbUJAE6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269694AbUJAE6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 00:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269695AbUJAE6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 00:58:31 -0400
Received: from havoc.gtf.org ([69.28.190.101]:59836 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269496AbUJAE6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 00:58:23 -0400
Date: Fri, 1 Oct 2004 00:58:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [sata] status report, libata-dev queue updated
Message-ID: <20041001045822.GA25784@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Notable updates:
* new driver for ULi SATA (formerly ALi)
* SMART support via ATA passthru CDB
* support for Promise PATA ports


IMPORTANT NOTE:  All changes in the "libata-dev-2.6" patch queue should
be considered experimental, for testing only.  Do not use in production.


Status report(s):
	http://linux.yyz.us/sata/


BK repo:
	bk pull bk://gkernel.bkbits.net/libata-dev-2.6


Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc3-libata-dev1.patch.bz2

This will update the following files:

 drivers/pci/quirks.c        |    4 
 drivers/scsi/Kconfig        |   16 
 drivers/scsi/Makefile       |    2 
 drivers/scsi/ahci.c         | 1023 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |   38 +
 drivers/scsi/libata-scsi.c  |  269 +++++++++++
 drivers/scsi/libata.h       |    2 
 drivers/scsi/sata_nv.c      |   38 -
 drivers/scsi/sata_promise.c |   56 ++
 drivers/scsi/sata_uli.c     |  282 ++++++++++++
 drivers/scsi/sata_vsc.c     |    8 
 include/linux/ata.h         |    1 
 include/linux/libata.h      |    2 
 include/scsi/scsi.h         |    3 
 14 files changed, 1712 insertions(+), 32 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

François Romieu:
  o sata_nv: housekeeping for goto labels
  o sata_nv: wrong failure path and leak
  o sata_nv: enable hotplug event on successfull init only

Jeff Garzik:
  o [libata] fix printk warning
  o [libata sata_uli] add dev_select hook
  o [libata] add sata_uli driver for ULi (formerly ALi) SATA
  o [libata ahci] more updates
  o [libata ahci] fix several bugs
  o [libata] fix typo from hand-merge
  o [libata] add AHCI driver
  o [ata piix] enable ICH5/6 combined mode quirk based on BLK_DEV_IDE_SATA

Jeremy Higdon:
  o per-port LED control for sata_vsc

John W. Linville:
  o libata: SMART support via ATA pass-thru

