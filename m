Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUATAtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUATArJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:47:09 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:27019 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265352AbUATAqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:46:50 -0500
Subject: [BK PATCH] SCSI bug fixes for 2.6.1
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074539066.1647.32.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Jan 2004 19:46:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached is specifically bugfixes only for 2.6.1 that I'd like to
get in before we begin release candidates for 2.6.2.  Some of them are
bug fix only pieces from driver updates that I'll begin pushing after
2.6.2 is out.

The update is available at:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is

<andrew.vasquez:qlogic.com>:
  o No LUNs detected with qla2xxx / qla2300

<emoore:lsil.com>:
  o MPT Fusion x86-64 boot fix

<mort:bork.org>:
  o Fix error path when adding sysfs attributes

Andrew Morton:
  o fix qla2xxx build for older gcc's

James Bottomley:
  o aha152x PCMCIA fix

Jes Sorensen:
  o qla1280 update

Mike Anderson:
  o scsi_eh_flush_done_q return status

The diffstats are

 message/fusion/mptbase.h  |    4 -
 message/fusion/mptscsih.c |    4 +
 scsi/aha152x.c            |    2 
 scsi/qla1280.c            |  133 ++++++++++++++++++++++++++++++----------------
 scsi/qla1280.h            |   23 ++++---
 scsi/qla2xxx/qla_def.h    |    6 +-
 scsi/qla2xxx/qla_init.c   |    2 
 scsi/scsi_error.c         |   28 ++++-----
 scsi/scsi_sysfs.c         |   11 ++-
 9 files changed, 134 insertions(+), 79 deletions(-)

James


