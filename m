Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVBSJFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVBSJFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVBSJFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:05:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35528 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261655AbVBSIkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:40:43 -0500
Message-ID: <4216FB7B.3030409@pobox.com>
Date: Sat, 19 Feb 2005 03:40:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SATA] libata-dev queue updated
Content-Type: multipart/mixed;
 boundary="------------090609000704000408070901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609000704000408070901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch URL, BK URL, and changelog attached.

Recent changes:
* New sata_qstor driver.

* Turn on ATAPI by default.

* Change a couple unconditional use-the-hardware function calls to be 
callbacks instead.  Should have been this way originally.

* Most of C/H/S support.

* Fix bugs in ADMA driver.

* Support PCI MSI in AHCI driver.
* Support ATAPI in AHCI driver.

* Improve ATA passthru (a.k.a. SMART) support


--------------090609000704000408070901
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc4-bk6-libata-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |   26 +
 drivers/scsi/Makefile        |    3 
 drivers/scsi/ahci.c          |  101 ++++-
 drivers/scsi/ata_adma.c      |  778 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ata_piix.c      |    4 
 drivers/scsi/libata-core.c   |  338 ++++++++++--------
 drivers/scsi/libata-scsi.c   |  701 ++++++++++++++++++++++++++++++++------
 drivers/scsi/libata.h        |    7 
 drivers/scsi/pata_pdc2027x.c |  742 +++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_nv.c       |   10 
 drivers/scsi/sata_promise.c  |   92 ++++-
 drivers/scsi/sata_qstor.c    |  700 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_sil.c      |   10 
 drivers/scsi/sata_sis.c      |   10 
 drivers/scsi/sata_svw.c      |   10 
 drivers/scsi/sata_sx4.c      |    8 
 drivers/scsi/sata_uli.c      |   10 
 drivers/scsi/sata_via.c      |  213 ++++++++---
 drivers/scsi/sata_vsc.c      |   10 
 include/linux/ata.h          |   14 
 include/linux/libata.h       |   55 ---
 include/scsi/scsi.h          |    3 
 22 files changed, 3442 insertions(+), 403 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<mat.loikkanen:synopsys.com>:
  o [libata] add ->bmdma_{stop,status} hooks

Adam J. Richter:
  o ata_pci_remove_one used freed memory

Albert Lee:
  o [libata] CHS support: add CHS support to ata_scsi_verify_xlat(), ata_scsi_rw_xlat() and ata_scsiop_read_cap().
  o [libata] CHS support: reorganize read/write translation in ata_scsi_rw_xlat()
  o [libata] CHS support: rename vars (s/sector/block/) in ata_scsi_verify_xlat()
  o [libata] CHS support: detect C/H/S at IDENTIFY DEVICE time
  o [libata] CHS support: add definitions to headers
  o pdc2027x timing register bug fix
  o [libata pdc2027x] fix incorrect pio and mwdma masks
  o [libata pdc2027x] remove quirks and ROM enable
  o [libata] add driver for Promise PATA 2027x

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o [libata ahci] support PCI MSI interrupt vector
  o [libata adma] Add init code, fix CPB submission code
  o [libata ahci] finish ATAPI support
  o [libata adma] trivial whitespace cleanup
  o [libata dma] fix DMA mode config; add some more initialization code
  o [libata adma] add support for configuring PIO/DMA modes
  o [libata] do not call pci_disable_device() for certain errors
  o [libata] turn on ATAPI support
  o [libata sata_promise] merge Tobias Lorenz' pdc20619 patch, part 2
  o [libata] small cleanups
  o [libata] remove unused execute-device-diagnostic reset method
  o [libata] add new driver ata_adma
  o [libata sata_via] add support for VT6421 SATA
  o [libata sata_via] minor cleanups
  o [libata pdc2027x] update for upstream struct device conversion
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: fix command queue leak when xlat_func fails
  o libata: update ATA pass thru opcodes
  o libata: minor style changes in ata_scsi_pass_thru
  o libata: filter SET_FEATURES - XFER MODE from ATA pass thru
  o libata: sync SMART ioctls with ATA pass thru spec (T10/04-262r7)
  o libata: fix command queue leak when xlat_func fails
  o libata: SMART support via ATA pass-thru

Mark Lord:
  o sata_qstor: new basic driver for Pacific Digital

Tobias Lorenz:
  o [libata sata_promise] pdc20619 (PATA) support
  o libata-scsi: get-identity ioctl support


--------------090609000704000408070901--
