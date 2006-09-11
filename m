Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWIKNWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWIKNWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWIKNWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:22:53 -0400
Received: from havoc.gtf.org ([69.61.125.42]:23684 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964821AbWIKNWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:22:51 -0400
Date: Mon, 11 Sep 2006 09:22:50 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: What's in libata-dev.git
Message-ID: <20060911132250.GA5178@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following libata changes are queued for 2.6.19:

General
-------
* Move libata to drivers/ata
* Serial Attached SCSI (SAS) attachment API
* Increase lba28 max sectors from 200 to 256
* Take the opportunity to rename a bunch of functions, and one filename
* More error handling improvements

Driver-specific
---------------
* ahci: suspend/resume support
* ahci: support some new SiS controllers
* sata_via: new PCI ID
* sata_sil: remove unaffected configurations from mod15write blacklist


The 'upstream' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

contains the following updates:

 Documentation/DocBook/libata.tmpl    |   12 
 drivers/Kconfig                      |    2 
 drivers/Makefile                     |    1 
 drivers/ata/Kconfig                  |  493 ++
 drivers/ata/Makefile                 |   63 
 drivers/ata/ahci.c                   | 1684 +++++++++
 drivers/ata/ata_generic.c            |  252 +
 drivers/ata/ata_piix.c               | 1258 +++++++
 drivers/ata/libata-core.c            | 6143 +++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c              | 2246 ++++++++++++
 drivers/ata/libata-scsi.c            | 3322 ++++++++++++++++++
 drivers/ata/libata-sff.c             | 1109 ++++++
 drivers/ata/libata.h                 |  122 
 drivers/ata/pata_ali.c               |  679 +++
 drivers/ata/pata_amd.c               |  707 ++++
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
 drivers/ata/pata_it8172.c            |  288 +
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
 drivers/ata/pata_sis.c               | 1030 +++++
 drivers/ata/pata_sl82c105.c          |  388 ++
 drivers/ata/pata_triflex.c           |  285 +
 drivers/ata/pata_via.c               |  568 +++
 drivers/ata/pdc_adma.c               |  740 ++++
 drivers/ata/sata_mv.c                | 2465 ++++++++++++++
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
 drivers/scsi/ata_piix.c              | 1008 -----
 drivers/scsi/libata-bmdma.c          | 1149 ------
 drivers/scsi/libata-core.c           | 6015 ----------------------------------
 drivers/scsi/libata-eh.c             | 2246 ------------
 drivers/scsi/libata-scsi.c           | 3173 ------------------
 drivers/scsi/libata.h                |  117 
 drivers/scsi/pdc_adma.c              |  740 ----
 drivers/scsi/sata_mv.c               | 2468 --------------
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
 drivers/scsi/sata_via.c              |  501 --
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
 include/linux/libata.h               |   76 
 99 files changed, 45337 insertions(+), 26500 deletions(-)

Alan Cox:
      libata: rework legacy handling to remove much of the cruft
      libata: Add CompactFlash support

Alexey Dobriyan:
      CONFIG_PM=n slim: drivers/scsi/sata_sil*

Andres Salomon:
      [libata] sata_mv: errata check buglet fix

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
      ata_piix: add map 01b for ICH7M

zhao, forrest:
      The redefinition of ahci_start_engine() and ahci_stop_engine()

