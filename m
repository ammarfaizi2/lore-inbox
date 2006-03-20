Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWCTLRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWCTLRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWCTLRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:17:04 -0500
Received: from havoc.gtf.org ([69.61.125.42]:62138 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750991AbWCTLRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:17:03 -0500
Date: Mon, 20 Mar 2006 06:16:58 -0500
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patches] libata updates
Message-ID: <20060320111658.GA16172@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just sent upstream; patch snipped due to size]

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/Makefile       |    2 
 drivers/scsi/ahci.c         |  197 +-
 drivers/scsi/ata_piix.c     |  392 +++--
 drivers/scsi/libata-bmdma.c |  703 ++++++++++
 drivers/scsi/libata-core.c  | 2984 +++++++++++++++++++++-----------------------
 drivers/scsi/libata-scsi.c  |  240 ++-
 drivers/scsi/libata.h       |    3 
 drivers/scsi/pdc_adma.c     |    6 
 drivers/scsi/sata_mv.c      |  279 +++-
 drivers/scsi/sata_nv.c      |    2 
 drivers/scsi/sata_promise.c |  129 +
 drivers/scsi/sata_qstor.c   |   10 
 drivers/scsi/sata_sil.c     |  128 -
 drivers/scsi/sata_sil24.c   |  102 -
 drivers/scsi/sata_sis.c     |    2 
 drivers/scsi/sata_svw.c     |    2 
 drivers/scsi/sata_sx4.c     |   25 
 drivers/scsi/sata_uli.c     |    2 
 drivers/scsi/sata_via.c     |    2 
 drivers/scsi/sata_vsc.c     |    2 
 drivers/scsi/scsi_error.c   |    7 
 include/linux/ata.h         |   22 
 include/linux/libata.h      |  180 ++
 include/scsi/scsi_eh.h      |    3 
 24 files changed, 3312 insertions(+), 2112 deletions(-)

Albert Lee:
      libata CHS: LBA28/LBA48 optimization (revise #6)

Daniel Drake:
      sata_promise: Support FastTrak TX4300/TX4310

Jeff Garzik:
      [libata ata_piix] Fix ICH6/7 map value interpretation
      [libata sata_mv] add 6042 support, fix 60xx/50xx EDMA configuration
      [libata scsi] build fix for ATA_FLAG_IN_EH change
      [libata] Move PCI IDE BMDMA-related code to new file libata-bmdma.c.
      libata: turn on ATAPI by default

Luke Kosewski:
      [libata sata_promise] add correct read/write of hotplug registers for SATAII devices

Randy Dunlap:
      
      Various libata documentation updates.

Tejun Heo:
      libata: separate out ata_sata_print_link_status
      ahci: separate out ahci_stop/start_engine
      ahci: separate out ahci_dev_classify
      ata_piix: fix MAP VALUE interpretation for for ICH6/7
      libata: fold __ata_qc_complete() into ata_qc_free()
      libata: make the owner of a qc responsible for freeing it
      libata: fix ata_qc_issue() error handling
      ahci: fix err_mask setting in ahci_host_intr
      libata: add detailed AC_ERR_* flags
      libata: return AC_ERR_* from issue functions
      SCSI: export scsi_eh_finish_cmd() and scsi_eh_flush_done_q()
      libata: implement and apply ata_eh_qc_complete/retry()
      libata: create pio/atapi task queueing wrappers
      ahci: stop engine during hard reset
      ahci: add constants for SRST
      libata: export ata_busy_sleep
      libata: modify ata_dev_try_classify
      libata: new ->probe_reset operation
      libata: implement ata_drive_probe_reset()
      libata: implement standard reset component operations and ->probe_reset
      libata: implement ATA_FLAG_IN_EH port flag
      libata: EH / pio tasks synchronization
      libata: fix ata_std_probe_reset() SATA detection
      libata: separate out sata_phy_resume() from sata_std_hardreset()
      libata: add probeinit component operation to ata_drive_probe_reset()
      libata: implement ata_std_probeinit()
      libata: add ATA_QCFLAG_EH_SCHEDULED
      libata: implement ata_scsi_timed_out()
      libata: use ata_scsi_timed_out()
      libata: kill NULL qc handling from ->eng_timeout callbacks
      ahci: separate out ahci_fill_cmd_slot()
      libata: make new reset act identical to ->phy_reset register-wise
      libata: kill SError clearing in sata_std_hardreset().
      sata_sil: convert to new reset mechanism
      sata_sil24: convert to new reset mechanism
      sata_sil24: add hardreset
      libata: inline ata_qc_complete()
      ahci: make ahci_fill_cmd_slot() take *pp instead of *ap
      ahci: convert to new reset mechanism
      libata: convert assert(X)'s in libata core layer to WARN_ON(!X)'s
      libata: convert assert(xxx)'s in low-level drivers to WARN_ON(!xxx)'s
      libata: kill assert() macro
      libata: allow ->probe_reset to return ATA_DEV_UNKNOWN
      ata_piix: kill spurious assignment in piix_sata_probe()
      libata: implement ata_dev_id_c_string()
      libata: use ata_dev_id_c_string()
      libata: separate out ata_id_n_sectors()
      libata: separate out ata_id_major_version()
      libata: make ata_dump_id() take @id instead of @dev
      libata: don't do EDD handling if ->probe_reset is used
      libata: make ata_dev_knobble() per-device
      libata: move cdb_len for host to device
      libata: add per-device max_sectors
      libata: kill sht->max_sectors
      libata: rename ata_dev_id_[c_]string()
      libata: update ata_dev_init_params()
      libata: fix comment regarding setting cable type
      ata_piix: convert pata to new reset mechanism
      ata_piix: convert sata to new reset mechanism
      libata: separate out ata_dev_read_id()
      libata: kill ata_dev_reread_id()
      sata_sil24: add a new PCI ID for SiI 3124
      libata: kill illegal kfree(id)
      sata_sil: remove unneeded ATA_FLAG_SRST from 3512 port info
      libata: seperate out ata_class_present()
      ata_piix: finer-grained port_info
      ata_piix: add a couple of flags
      ata_piix: implement proper port map
      ata_piix: reimplement piix_sata_probe()
      libata: convert dev->id to pointer
      libata: separate out ata_dev_configure()
      libata: fold ata_dev_config() into ata_dev_configure()
      libata: reorganize ata_bus_probe()
      ata_piix: rename PIIX_FLAG_IGN_PRESENT to PIIX_FLAG_IGNORE_PCS
      sata_sil: replace sil_3112_m15w board id with sil_3112
      sata_sil: use kzalloc
      sata_sil: replace register address constants with sil_port[] entry
      sata_sil: cosmetic flag/constant changes
      libata: re-initialize parameters before configuring
      libata: add @print_info argument to ata_dev_configure()
      libata: implement ata_dev_revalidate()
      libata: revalidate after transfer mode configuration
      sata_sil24: fix mwdma_mask setting
      libata: implement port_task
      libata: convert pio_task and packet_task to port_task
      libata: kill unused pio_task and packet_task
      libata: rename ATA_FLAG_FLUSH_PIO_TASK to ATA_FLAG_FLUSH_PORT_TASK
      libata: improve xfer mask constants and update ata_mode_string()
      libata: add xfer_mask handling functions
      libata: use ata_id_xfermask() in ata_dev_configure()
      libata: use xfer_mask helpers in ata_dev_set_mode()
      libata: reimplement ata_set_mode() using xfer_mask helpers
      libata: kill unused xfer_mode functions
      libata: fix missing classes[] initialization in ata_bus_probe()
      sata_sil24: exit early from softreset if SStatus reports no device
      sata_sil24: lengthen softreset timeout
      ahci: enable prefetching for PACKET commands
      libata: fix class handling in ata_bus_probe()
      libata: check Word 88 validity in ata_id_xfer_mask()
      libata: use local *id instead of dev->id in ata_dev_configure()
      libata: move IDENTIFY info printing from ata_dev_read_id() to ata_dev_configure()

