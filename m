Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVBMUeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVBMUeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 15:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVBMUeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 15:34:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10135 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261303AbVBMUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 15:33:54 -0500
Message-ID: <420FB9A3.1090002@pobox.com>
Date: Sun, 13 Feb 2005 15:33:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [SATA] libata-dev queue updated
Content-Type: multipart/mixed;
 boundary="------------060103060109090905030401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103060109090905030401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A minor update since the last post.  Recent changes:

* updated to 2.6.11-rc4, posted patch (see attached).

* turned on ATAPI by default.  If you got an S/ATAPI DVD burner for 
Christmas, you'll like this.

WARNING DANGER WARNING:  Some drivers such as sata_promise and ahci have 
not yet been updated to support ATAPI.

More details on patch/BK/changes attached.


--------------060103060109090905030401
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc4-libata-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |   18 -
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ata_adma.c      |  636 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c   |  174 +++-------
 drivers/scsi/libata-scsi.c   |  409 +++++++++++++++++++++++
 drivers/scsi/libata.h        |    6 
 drivers/scsi/pata_pdc2027x.c |  742 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   84 ++++
 drivers/scsi/sata_via.c      |  202 ++++++++---
 include/linux/ata.h          |    1 
 include/linux/libata.h       |    4 
 include/scsi/scsi.h          |    3 
 12 files changed, 2096 insertions(+), 185 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

Adam J. Richter:
  o ata_pci_remove_one used freed memory

Albert Lee:
  o pdc2027x timing register bug fix
  o [libata pdc2027x] fix incorrect pio and mwdma masks
  o [libata pdc2027x] remove quirks and ROM enable
  o [libata] add driver for Promise PATA 2027x

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
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
  o libata: SMART support via ATA pass-thru

Tobias Lorenz:
  o [libata sata_promise] pdc20619 (PATA) support
  o libata-scsi: get-identity ioctl support


--------------060103060109090905030401--
