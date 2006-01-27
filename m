Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWA0Nyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWA0Nyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWA0Nyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:54:37 -0500
Received: from havoc.gtf.org ([69.61.125.42]:12250 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751123AbWA0Nyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:54:36 -0500
Date: Fri, 27 Jan 2006 08:54:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: libata-dev queue updated
Message-ID: <20060127135435.GA32416@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just updated libata-dev.git with several new patches, most from Tejun.
I'm still plowing through his big pile o patches, so not done yet.


Here's the current contents of the 'ALL' branch of
rsync://rsync.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.16-rc1-git4-libata1.patch.bz2

which contains the following updates:

 drivers/scsi/Kconfig         |   68 +++
 drivers/scsi/Makefile        |    8 
 drivers/scsi/ahci.c          |  108 +++--
 drivers/scsi/ata_piix.c      |   53 +-
 drivers/scsi/libata-core.c   |  828 ++++++++++++++++++++++++++++-------------
 drivers/scsi/libata-scsi.c   |  131 ++++--
 drivers/scsi/libata.h        |    2 
 drivers/scsi/pata_amd.c      |  641 ++++++++++++++++++++++++++++++++
 drivers/scsi/pata_mpiix.c    |  301 +++++++++++++++
 drivers/scsi/pata_oldpiix.c  |  335 ++++++++++++++++
 drivers/scsi/pata_opti.c     |  266 +++++++++++++
 drivers/scsi/pata_pdc2027x.c |  855 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/pata_sil680.c   |  360 ++++++++++++++++++
 drivers/scsi/pata_triflex.c  |  266 +++++++++++++
 drivers/scsi/pata_via.c      |  510 +++++++++++++++++++++++++
 drivers/scsi/pdc_adma.c      |   12 
 drivers/scsi/sata_mv.c       |   25 -
 drivers/scsi/sata_nv.c       |    4 
 drivers/scsi/sata_promise.c  |   75 ++-
 drivers/scsi/sata_qstor.c    |   15 
 drivers/scsi/sata_sil24.c    |   16 
 drivers/scsi/sata_sx4.c      |   22 -
 drivers/scsi/sata_vsc.c      |    6 
 drivers/scsi/scsi_error.c    |    7 
 include/linux/ata.h          |   23 +
 include/linux/libata.h       |  115 ++++-
 include/scsi/scsi_eh.h       |    3 
 27 files changed, 4573 insertions(+), 482 deletions(-)

Alan Cox:
      Add libata CMD/SI680 driver
      [libata] Add PATA driver for Compaq Triflex
      [libata] Add PATA VIA driver.
      [libata] Add driver for PATA AMD/NVIDIA chips.
      libata: Update the AMD driver to support the AMD CS5536.
      libata: Add enablebits support to the triflex driver
      libata: Add enablebits to via driver
      [libata] Add new PATA driver pata_opti
      libata: AMD pata fixes
      libata: Fix opti pci enable bits as with the AMD bug
      libata: Fix enable bits for triflex
      libata: Clean up and fix the VIA PATA libata driver
      libata: Update TODO list for pata_amd
      libata: Updates to the MPIIX driver

Albert Lee:
      [libata] add driver for Promise PATA 2027x
      libata-dev-2.6: pdc2027x add ata_scsi_ioctl
      libata-dev-2.6: pdc2027x change comments
      libata-dev-2.6: pdc2027x move the PLL counter reading code
      libata-dev-2.6: pdc2027x PLL input clock detection fix
      libata-dev: Convert pdc2027x from PIO to MMIO
      libata-dev: pdc2027x use "long" for counter data type
      libata-dev: pdc2027x ATAPI DMA lost irq problem workaround
      libata: interrupt driven pio for libata-core
      libata: interrupt driven pio for LLD
      libata irq-pio: add comments and cleanup
      libata irq-pio: rename atapi_packet_task() and comments
      libata irq-pio: simplify if condition in ata_dataout_task()
      libata irq-pio: cleanup ata_qc_issue_prot()
      libata: move atapi_send_cdb() and ata_dataout_task()
      [libata irq-pio] reorganize ata_pio_sector() and __atapi_pio_bytes()
      [libata irq-pio] reorganize "buf + offset" in ata_pio_sector()
      [libata irq-pio] use PageHighMem() to optimize the kmap_atomic() usage
      libata CHS: LBA28/LBA48 optimization (revise #6)
      libata irq-pio: misc fixes
      libata irq-pio: merge the ata_dataout_task workqueue with ata_pio_task workqueue
      libata irq-pio: eliminate unnecessary queuing in ata_pio_first_block()
      libata irq-pio: add read/write multiple support
      libata: pata_pdc2027x minor fix
      libata-dev: determine err_mask when error is found
      libata-dev: filter out noisy ATAPI error messages

Andrew Morton:
      pata_opti needs PCI

Erik Benada:
      [libata sata_promise] support PATA ports on SATA controllers

Jeff Garzik:
      [libata] pata_pdc2027x: update for recent ->host_stop() API changes
      [libata pata_pdc2027x] add documentation ref in header; trim trailing whitespace
      [libata irq-pio] build fix
      [libata pdc_adma] update for removal of ATA_FLAG_NOINTR
      [libata pata_sil680] add to Makefile/Kconfig
      libata: Add makefile rules for pata_via driver.
      [libata pdc_adma] fix for new irq-driven PIO code
      [libata] minor updates to PATA drivers
      [libata] constify PCI tables in PATA drivers
      [libata sata_mv] IRQ PIO build fix
      [libata pata_via] fix warning
      [libata] irq-pio: fix breakage related to err_mask merge
      libata: Add Intel MPIIX and "old PIIX" PATA drivers.
      [libata pata drivers] trim trailing whitespace
      [libata sata_promise] irq_pio: fix merge bug
      [libata] remove 'ordered_flush' member from PATA drivers
      Fix bugs.

Randy Dunlap:
      

Tejun Heo:
      libata: separate out ata_sata_print_link_status
      ahci: separate out ahci_stop/start_engine
      ahci: separate out ahci_dev_classify
      ata_piix: fix MAP VALUE interpretation for for ICH6/7
      libata: fold __ata_qc_complete() into ata_qc_free()
      libata: make the owner of a qc responsible for freeing it
      libata: fix ata_qc_issue() error handling
      ahci: fix err_mask setting in ahci_host_intr
      libata: return AC_ERR_* from issue functions
      libata: add detailed AC_ERR_* flags
      SCSI: export scsi_eh_finish_cmd() and scsi_eh_flush_done_q()
      libata: implement and apply ata_eh_qc_complete/retry()
      libata: create pio/atapi task queueing wrappers
      ahci: stop engine during hard reset
      ahci: add constants for SRST
      libata: export ata_busy_sleep
      libata: modify ata_dev_try_classify
      libata: new ->probe_reset operation

