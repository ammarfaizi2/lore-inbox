Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUIOQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUIOQNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIOQLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:11:40 -0400
Received: from [69.28.190.101] ([69.28.190.101]:31635 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266648AbUIOQKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:10:30 -0400
Date: Wed, 15 Sep 2004 12:10:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [sata] new libata-dev-2.6 queue created (AHCI, SATA bridges)
Message-ID: <20040915161026.GA31360@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"libata-dev-2.6" is a new patch queue for SATA features which are under
development, or need additional testing before being deployed into the
upstream-bound libata-2.[46] queues.

It currently contains:

1) A workaround for problems on multiple SATA controllers when using
PATA disks attached via SATA bridges.

2) New driver AHCI.  This should currently be considered a technology
preview or early beta test.  Simply because it is a young driver on
complicated hardware, using a new "FIS-based" delivery method (read:
brand new hotpath), caution is advised.  Do not use in production yet.


I have updated my SATA status page to reflect these updates:
	http://linux.yyz.us/sata/sata-status.html


BK users:
bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch (NOTE: relative to 2.6.9-rc2-bk1-libata1.patch):
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc2-bk1-libata1-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig       |    8 
 drivers/scsi/Makefile      |    1 
 drivers/scsi/ahci.c        |  973 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c |   37 +
 include/linux/ata.h        |    1 
 include/linux/libata.h     |    1 
 6 files changed, 1018 insertions(+), 3 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/09/15 1.1905)
   [libata] add AHCI driver

<brad@wasp.net.au> (04/09/15 1.1902.1.1)
   [PATCH] libata basic detection and errata for PATA->SATA bridges
   
   This patch works around an issue with WD drives (and possibly others) over SiL PATA->SATA Bridges on SATA controllers locking up with transfers > 200 sectors.
   
   Signed-off-by: Brad Campbell <brad@wasp.net.au>

