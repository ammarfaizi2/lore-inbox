Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFCP2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFCP2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFCP2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:28:19 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:49839 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261330AbVFCP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:27:56 -0400
Subject: [GITPATCH] two bug fixes for SCSI in 2.6.12-rc5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 10:27:44 -0500
Message-Id: <1117812465.5030.28.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are fixes for a fatal locking problem in qla2xxx and slab
corruption in the ipr driver which need to go in before 2.6.12 final.

The fixes are available here:

rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6.git

The short log is

Andrew Vasquez:
  o qla2xxx: fix bad locking during eh_abort

Nathan T. Lynch:
  o fix slab corruption during ipr probe


And the diffstats:

 qla2xxx/qla_os.c |   24 +++++++++++++-----------
 scsi_scan.c      |    1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

James


