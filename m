Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVCCJjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVCCJjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVCCJhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:37:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49549 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261764AbVCCJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:35:18 -0500
Message-ID: <4226DA45.90106@pobox.com>
Date: Thu, 03 Mar 2005 04:35:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SATA] libata-dev-2.6 queue updated
Content-Type: multipart/mixed;
 boundary="------------070309040806090208040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070309040806090208040204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Added a couple patches, and updated for 2.6.11-release.


--------------070309040806090208040204
Content-Type: text/plain;
 name="libata-dev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev-2.6.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6
		or
	bk pull bk://kernel.bkbits.net/jgarzik/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-libata-dev1.patch.bz2


This will update the following files:

 drivers/scsi/Kconfig         |   18 
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ahci.c          |  107 ++++-
 drivers/scsi/ata_adma.c      |  778 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c   |  312 +++++++++--------
 drivers/scsi/libata-scsi.c   |  701 ++++++++++++++++++++++++++++++++------
 drivers/scsi/libata.h        |    6 
 drivers/scsi/pata_pdc2027x.c |  771 ++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_nv.c       |    6 
 drivers/scsi/sata_promise.c  |   84 ++++
 drivers/scsi/sata_qstor.c    |   50 +-
 drivers/scsi/sata_sil.c      |    2 
 drivers/scsi/sata_svw.c      |    4 
 drivers/scsi/sata_vsc.c      |    7 
 include/linux/ata.h          |   15 
 include/linux/libata.h       |   10 
 include/scsi/scsi.h          |    3 
 17 files changed, 2564 insertions(+), 312 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<liml:rtr.ca>:
  o sata_qstor: eh_timeout fix

<tklauser:nuerscht.ch>:
  o drivers/scsi/ahci: Use the DMA_{64,32}BIT_MASK constants
  o drivers/scsi/sata_vsc: Use the DMA_{64,32}BIT_MASK constants

Adam J. Richter:
  o ata_pci_remove_one used freed memory

Adrian Bunk:
  o drivers/scsi/sata_*: make code static

Albert Lee:
  o [libata] use init-device-params ATA command where needed
  o [libata] ata_scsi_verify_xlat() fix
  o pdc2027x timing register fix for 100MHz
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
  o [libata ahci] Print out port id on error messages
  o [libata ahci] support PCI MSI interrupt vector
  o [libata adma] Add init code, fix CPB submission code
  o [libata ahci] finish ATAPI support
  o [libata adma] trivial whitespace cleanup
  o [libata dma] fix DMA mode config; add some more initialization code
  o [libata adma] add support for configuring PIO/DMA modes
  o [libata] turn on ATAPI support
  o [libata sata_promise] merge Tobias Lorenz' pdc20619 patch, part 2
  o [libata] small cleanups
  o [libata] remove unused execute-device-diagnostic reset method
  o [libata] add new driver ata_adma
  o [libata pdc2027x] update for upstream struct device conversion
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: update ATA pass thru opcodes
  o libata: minor style changes in ata_scsi_pass_thru
  o libata: filter SET_FEATURES - XFER MODE from ATA pass thru
  o libata: sync SMART ioctls with ATA pass thru spec (T10/04-262r7)
  o libata: fix command queue leak when xlat_func fails
  o libata: SMART support via ATA pass-thru

Mark Lord:
  o [libata qstor] minor update per LKML comments

Tobias Lorenz:
  o [libata sata_promise] pdc20619 (PATA) support
  o libata-scsi: get-identity ioctl support


--------------070309040806090208040204--
