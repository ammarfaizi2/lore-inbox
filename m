Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVC3Un3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVC3Un3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVC3Un3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:43:29 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:46991 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261577AbVC3Um4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:42:56 -0500
Subject: [BK PATCH] SCSI updates for 2.6.12-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 14:42:46 -0600
Message-Id: <1112215366.5452.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first batch of -rc patches.  I have other patches pending
that I'm going to sort into the -rc patches and the post -rc ones.

The patch is available here:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

adam radford:
  o 3ware 9000 driver update

Adrian Bunk:
  o drivers/scsi/osst.c: remove unused code
  o drivers/scsi/osst.c: make code static

Alan Cox:
  o atp870u DMA mask fix
  o atp870u: Re-merge cleanups

Alan Stern:
  o Add a scsi_device flag for RETRY_HWERROR

Eric Moore:
  o Make Fusion-MPT much faster as module

James Bottomley:
  o Fix SCSI internal requests hang
  o 3ware driver update
  o 53c700: Alter interrupt assignment
  o SCSI: Re-export code incorrectly made static
  o ncr53c8xx: Fix small problem with initial negotiation
  o Q720: fix compile warning
  o fix breakage in the SCSI generic tag code

Jens Axboe:
  o queue <-> sdev reference counting problem

Mark Haverkamp:
  o aacraid: endian cleanup

Matthew Wilcox:
  o Fix small bug in scsi_transport_spi
  o ncr53c8xx update
  o Zalon updates
  o Misc Lasi 700 fixes

Mike Christie:
  o fix fc class work queue usage
  o rm unused scan delay var

Randy Dunlap:
  o scsi_sysfs: use NULL instead of 0


The diffstat is:

 drivers/message/fusion/mptbase.h  |    4 
 drivers/message/fusion/mptscsih.c |   92 +++---
 drivers/message/fusion/mptscsih.h |    8 
 drivers/scsi/3w-9xxx.c            |  516 +++++++++++++++++++-------------------
 drivers/scsi/3w-9xxx.h            |   88 ++----
 drivers/scsi/3w-xxxx.c            |  366 ++++++++++++--------------
 drivers/scsi/3w-xxxx.h            |    3 
 drivers/scsi/53c700.c             |   25 -
 drivers/scsi/53c700.h             |    4 
 drivers/scsi/NCR_D700.c           |   41 ++-
 drivers/scsi/NCR_Q720.c           |    2 
 drivers/scsi/aacraid/aachba.c     |  149 ++++++----
 drivers/scsi/aacraid/aacraid.h    |  191 +++++++-------
 drivers/scsi/aacraid/commctrl.c   |   12 
 drivers/scsi/aacraid/comminit.c   |    2 
 drivers/scsi/aacraid/commsup.c    |   25 -
 drivers/scsi/aacraid/rkt.c        |   21 -
 drivers/scsi/aacraid/rx.c         |   18 -
 drivers/scsi/aacraid/sa.c         |   28 --
 drivers/scsi/atp870u.c            |  341 ++++++++++++++++---------
 drivers/scsi/hosts.c              |   17 +
 drivers/scsi/lasi700.c            |   17 -
 drivers/scsi/ncr53c8xx.c          |  508 +++++++++++++++----------------------
 drivers/scsi/osst.c               |    7 
 drivers/scsi/scsi_error.c         |    6 
 drivers/scsi/scsi_lib.c           |   36 ++
 drivers/scsi/scsi_scan.c          |    3 
 drivers/scsi/scsi_sysfs.c         |   22 -
 drivers/scsi/scsi_transport_fc.c  |    8 
 drivers/scsi/scsi_transport_spi.c |    9 
 drivers/scsi/sim710.c             |   12 
 drivers/scsi/sym53c8xx_defs.h     |   54 +--
 drivers/scsi/zalon.c              |   23 -
 include/scsi/scsi_device.h        |    1 
 include/scsi/scsi_host.h          |    1 
 include/scsi/scsi_transport_fc.h  |    3 
 36 files changed, 1367 insertions(+), 1296 deletions(-)

James


