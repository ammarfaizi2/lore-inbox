Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVLUWyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVLUWyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVLUWyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:54:47 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:46991 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964913AbVLUWyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:54:46 -0500
Subject: [GIT PATCH] SCSI bug fixes for 2.6.15-rc6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 16:54:26 -0600
Message-Id: <1135205667.3533.79.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully these are the final two bug fixes before 2.6.15 (hint, hurry
up!).

The update is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

James Bottomley:
  o fix scsi_reap_target() device_del from atomic context

James Smart:
  o fix for fc transport recursion problem

And the diffstat:

 drivers/scsi/scsi_scan.c         |   48 +++++++++++++++++++++++++------
 drivers/scsi/scsi_transport_fc.c |   59 ++++++++++++++++++++++++++++++++++++---
 include/scsi/scsi_transport_fc.h |   11 +++++++
 3 files changed, 104 insertions(+), 14 deletions(-)

James


