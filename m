Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVCJFqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVCJFqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVCJFok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:44:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50340 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262383AbVCJFk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:40:56 -0500
Message-ID: <422FDDCE.3020806@pobox.com>
Date: Thu, 10 Mar 2005 00:40:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SATA] libata-dev queue updated
Content-Type: multipart/mixed;
 boundary="------------080100070906010706080609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100070906010706080609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Merged recent upstream changes into libata-dev queue.  No new patches 
have found their way into libata-dev since last email.

BK URL, Patch URL, and changelog attached.

Note that the patch is diff'd against 2.6.11-bk6, which won't exist 
until four hours after this email is sent.

	Jeff



--------------080100070906010706080609
Content-Type: text/plain;
 name="libata-dev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev-2.6.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-bk6-libata-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |   18 
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ahci.c          |   95 +++--
 drivers/scsi/ata_adma.c      |  778 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c   |  296 +++++++++-------
 drivers/scsi/libata-scsi.c   |  701 ++++++++++++++++++++++++++++++++------
 drivers/scsi/libata.h        |    6 
 drivers/scsi/pata_pdc2027x.c |  771 ++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   84 ++++
 include/linux/ata.h          |   15 
 include/linux/libata.h       |   10 
 include/scsi/scsi.h          |    3 
 12 files changed, 2507 insertions(+), 272 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

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

Tobias Lorenz:
  o [libata sata_promise] pdc20619 (PATA) support
  o libata-scsi: get-identity ioctl support


--------------080100070906010706080609--
