Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752069AbWIXChn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWIXChn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 22:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWIXChn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 22:37:43 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:6796 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1752066AbWIXChl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 22:37:41 -0400
Subject: [GIT PATCH] scsi updates for post 2.6.18
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 21:37:31 -0500
Message-Id: <1159065451.3436.10.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the usual grab bag of updates including three new drivers:
aic94xx, stex and arcmsr.

The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The short changelog is:

<brking:charter.net>:
  o megaraid: Add support for change_queue_depth

<malahal:us.ibm.com>:
  o aic94xx: Fix for a typo in aic94xx_init()

Alan Cox:
  o Switch some more scsi drivers to pci_get_device and refcounted pci structures
  o eata_pio cleanup and PCI fix

Alan Stern:
  o sanitize INQUIRY strings

Alexis Bruemmer:
  o aic94xx: Removes Reliance on FLASH Manufacture IDs

Andreas Herrmann:
  o zfcp: update maintainers file
  o zfcp: fix: avoid removal of fsf reqs before qdio queues are down
  o zfcp: introduce struct timer_list in struct zfcp_fsf_req
  o zfcp: fix: use correct req_id in eh_abort_handler
  o limit recursion when flushing shost->starved_list
  o This stack overflow occurred during tests on s390 using zfcp

Andrew Morton:
  o areca sysfs fix

Brian King:
  o ipr: Bump driver version to 2.1.4
  o ipr: Auto sense handling fix
  o ipr: Properly handle IOA recovered errors
  o ipr: Handle new SAS error codes
  o ipr: Add some hardware defined types for SATA
  o DAC960: PCI id table fixup

Christoph Hellwig:
  o remove SCSI_STATE_ #defines

Daniel Walker:
  o fix compile error on module_refcount
  o BusLogic gcc 4.1 warning fixes

Darrick Wong:
  o aic94xx: Increase can_queue for better performance

Dave Jones:
  o remove unnecessary includes of linux/config.h from drivers/scsi/
  o advansys pci tweaks

dave wysochanski:
  o Don't add scsi_device for devices that return PQ=1, PDT=0x1f

Doug Ledford:
  o aic7xxx: pause sequencer before touching SBLKCTL

Douglas Gilbert:
  o scsi_debug version 1.80

Ed Lin:
  o stex: add shared tags from block

Erich Chen:
  o arcmsr: initial driver, version 1.20.00.13

Hannes Reinecke:
  o Wrong size information for devices with disabled read access

Heiko Carstens:
  o zfcp: create private slab caches to guarantee proper data alignment
  o zfcp: remove zfcp_ccw_unregister function

Henrik Kretzschmar:
  o wd33c93: Scsi_Cmnd convertion
  o scsi-driver ultrastore replace Scsi_Cmnd with struct scsi_cmnd
  o convert to PCI_DEVICE() macro

James Bottomley:
  o Merge mulgrave-w:git/linux-2.6
  o SPI transport class: misc DV fixes
  o aic7xxx: avoid checking SBLKCTL register for certain cards
  o Merge mulgrave-w:git/scsi-misc-2.6
  o aha152x: remove static host array
  o fix up SCSI netlink build
  o aci94xx: implement link rate setting
  o scsi_transport_sas: make minimum and maximum linkrate settable quantities
  o SAS: consolidate linkspeed definitions
  o fix up non-modular SCSI
  o Fix refcount breakage with 'echo "1" > scan' when target already present
  o add failure return to scsi_init_shared_tag_map()
  o sd: fix cache flushing on module removal (and individual device removal)
  o add shared tag map helpers
  o block: add support for shared tag maps
  o aic94xx: add MODULE_FIRMWARE tag
  o aic94xx: new driver
  o The log of the separate development is
  o scsi_transport_sas: remove local_attached flag
  o Merge ../linux-2.6
  o fix up short inquiry printing
  o arcmsr: fix up sysfs values
  o mptsas: add parent port backlink

James Smart:
  o lpfc 8.1.10 : Change version number to 8.1.10
  o lpfc 8.1.10 : Add support for new lpfc soft_wwpn attribute
  o lpfc 8.1.10 : Add support for dev_loss_tmo_callbk and fast_io_fail_tmo_callbk
  o FC transport: Add dev_loss_tmo callbacks, and new fast_io_fail_tmo w/ callback
  o lpfc 8.1.10 : Add support to return adapter symbolic name
  o lpfc 8.1.10 : Add support to post events via new FC event interfaces
  o & FC transport: extend event vendor id's to 64bits
  o and FC Transport: add netlink support for posting of transport events
  o fc transport: add fc_host system_hostname attribute and u64_to_wwn()
  o fc transport: convert fc_host symbolic_name attribute to a dynamic attribute

Jeff Garzik:
  o Add Promise SuperTrak driver

Jesper Juhl:
  o megaraid: Make megaraid_ioctl() check copy_to_user() return value

Jon Masters:
  o MODULE_FIRMWARE for binary firmware(s)

Mark Haverkamp:
  o aacraid: README update
  o aacraid: remove scsi_remove_device
  o aacraid: merge rx and rkt code
  o aacraid: expose physical devices
  o aacraid: misc cleanup
  o aacraid: Reset adapter in recovery timeout
  o aacraid: Check for unlikely errors
  o aacraid: Restart adapter on firmware assert (Update 2)
  o aacraid: interruptible ioctl

Matthew Wilcox:
  o Improve inquiry printing

Michael Reed:
  o mptfc: add additional fc transport attributes
  o scsi_queue_work() documented return value is incorrect

Michal Piotrowski:
  o megaraid_sas: pci_module_init to pci_register_driver conversion

Mike Christie:
  o iscsi class: update version
  o libiscsi: don't call into lld to cleanup task
  o libiscsi: check that command ptr is set before accessing it
  o iscsi_tcp: fix partial digest recv
  o libiscsi: only check burst lengths when sending unsol data
  o iscsi_tcp: update header size during relogin
  o iscsi_tcp: fix header resend
  o scsi_tcp: rm data rx and tx tfms
  o iscsi_tcp: fix padding, data digests, and IO at weird offsets
  o attempt to complete r2t with data len greater than max burst
  o add refcouting around ctask usage in main IO patch
  o libiscsi, iscsi_tcp, iscsi_iser: check that burst lengths are valid

Randy Dunlap:
  o aic7*: cleanup MODULE_PARM_DESC strings

Swen Schillig:
  o zfcp: update maintainers file


And the diffstat:

 Documentation/scsi/ChangeLog.arcmsr      |   56 
 Documentation/scsi/aacraid.txt           |   53 
 Documentation/scsi/arcmsr_spec.txt       |  574 +++++++
 Documentation/scsi/libsas.txt            |  484 ++++++
 MAINTAINERS                              |    4 
 block/ll_rw_blk.c                        |  109 +
 drivers/block/DAC960.c                   |    2 
 drivers/block/cciss_scsi.c               |   14 
 drivers/infiniband/ulp/iser/iscsi_iser.c |   18 
 drivers/infiniband/ulp/iser/iscsi_iser.h |    1 
 drivers/message/fusion/mptfc.c           |   96 +
 drivers/message/fusion/mptsas.c          |   19 
 drivers/s390/scsi/zfcp_aux.c             |   84 -
 drivers/s390/scsi/zfcp_ccw.c             |   13 
 drivers/s390/scsi/zfcp_dbf.c             |   13 
 drivers/s390/scsi/zfcp_def.h             |   24 
 drivers/s390/scsi/zfcp_erp.c             |  231 --
 drivers/s390/scsi/zfcp_ext.h             |   18 
 drivers/s390/scsi/zfcp_fsf.c             |  295 +--
 drivers/s390/scsi/zfcp_scsi.c            |  114 -
 drivers/scsi/BusLogic.c                  |   61 
 drivers/scsi/Kconfig                     |   32 
 drivers/scsi/Makefile                    |    5 
 drivers/scsi/a2091.c                     |    6 
 drivers/scsi/a2091.h                     |    4 
 drivers/scsi/a3000.c                     |    8 
 drivers/scsi/a3000.h                     |    4 
 drivers/scsi/aacraid/aachba.c            |   60 
 drivers/scsi/aacraid/aacraid.h           |   20 
 drivers/scsi/aacraid/commctrl.c          |   25 
 drivers/scsi/aacraid/comminit.c          |   13 
 drivers/scsi/aacraid/commsup.c           |  279 +++
 drivers/scsi/aacraid/dpcsup.c            |   10 
 drivers/scsi/aacraid/linit.c             |   35 
 drivers/scsi/aacraid/rkt.c               |  446 -----
 drivers/scsi/aacraid/rx.c                |  117 +
 drivers/scsi/aacraid/sa.c                |   21 
 drivers/scsi/advansys.c                  |   90 -
 drivers/scsi/aha152x.c                   |   53 
 drivers/scsi/aic7xxx/aic79xx_osm.c       |    4 
 drivers/scsi/aic7xxx/aic7xxx_osm.c       |   23 
 drivers/scsi/aic7xxx_old.c               |   11 
 drivers/scsi/aic94xx/Kconfig             |   41 
 drivers/scsi/aic94xx/Makefile            |   39 
 drivers/scsi/aic94xx/aic94xx.h           |  114 +
 drivers/scsi/aic94xx/aic94xx_dev.c       |  353 ++++
 drivers/scsi/aic94xx/aic94xx_dump.c      |  959 ++++++++++++
 drivers/scsi/aic94xx/aic94xx_dump.h      |   52 
 drivers/scsi/aic94xx/aic94xx_hwi.c       | 1376 +++++++++++++++++
 drivers/scsi/aic94xx/aic94xx_hwi.h       |  397 +++++
 drivers/scsi/aic94xx/aic94xx_init.c      |  866 +++++++++++
 drivers/scsi/aic94xx/aic94xx_reg.c       |  332 ++++
 drivers/scsi/aic94xx/aic94xx_reg.h       |  302 +++
 drivers/scsi/aic94xx/aic94xx_reg_def.h   | 2398 +++++++++++++++++++++++++++++++
 drivers/scsi/aic94xx/aic94xx_sas.h       |  785 ++++++++++
 drivers/scsi/aic94xx/aic94xx_scb.c       |  758 +++++++++
 drivers/scsi/aic94xx/aic94xx_sds.c       | 1089 ++++++++++++++
 drivers/scsi/aic94xx/aic94xx_seq.c       | 1404 ++++++++++++++++++
 drivers/scsi/aic94xx/aic94xx_seq.h       |   70 
 drivers/scsi/aic94xx/aic94xx_task.c      |  642 ++++++++
 drivers/scsi/aic94xx/aic94xx_tmf.c       |  636 ++++++++
 drivers/scsi/arcmsr/Makefile             |    6 
 drivers/scsi/arcmsr/arcmsr.h             |  472 ++++++
 drivers/scsi/arcmsr/arcmsr_attr.c        |  381 ++++
 drivers/scsi/arcmsr/arcmsr_hba.c         | 1496 +++++++++++++++++++
 drivers/scsi/dpt_i2o.c                   |    7 
 drivers/scsi/eata_generic.h              |    1 
 drivers/scsi/eata_pio.c                  |  127 -
 drivers/scsi/fcal.c                      |    3 
 drivers/scsi/g_NCR5380.c                 |    3 
 drivers/scsi/gvp11.c                     |    8 
 drivers/scsi/gvp11.h                     |    4 
 drivers/scsi/hosts.c                     |    7 
 drivers/scsi/hptiop.c                    |    1 
 drivers/scsi/ipr.c                       |   34 
 drivers/scsi/ipr.h                       |   82 -
 drivers/scsi/iscsi_tcp.c                 |  811 ++++------
 drivers/scsi/iscsi_tcp.h                 |   41 
 drivers/scsi/libata-eh.c                 |    1 
 drivers/scsi/libiscsi.c                  |  144 +
 drivers/scsi/libsas/Kconfig              |   39 
 drivers/scsi/libsas/Makefile             |   36 
 drivers/scsi/libsas/sas_discover.c       |  749 +++++++++
 drivers/scsi/libsas/sas_dump.c           |   76 
 drivers/scsi/libsas/sas_dump.h           |   42 
 drivers/scsi/libsas/sas_event.c          |   75 
 drivers/scsi/libsas/sas_expander.c       | 1855 +++++++++++++++++++++++
 drivers/scsi/libsas/sas_init.c           |  267 +++
 drivers/scsi/libsas/sas_internal.h       |  146 +
 drivers/scsi/libsas/sas_phy.c            |  158 ++
 drivers/scsi/libsas/sas_port.c           |  279 +++
 drivers/scsi/libsas/sas_scsi_host.c      |  786 ++++++++++
 drivers/scsi/lpfc/lpfc.h                 |    8 
 drivers/scsi/lpfc/lpfc_attr.c            |  285 +++
 drivers/scsi/lpfc/lpfc_crtn.h            |    3 
 drivers/scsi/lpfc/lpfc_ct.c              |   25 
 drivers/scsi/lpfc/lpfc_disc.h            |    6 
 drivers/scsi/lpfc/lpfc_els.c             |    5 
 drivers/scsi/lpfc/lpfc_hbadisc.c         |  186 --
 drivers/scsi/lpfc/lpfc_init.c            |    8 
 drivers/scsi/lpfc/lpfc_nportdisc.c       |    2 
 drivers/scsi/lpfc/lpfc_scsi.c            |   10 
 drivers/scsi/lpfc/lpfc_version.h         |    2 
 drivers/scsi/megaraid.c                  |    9 
 drivers/scsi/megaraid/megaraid_mbox.c    |   16 
 drivers/scsi/megaraid/megaraid_sas.c     |   36 
 drivers/scsi/mvme147.c                   |    6 
 drivers/scsi/mvme147.h                   |    4 
 drivers/scsi/scsi.c                      |   58 
 drivers/scsi/scsi.h                      |    2 
 drivers/scsi/scsi_debug.c                |  230 ++
 drivers/scsi/scsi_lib.c                  |   10 
 drivers/scsi/scsi_netlink.c              |  199 ++
 drivers/scsi/scsi_priv.h                 |   11 
 drivers/scsi/scsi_proc.c                 |    4 
 drivers/scsi/scsi_scan.c                 |  146 -
 drivers/scsi/scsi_transport_fc.c         |  368 ++++
 drivers/scsi/scsi_transport_iscsi.c      |    2 
 drivers/scsi/scsi_transport_sas.c        |   83 -
 drivers/scsi/scsi_transport_spi.c        |   30 
 drivers/scsi/sd.c                        |    2 
 drivers/scsi/sgiwd93.c                   |    8 
 drivers/scsi/stex.c                      | 1252 ++++++++++++++++
 drivers/scsi/ultrastor.c                 |   23 
 drivers/scsi/ultrastor.h                 |   12 
 include/linux/blkdev.h                   |    2 
 include/linux/module.h                   |    5 
 include/linux/netlink.h                  |    2 
 include/linux/pci_ids.h                  |   17 
 include/scsi/libiscsi.h                  |    6 
 include/scsi/libsas.h                    |  627 ++++++++
 include/scsi/sas.h                       |  631 ++++++++
 include/scsi/scsi.h                      |   16 
 include/scsi/scsi_cmnd.h                 |   14 
 include/scsi/scsi_host.h                 |    7 
 include/scsi/scsi_netlink.h              |   87 +
 include/scsi/scsi_netlink_fc.h           |   71 
 include/scsi/scsi_tcq.h                  |   15 
 include/scsi/scsi_transport_fc.h         |   80 -
 include/scsi/scsi_transport_sas.h        |   37 
 include/scsi/scsi_transport_spi.h        |    3 
 141 files changed, 26685 insertions(+), 2285 deletions(-)

James



