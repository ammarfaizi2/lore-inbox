Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbULTSTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbULTSTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULTSTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:19:55 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:10150 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261596AbULTSTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:19:50 -0500
Subject: [BK PATCH] last scsi fixes for 2.6.10-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 12:19:33 -0600
Message-Id: <1103566774.5267.62.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are all small and fairly essential fixes (except for one minor
piece of code removal which crept into the wrong bucket but should be
harmless) that I'd like to get in before 2.6.10

the patch is available at

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

Adrian Bunk:
  o scsi/qla2xxx/qla_rscn.c: remove unused functions

James Bottomley:
  o Fix cable pull problem with USB storage

Jens Axboe:
  o hack imm.c to work in highmem machines

Mark Haverkamp:
  o aacraid: 2.6 fix panic on module removal

Sreenivas Bagalkote:
  o megaraid: fix a bug in kioc dma buffer deallocation

And the diffstat is

 Documentation/scsi/ChangeLog.megaraid  |    7 ++++++
 drivers/scsi/aacraid/linit.c           |    3 --
 drivers/scsi/imm.c                     |    4 +++
 drivers/scsi/megaraid/megaraid_ioctl.h |    2 -
 drivers/scsi/megaraid/megaraid_mm.c    |   34 ++++++++++++++++++---------------
 drivers/scsi/megaraid/megaraid_mm.h    |    5 +---
 drivers/scsi/qla2xxx/qla_rscn.c        |   26 -------------------------
 drivers/scsi/sd.c                      |    2 -
 drivers/scsi/sr.c                      |    2 -
 9 files changed, 36 insertions(+), 49 deletions(-)

James


