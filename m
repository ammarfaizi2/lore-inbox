Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbUCNF6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbUCNF6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:58:49 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:64739 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263297AbUCNF6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:58:38 -0500
Subject: [BK PATCH] another SCSI update for 2.6.4
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Mar 2004 00:58:32 -0500
Message-Id: <1079243914.2512.109.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main reason for this one is to pick up the oops on removal USB bug
that was triggered by an error in the transport class removal routines.

The patch is available from

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

James Bottomley:
  o Add Domain Validation to 53c700 driver
  o Fix removable USB drive oops
  o Add Domain Validation to the SPI transport class
  o update the 53c700 use of transport attributes
  o more SPI transport attribute updates
  o add device quiescing to the SCSI API
  o MPT Fusion driver 3.01.01 update

Mark Haverkamp:
  o add adapter support to aacraid driver (update)
  o aacraid driver patch

Matthew Wilcox:
  o sym2 2.1.18i


The diffstats are:

 Documentation/scsi/sym53c8xx_2.txt   |    4 
 drivers/message/fusion/mptbase.h     |    4 
 drivers/message/fusion/mptscsih.c    |   49 ++--
 drivers/scsi/53c700.c                |   33 ++
 drivers/scsi/aacraid/linit.c         |   12 -
 drivers/scsi/aacraid/rkt.c           |    1 
 drivers/scsi/aacraid/rx.c            |    1 
 drivers/scsi/aacraid/sa.c            |    1 
 drivers/scsi/scsi.c                  |    2 
 drivers/scsi/scsi_lib.c              |  107 ++++++++
 drivers/scsi/scsi_scan.c             |    4 
 drivers/scsi/scsi_sysfs.c            |   22 +
 drivers/scsi/scsi_transport_spi.c    |  417
+++++++++++++++++++++++++++++++++--
 drivers/scsi/sym53c8xx_2/sym53c8xx.h |    7 
 drivers/scsi/sym53c8xx_2/sym_defs.h  |  129 ----------
 drivers/scsi/sym53c8xx_2/sym_fw.c    |   12 -
 drivers/scsi/sym53c8xx_2/sym_glue.c  |  138 ++++-------
 drivers/scsi/sym53c8xx_2/sym_glue.h  |   29 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c  |   21 -
 drivers/scsi/sym53c8xx_2/sym_hipd.h  |   54 ----
 drivers/scsi/sym53c8xx_2/sym_misc.c  |    3 
 drivers/scsi/sym53c8xx_2/sym_misc.h  |   91 -------
 drivers/scsi/sym53c8xx_2/sym_nvram.c |   64 ++++-
 drivers/scsi/sym53c8xx_2/sym_nvram.h |  216 ++++++++++++++++++
 include/scsi/scsi_device.h           |    9 
 include/scsi/scsi_transport_spi.h    |   33 ++
 26 files changed, 997 insertions(+), 466 deletions(-)

James


