Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWB1RbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWB1RbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWB1RbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:31:05 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:43730 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932283AbWB1Rax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:30:53 -0500
Subject: [GIT PATCH] SCSI bug fixes for 2.6.16-rc5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Feb 2006 11:30:47 -0600
Message-Id: <1141147847.3258.19.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents the current batch of outstanding bug fixes (mostly
driver bug fixes, but one mid-layer update to support fixing a driver
bug).

The patch is available from:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The Short changelog is:

Andrew Vasquez:
  o fc_transport: stop creating duplicate rport entries

Brian King:
  o scsi: scsi command retries off by one fix
  o sg: Remove aha1542 hack

Christoph Hellwig:
  o megaraid_sas: fix physical disk handling
  o scsi: handle ->slave_configure return value

J�gen E. Fischer:
  o aha152x: fix variable use before initialisation and other bugs

Matthew Wilcox:
  o Fix uninitialised width and speed in sym2

Ralf B�hle:
  o Delete duplicate driver template

And the diffstat:

 aha152x.c               |   85 +++++++++++++++++++++++++++++-------------------
 aha152x.h               |    2 -
 jazz_esp.c              |   21 -----------
 megaraid/megaraid_sas.c |   29 ++++++++--------
 pcmcia/aha152x_stub.c   |    4 --
 scsi_error.c            |    4 +-
 scsi_lib.c              |    2 -
 scsi_scan.c             |   16 +++++++--
 scsi_transport_fc.c     |    3 -
 sg.c                    |    2 -
 sym53c8xx_2/sym_hipd.c  |    2 +
 11 files changed, 90 insertions(+), 80 deletions(-)

James


