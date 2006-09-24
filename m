Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWIXQ3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWIXQ3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWIXQ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:29:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:44460 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751207AbWIXQ3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:29:41 -0400
Date: Sun, 24 Sep 2006 12:29:40 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata update
Message-ID: <20060924162940.GA14461@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just sent upstream; patch in git, it's too big to post]

Notable changes:
* move to drivers/ata
* add Alan's PATA drivers; drivers/ide still primary PATA for some time
* AHCI suspend/resume

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 Documentation/DocBook/libata.tmpl    |   12 
 drivers/Kconfig                      |    2 
 drivers/Makefile                     |    1 
 drivers/ata/Kconfig                  |  484 ++
 drivers/ata/Makefile                 |   62 
 drivers/ata/ahci.c                   | 1684 +++++++++
 drivers/ata/ata_generic.c            |  252 +
 drivers/ata/ata_piix.c               | 1258 +++++++
 drivers/ata/libata-core.c            | 6171 +++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c              | 2245 ++++++++++++
 drivers/ata/libata-scsi.c            | 3322 ++++++++++++++++++
 drivers/ata/libata-sff.c             | 1121 ++++++
 drivers/ata/libata.h                 |  122 
 drivers/ata/pata_ali.c               |  679 +++
 drivers/ata/pata_amd.c               |  718 ++++
 drivers/ata/pata_artop.c             |  518 ++
 drivers/ata/pata_atiixp.c            |  306 +
 drivers/ata/pata_cmd64x.c            |  505 ++
 drivers/ata/pata_cs5520.c            |  336 +
 drivers/ata/pata_cs5530.c            |  387 ++
 drivers/ata/pata_cs5535.c            |  291 +
 drivers/ata/pata_cypress.c           |  227 +
 drivers/ata/pata_efar.c              |  342 +
 drivers/ata/pata_hpt366.c            |  478 ++
 drivers/ata/pata_hpt37x.c            | 1257 +++++++
 drivers/ata/pata_hpt3x2n.c           |  597 +++
 drivers/ata/pata_hpt3x3.c            |  226 +
 drivers/ata/pata_isapnp.c            |  156 
 drivers/ata/pata_it821x.c            |  847 ++++
 drivers/ata/pata_jmicron.c           |  266 +
 drivers/ata/pata_legacy.c            |  949 +++++
 drivers/ata/pata_mpiix.c             |  313 +
 drivers/ata/pata_netcell.c           |  175 
 drivers/ata/pata_ns87410.c           |  236 +
 drivers/ata/pata_oldpiix.c           |  339 +
 drivers/ata/pata_opti.c              |  292 +
 drivers/ata/pata_optidma.c           |  547 +++
 drivers/ata/pata_pcmcia.c            |  393 ++
 drivers/ata/pata_pdc2027x.c          |  869 ++++
 drivers/ata/pata_pdc202xx_old.c      |  423 ++
 drivers/ata/pata_qdi.c               |  403 ++
 drivers/ata/pata_radisys.c           |  335 +
 drivers/ata/pata_rz1000.c            |  205 +
 drivers/ata/pata_sc1200.c            |  287 +
 drivers/ata/pata_serverworks.c       |  587 +++
 drivers/ata/pata_sil680.c            |  381 ++
 drivers/ata/pata_sis.c               | 1034 +++++
 drivers/ata/pata_sl82c105.c          |  388 ++
 drivers/ata/pata_triflex.c           |  285 +
 drivers/ata/pata_via.c               |  568 +++
 drivers/ata/pdc_adma.c               |  740 ++++
 drivers/ata/sata_mv.c                | 2465 +++++++++++++
 drivers/ata/sata_nv.c                |  595 +++
 drivers/ata/sata_promise.c           |  844 ++++
 drivers/ata/sata_promise.h           |  157 
 drivers/ata/sata_qstor.c             |  730 ++++
 drivers/ata/sata_sil.c               |  728 ++++
 drivers/ata/sata_sil24.c             | 1227 ++++++
 drivers/ata/sata_sis.c               |  347 +
 drivers/ata/sata_svw.c               |  508 ++
 drivers/ata/sata_sx4.c               | 1502 ++++++++
 drivers/ata/sata_uli.c               |  300 +
 drivers/ata/sata_via.c               |  502 ++
 drivers/ata/sata_vsc.c               |  482 ++
 drivers/pci/quirks.c                 |    6 
 drivers/scsi/Kconfig                 |  138 
 drivers/scsi/Makefile                |   16 
 drivers/scsi/ahci.c                  | 1473 --------
 drivers/scsi/ata_piix.c              | 1040 -----
 drivers/scsi/libata-bmdma.c          | 1149 ------
 drivers/scsi/libata-core.c           | 6020 ----------------------------------
 drivers/scsi/libata-eh.c             | 2245 ------------
 drivers/scsi/libata-scsi.c           | 3173 -----------------
 drivers/scsi/libata.h                |  117 
 drivers/scsi/pdc_adma.c              |  740 ----
 drivers/scsi/sata_mv.c               | 2467 -------------
 drivers/scsi/sata_nv.c               |  595 ---
 drivers/scsi/sata_promise.c          |  844 ----
 drivers/scsi/sata_promise.h          |  157 
 drivers/scsi/sata_qstor.c            |  730 ----
 drivers/scsi/sata_sil.c              |  727 ----
 drivers/scsi/sata_sil24.c            | 1222 ------
 drivers/scsi/sata_sis.c              |  347 -
 drivers/scsi/sata_svw.c              |  508 --
 drivers/scsi/sata_sx4.c              | 1502 --------
 drivers/scsi/sata_uli.c              |  300 -
 drivers/scsi/sata_via.c              |  502 --
 drivers/scsi/sata_vsc.c              |  482 --
 include/asm-alpha/libata-portmap.h   |    1 
 include/asm-generic/libata-portmap.h |   12 
 include/asm-i386/libata-portmap.h    |    1 
 include/asm-ia64/libata-portmap.h    |    1 
 include/asm-powerpc/libata-portmap.h |    1 
 include/asm-sparc/libata-portmap.h   |    1 
 include/asm-sparc64/libata-portmap.h |    1 
 include/asm-x86_64/libata-portmap.h  |    1 
 include/linux/ata.h                  |   26 
 include/linux/libata.h               |   90 
 98 files changed, 45107 insertions(+), 26536 deletions(-)

Alan Cox:
      libata: rework legacy handling to remove much of the cruft
      libata: Add CompactFlash support
      Update SiS PATA
      pata_amd: Check enable bits on Nvidia
      libata: improve handling of diagostic fail (and hardware that misreports it)

Alexey Dobriyan:
      CONFIG_PM=n slim: drivers/scsi/sata_sil*

Arnaud Patard:
      Fix libata resource conflict for legacy mode

Brian King:
      libata: Add ata_host_set_init
      libata: Add ata_port_init
      libata: Move ata_probe_ent_alloc to libata_core
      libata: Add support for SATA attachment to SAS adapters

Henrik Kretzschmar:
      libata: change path to libata in libata.tmpl

Jay Cliburn:
      sata_via: Add SATA support for vt8237a

Jeff Garzik:
      [libata] ahci: add SiS PCI IDs
      [libata] some function renaming
      [libata] Kill 'count' var in ata_device_add()
      [ATA] Increase lba48 max-sectors from 200 to 256.
      Move libata to drivers/ata.
      libata: Remove SCSI_ prefix from Kconfig symbols
      libata: Separate libata.ko build from individual driver builds
      [libata] ata_piix: add missing kfree()
      libata: Make sure drivers/ata is a separate Kconfig menu
      Clean up drivers/ata/Kconfig a bit.
      libata: Grand renaming.
      Rename libata-bmdma.c to libata-sff.c.
      [libata] Add a bunch of PATA drivers.
      [libata] Trim trailing whitespace.
      [libata #pata-drivers] Trim trailing whitespace.
      [libata] Add pata_jmicron driver to Kconfig, Makefile
      [libata] ata_piix: build fix
      [libata] Delete pata_it8172 driver

Pavel Roskin:
      libata: replace pci_module_init() with pci_register_driver()

Tejun Heo:
      sata_sil: remove unaffected drives from m15w blacklist
      ahci: relocate several internal functions
      ahci: cosmetic changes to ahci_start/stop_engine()
      ahci: simplify ahci_start_engine()
      libata: improve driver initialization and deinitialization
      ahci: separate out ahci_reset_controller() and ahci_init_controller()
      ahci: implement Power Management support
      libata: cosmetic changes to PM functions
      ahci: remove IRQ mask clearing from init_controller()
      libata: update ata_host_init() and rename it to ata_port_init_shost()
      libata: implement per-dev xfermask
      libata: implement dummy port
      libata: use dummy port for stolen legacy ports
      libata: replace ap->hard_port_no with ap->port_no
      libata: kill unused hard_port_no and legacy_mode
      libata: s/CONFIG_SCSI_SATA/CONFIG_[S]ATA/g in pci/quirks.c
      libata: fix non-uniform ports handling

zhao, forrest:
      The redefinition of ahci_start_engine() and ahci_stop_engine()

