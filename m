Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVCJTgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVCJTgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVCJTcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:32:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64673 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262962AbVCJT1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:27:13 -0500
Message-ID: <42309F7A.6090207@pobox.com>
Date: Thu, 10 Mar 2005 14:26:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SATA] libata-2.4 backport queue updated
Content-Type: multipart/mixed;
 boundary="------------000505040601020808010001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000505040601020808010001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Updated libata 2.4.x branch to 2.4.30-pre3.

Patch URL, BK URL, and list of changes attached.

	Jeff



--------------000505040601020808010001
Content-Type: text/plain;
 name="libata-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.4.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.4

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.30-pre3-libata1.patch.bz2

This will update the following files:

 Documentation/DocBook/Makefile    |    2 
 Documentation/DocBook/libata.tmpl |    5 ++
 drivers/pci/quirks.c              |   85 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ahci.c               |   15 +++++-
 drivers/scsi/ata_piix.c           |    3 -
 drivers/scsi/libata-core.c        |   24 ++++++++--
 include/linux/ioport.h            |    1 
 kernel/ksyms.c                    |    1 
 kernel/resource.c                 |   10 ++++
 9 files changed, 138 insertions(+), 8 deletions(-)

through these ChangeSets:

Arjan van de Ven:
  o [libata ata_piix] Use standard headers from include/scsi, not drivers/scsi

Brett Russ:
  o AHCI: fix fatal error int handling

Jason Gaston:
  o [PCI] update SATA PCI quirk for Intel ICH7

Jeff Garzik:
  o [libata ahci] support ->tf_read hook
  o [PCI, libata] Fix "combined mode" PCI quirk for ICH6
  o [libata ata_piix] re-enable combined mode support
  o [libata ata_piix] ->qc_prep hook
  o [libata ata_piix] fix DocBook docs
  o [libata ata_piix] add ->bmdma_setup hook
  o [libata] re-merge the rest of the 2.4 junk


--------------000505040601020808010001--
