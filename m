Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbVHXG4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVHXG4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVHXG4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:56:48 -0400
Received: from havoc.gtf.org ([69.61.125.42]:22186 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751108AbVHXG4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:56:47 -0400
Date: Wed, 24 Aug 2005 02:56:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: libata-dev queue updated
Message-ID: <20050824065642.GA15784@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Recent updates:
* core: ATAPI fixes from Tejun Heo and Albert Lee
* sata_promise: new PCI IDs
* sata_sil: don't apply mod15write fix to 3125/3114 chips
* ahci: "HD LED always on" fix


git users:  'ALL' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.13-rc7-libata1.patch.bz2


 drivers/scsi/Kconfig         |   26 +
 drivers/scsi/Makefile        |    3 
 drivers/scsi/ahci.c          |    5 
 drivers/scsi/ata_adma.c      |  786 ++++++++++++++++++++++++++++++++++
 drivers/scsi/ata_piix.c      |   14 
 drivers/scsi/libata-core.c   |  360 +++++++++++++--
 drivers/scsi/libata-scsi.c   |  984 ++++++++++++++++++++++++++++++++++---------
 drivers/scsi/libata.h        |    5 
 drivers/scsi/pata_pdc2027x.c |  847 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_nv.c       |   24 -
 drivers/scsi/sata_promise.c  |   63 ++
 drivers/scsi/sata_qstor.c    |    8 
 drivers/scsi/sata_sil.c      |   31 -
 drivers/scsi/sata_sil24.c    |  785 ++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_sis.c      |    2 
 drivers/scsi/sata_svw.c      |   10 
 drivers/scsi/sata_sx4.c      |  141 +++---
 drivers/scsi/sata_uli.c      |    2 
 drivers/scsi/sata_via.c      |    2 
 drivers/scsi/sata_vsc.c      |    5 
 include/linux/ata.h          |   16 
 include/linux/libata.h       |   11 
 include/linux/pci_ids.h      |    1 
 include/scsi/scsi.h          |    3 
 24 files changed, 3762 insertions(+), 372 deletions(-)


Albert Lee:
  [libata] C/H/S support, for older devices
  [libata] add driver for Promise PATA 2027x
  libata-dev-2.6: pdc2027x add ata_scsi_ioctl
  libata-dev-2.6: pdc2027x change comments
  libata-dev-2.6: pdc2027x move the PLL counter reading code
  libata-dev-2.6: pdc2027x PLL input clock detection fix
  libata ata_data_xfer() fix
  libata handle the case when device returns/needs extra data
  libata-dev: Convert pdc2027x from PIO to MMIO
  libata-dev: pdc2027x use "long" for counter data type
  libata-dev: pdc2027x ATAPI DMA lost irq problem workaround
  libata: Clear ATA_QCFLAG_ACTIVE flag before calling the completion callback

Daniel Drake:
  sata_nv: Support MCP51/MCP55 device IDs
  sata_promise: Add PDC40519 id

Douglas Gilbert:
  [libata scsi] add START STOP UNIT translation

Erik Benada:
  [libata sata_promise] support PATA ports on SATA controllers

Jason Gaston:
  ahci: AHCI mode SATA patch for Intel ICH7-M DH

Jeff Garzik:
  [libata] add new driver ata_adma
  [libata adma] enable PCI MWI during controller initialization
  [libata] ATA passthru (arbitrary ATA command execution)
  [libata] ata_adma: update for recent ->host_stop() API changes
  [libata] pata_pdc2027x: update for recent ->host_stop() API changes
  libata: Update 'passthru' branch for latest libata
  libata: trim trailing whitespace.

Martin Wilck:
  Fix HD activity LED with ahci

Otto Meier:
  sata_promise: Add PDC40718 id

Tejun Heo:
  SATA: rewritten sil24 driver
  sil24: add FIXME comment above ata_device_add
  sil24: remove irq disable code on spurious interrupt
  sil24: add testing for PCI fault
  sil24: move error handling out of hot interrupt path
  sil24: remove PORT_TF
  sil24: replace pp->port w/ ap->ioaddr.cmd_addr
  sil24: fix PORT_CTRL_STAT constants
  sil24: add more comments for constants
  fix atapi_packet_task vs. intr race (take 2)
  libata: implement ata_poll_qc_complete and use it in polling functions
  sil: apply M15W quirk selectively (take 2)



