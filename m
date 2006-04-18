Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWDRJy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDRJy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDRJy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:54:59 -0400
Received: from havoc.gtf.org ([69.61.125.42]:47314 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750728AbWDRJy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:54:58 -0400
Date: Tue, 18 Apr 2006 05:54:54 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: What's in libata-dev.git
Message-ID: <20060418095454.GA454@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Junio routinely posts these nice "What's in git.git" messages to the git
mailing list.  These posts are a useful guide to what's upcoming.

Since libata-dev.git contains a number of branches for ongoing
development projects, I thought a "What's in libata-dev.git" message
would be useful.


------------------------------------------------------------------------
branch: upstream (pending for 2.6.18)
parent: master
------------------------------------------------------------------------
Albert Lee:
      libata: convert ATAPI_ENABLE_DMADIR to module parameter

Jeff Garzik:
      [libata] kill bogus cut-n-pasted comments in three drivers
      [libata] bump versions
      libata: Fix EH merge difference between this branch and upstream.
      libata: Add helper ata_shost_to_port()

Tejun Heo:
      libata: fix ata_set_mode() return value
      libata: make ata_bus_probe() return negative errno on failure
      libata: separate out ata_spd_string()
      libata: convert do_probe_reset() to ata_do_reset()
      libata: implement ata_dev_enabled and disabled()
      libata: make ata_set_mode() handle no-device case properly
      libata: reorganize ata_set_mode()
      libata: don't disable devices from ata_set_mode()
      libata: preserve SATA SPD setting over hard resets
      libata: implement ata_dev_absent()
      libata: implement ap->sata_spd_limit and helpers
      libata: use SATA speed down in ata_drive_probe_reset()
      libata: add 5s sleep between resets
      libata: implement ata_down_xfermask_limit()
      libata: improve ata_bus_probe()
      libata: consider disabled devices in ata_dev_xfermask()
      libata: report device number when PIO fails
      libata: ata_dev_revalidate() printk update
      libata: ATA_FLAG_IN_EH is not used, kill it
      libata: clean up constants
      libata: rename ATA_FLAG_PORT_DISABLED to ATA_FLAG_DISABLED
      libata: clear only affected flags during ata_dev_configure()
      libata: clear ATA_DFLAG_PIO before setting it
      libata: add ATA_QCFLAG_IO
      libata: pass qc around intead of ap during PIO
      libata: always generate sense if qc->err_mask is non-zero
      libata: don't read TF directly from sense generation functions
      libata: add @cdb to ata_exec_internal()
      libata: dec scmd->retries for qcs with zero err_mask
      libata: separate out libata-eh.c
      libata: make some libata-core routines extern
      libata: print SControl in SATA link status info message
      ahci: do not fail softreset if PHY reports no device
      libata: set default cbl in probeinit
      libata: kill @verbose from ata_reset_fn_t
      libata: make reset methods complain when they fail
      sata_sil24: fix timeout calculation in sil24_softreset
      sata_sil24: better error message from softreset
      libata: implement ata_wait_register()
      ahci: use ata_wait_register()
      sata_sil24: use ata_wait_register()
      libata: disable failed devices only once in ata_bus_probe()
      libata: cosmetic update to ata_bus_probe()
      libata: export ata_set_sata_spd()
      sata_sil24: typo fix
      sata_sil24: rename PORT_IRQ_SDB_FIS to PORT_IRQ_SDB_NOTIFY
      sata_sil24: add more constants
      sata_sil24: consolidate host flags into SIL24_COMMON_FLAGS
      sata_sil24: implement loss of completion interrupt on PCI-X errta fix
      sata_sil24: implement sil24_init_port()
      sata_sil24: put port into known state before softresetting
      sata_sil24: kill 10ms sleep in softreset
      sata_sil24: reimplement hardreset
      sata_sil24: don't do hardreset during driver initialization
      sata_sil24: fix on-memory structure byteorder
      sata_sil24: enable 64bit


------------------------------------------------------------------------
branch: sii-m15w (update Mod15Write blacklist, now that errata is
		 handled better)
parent: upstream
------------------------------------------------------------------------
Tejun Heo:
      sata_sil: remove unaffected drives from m15w blacklist


------------------------------------------------------------------------
branch: sii-lbt (improve DMA handling, eliminate 64k legacy limits)
parent: sii-m15w
------------------------------------------------------------------------
Jeff Garzik:
      [libata sata_sil] Greatly improve DMA handling


------------------------------------------------------------------------
branch: sii-irq (use sii-specific interrupt handler)
parent: sii-m15w
------------------------------------------------------------------------
Jeff Garzik:
      [libata sata_sil] improved interrupt handling
      [libata sata_sil] update for new ata_qc_complete() 1-arg API
      libata: sata_sil build fix


------------------------------------------------------------------------
branch: promise-sata-pata (support for Promise PATA ports on SATA cards)
parent: upstream
------------------------------------------------------------------------
Erik Benada:
      [libata sata_promise] support PATA ports on SATA controllers

Jeff Garzik:
      [libata sata_promise] fix build breakage due to bad merge


------------------------------------------------------------------------
branch: pata-drivers (PATA drivers from Alan and Albert)
parent: upstream
------------------------------------------------------------------------
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
      libata: pata_pdc2027x minor fix
      libata: convert pata_pdc2027x to the new reset mechanism

Andrew Morton:
      pata_opti needs PCI

Jeff Garzik:
      [libata] pata_pdc2027x: update for recent ->host_stop() API changes
      [libata pata_pdc2027x] add documentation ref in header; trim trailing whitespace
      [libata pata_sil680] add to Makefile/Kconfig
      libata: Add makefile rules for pata_via driver.
      [libata] minor updates to PATA drivers
      [libata] constify PCI tables in PATA drivers
      [libata pata_via] fix warning
      libata: Add Intel MPIIX and "old PIIX" PATA drivers.
      [libata pata drivers] trim trailing whitespace
      [libata] remove 'ordered_flush' member from PATA drivers
      [libata pata] fix lingering old-style qc_issue_prot function declarations
      [libata pata_pdc2027x] use pci_iomap(), kzalloc() where appropriate
      [libata] s/ata_dev_present/ata_dev_enabled/ for several PATA drivers
      [libata pata] update for removal of .eh_strategy_handler from Scsi_Host_Template


------------------------------------------------------------------------
branch: nv-adma (ADMA version of sata_nv)
parent: upstream
------------------------------------------------------------------------
Jeff Garzik:
      [libata] ADMA version from sata_nv
      [libata] sata_nv: cleanups
      [libata] sata_nv: more cleanups
      [libata] sata_nv: fix ADMA qc_issue prototype for latest libata API
      [libata sata_nv] update for movement of eh_strategy_handler


------------------------------------------------------------------------
branch: max-sect (increase LBA48 max sectors)
parent: upstream
------------------------------------------------------------------------
Tejun Heo:
      libata: increase LBA48 max sectors to 65535


------------------------------------------------------------------------
branch: irq-pio (IRQ-driven PIO)
parent: upstream
------------------------------------------------------------------------
Albert Lee:
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
      libata irq-pio: misc fixes
      libata irq-pio: merge the ata_dataout_task workqueue with ata_pio_task workqueue
      libata irq-pio: eliminate unnecessary queuing in ata_pio_first_block()
      libata irq-pio: add read/write multiple support
      libata-dev: determine err_mask when error is found
      libata-dev: filter out noisy ATAPI error messages
      libata-dev: Fix array index value in ata_rwcmd_protocol()
      libata-dev: Use new ata_queue_pio_task() for PIO polling task
      libata-dev: Use new AC_ERR_* flags
      libata-dev: Minor comment fix
      libata-dev: recognize WRITE_MULTI_FUA_EXT for r/w multiple
      libata-dev: Remove trailing whitespaces
      libata-dev: Fix merge problem with upstream
      libata-dev: Remove atapi_packet_task()
      libata-dev: Move out the HSM code from ata_host_intr()
      libata-dev: Minor fix for ata_hsm_move() to work with ata_host_intr()
      libata-dev: Let ata_hsm_move() work with both irq-pio and polling pio
      libata-dev: Convert ata_pio_task() to use the new ata_hsm_move()
      libata-dev: Cleanup unused enums/functions
      libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING LLDDs
      libata-dev: Make the the in_wq check as an inline function
      libata-dev: irq-pio minor fixes (respin)
      libata-dev: fix the device err check sequence (respin)
      libata-dev: wait idle after reading the last data block
      libata-dev: print out information for ATAPI devices with CDB interrupts
      libata-dev: handle DRQ=1 ERR=1 (revised)
      libata-dev: irq-pio minor fix
      libata-dev: irq-pio minor fix 2

Jeff Garzik:
      [libata irq-pio] build fix
      [libata pdc_adma] update for removal of ATA_FLAG_NOINTR
      [libata pdc_adma] fix for new irq-driven PIO code
      [libata sata_mv] IRQ PIO build fix
      [libata] irq-pio: fix breakage related to err_mask merge
      [libata sata_promise] irq_pio: fix merge bug
      [libata] build fix after merging some pre-packet_task-removal code
      [libata irq-pio] s/assert/WARN_ON/
      [libata] build fix after cdb_len move
      sata_vsc build fix
      libata: irq-pio build fixes
      [libata] irq-pio: fix build breakage
      [libata] irq-pio: Fix merge mistake


------------------------------------------------------------------------
branch: iomap (use lib/iomap in libata)
parent: git-merge-base iomap master
------------------------------------------------------------------------

Older work converting libata to use iomap.


------------------------------------------------------------------------
branch: ALL (merge of all useful libata-dev.git branches)
parent: upstream, sii-m15w, promise-sata-pata, pata-drivers, max-sect
------------------------------------------------------------------------


