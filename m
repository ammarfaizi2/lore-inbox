Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVJVQPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVJVQPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJVQPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:15:37 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:45202 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751364AbVJVQPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:15:37 -0400
Subject: [GIT PATCH] SCSI bug fixes for 2.6.14-rc5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 16:15:28 +0000
Message-Id: <1129997728.6461.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents hopefully the final bug fixes for 2.6.14-rc5

The patch is here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git

The short changelog is:

Alan Stern:
  o Fix leak of Scsi_Cmnds

Christoph Hellwig:
  o mptsas: fix phy identifiers

James Smart:
  o FW: [PATCH] for Deadlock in transport_fc

Karl Magnus Kolstoe:
  o 2.6.13.3; add Pioneer DRM-624x to drivers/scsi/scsi_devinfo.c

Mark Salyzyn:
  o Fix aacraid regression

Randy Dunlap:
  o NCR5380: fix undefined preprocessor identifier

Steven Rostedt:
  o scsi_error thread exits in TASK_INTERRUPTIBLE state

And the diffstat:

 message/fusion/mptsas.c  |   12 ++++++++----
 scsi/NCR5380.c           |    2 +-
 scsi/aacraid/aacraid.h   |    2 +-
 scsi/scsi_devinfo.c      |    1 +
 scsi/scsi_error.c        |    2 ++
 scsi/scsi_lib.c          |    7 ++++---
 scsi/scsi_transport_fc.c |   13 ++++++++++---
 7 files changed, 27 insertions(+), 12 deletions(-)

James


