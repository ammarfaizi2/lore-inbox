Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTEZEpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTEZEpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:45:23 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:52398
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264231AbTEZEpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:45:22 -0400
Date: Mon, 26 May 2003 00:58:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] add ata scsi driver
Message-ID: <20030526045833.GA27204@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to echo some comments I said in private, this driver is _not_
a replacement for drivers/ide.  This is not, and has never been,
the intention.  In fact, I need drivers/ide's continued existence,
so that I may have fewer boundaries on future development.

Even though ATAPI support doesn't exist and error handling is
primitive, this driver has been extensively tested locally and I feel
is ready for a full and public kernel developer assault :)

James ok'd sending this...  I'll be sending "un-hack scsi headers" patch
through him via his scsi-misc-2.5 tree.




Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/scsi-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk18-scsi1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig    |   27 
 drivers/scsi/Makefile   |    1 
 drivers/scsi/ata_piix.c |  322 ++++++
 drivers/scsi/libata.c   | 2247 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ata.h     |  485 ++++++++++
 5 files changed, 3082 insertions(+)

through these ChangeSets:

<jgarzik@redhat.com> (03/05/26 1.1357)
   [scsi ata] make PATA config option actually do something useful

<jgarzik@redhat.com> (03/05/26 1.1356)
   [scsi ata] include hacks, b/c scsi headers not in include/linux

<jgarzik@redhat.com> (03/05/26 1.1355)
   [scsi] add ATA driver

