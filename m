Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbULJD5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbULJD5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 22:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbULJD5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 22:57:01 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:63910 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261654AbULJD4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 22:56:42 -0500
Subject: [BK PATCH] SCSI -rc fixes for 2.6.10-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SteelEye Technology, inc.
Date: Thu, 09 Dec 2004 21:56:28 -0600
Message-Id: <1102650988.3814.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is another set of small driver fixes

It is available from:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

Andreas Herrmann:
  o zfcp: act enhancements corrections

Castor Fu:
  o support for 3PAR sparse SCSI LUNs

Douglas Gilbert:
  o extracting resid from struct scsi_cmnd

Eric Moore:
  o mptfusion: kill fusion init called
  o mptfusion: resid cleanup
  o mptfusion: replace chip_type
  o mptfusion: streamline queuecommand
  o mptfusion: streamline slave_alloc
  o mptfusion: delete MPTSCSIH_DBG_TIMEOUT

James Bottomley:
  o aic7xxx: fix compiler warning from dma mask assignement
  o mptfusion: command line parameters

Mark Haverkamp:
  o 2.6.9 aacraid: Support ROMB RAID/SCSI mode - Resend -

Matthew Wilcox:
  o Blacklist devices that falsely claim an echo buffer
  o SCSI: spi_transport set_signalling is buggy

Mike Miller:
  o cciss: cciss_ioctl return code fix


And the diffstat is:

 block/cciss.c                  |    2 
 message/fusion/mptbase.c       |   83 +----
 message/fusion/mptbase.h       |   36 --
 message/fusion/mptctl.c        |    8 
 message/fusion/mptscsih.c      |  633 ++++++++++-------------------------------
 message/fusion/mptscsih.h      |   11 
 s390/scsi/zfcp_def.h           |    4 
 s390/scsi/zfcp_erp.c           |   38 +-
 s390/scsi/zfcp_ext.h           |    4 
 s390/scsi/zfcp_fsf.c           |   53 ---
 s390/scsi/zfcp_scsi.c          |    3 
 scsi/Kconfig                   |    2 
 scsi/aacraid/aachba.c          |   46 ++
 scsi/aacraid/aacraid.h         |    3 
 scsi/aic7xxx/aic79xx_osm.h     |    2 
 scsi/aic7xxx/aic79xx_osm_pci.c |   14 
 scsi/aic7xxx/aic7xxx_osm.h     |    2 
 scsi/aic7xxx/aic7xxx_osm_pci.c |    7 
 scsi/scsi_devinfo.c            |    1 
 scsi/scsi_lib.c                |    2 
 scsi/scsi_transport_spi.c      |    9 
 21 files changed, 292 insertions(+), 671 deletions(-)

James

