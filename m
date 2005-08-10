Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVHJPvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVHJPvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVHJPvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:51:07 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:40086 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965167AbVHJPvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:51:06 -0400
Subject: [GIT PATCH] final SCSI bug fixes before 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 10:50:57 -0500
Message-Id: <1123689057.5134.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This tree represents the final bug fixes, both for oopses seen by
various people.  One is for the dual binding of the i2o drivers and the
other is for an oops adding and removing devices from the lpfc and
qlogic fibre drivers.

This one has been successfully run through the wringer by the kind
people at Emulex.

The tree is at

www.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is

James Bottomley:
  o Bug 4940 Repeatable Kernel Panic on Adaptec 2015S I20 device on bootup

James Smart:
  o fix target scanning oops with fc transport class

Mark Salyzyn:
  o dpt_i2o pci_request_regions fix

And the diffstat:

 drivers/scsi/dpt_i2o.c           |    9 ++++++++-
 drivers/scsi/scsi_scan.c         |   16 +++++++++++++++-
 drivers/scsi/scsi_transport_fc.c |   19 +++++++++++++++++++
 include/scsi/scsi_transport.h    |    8 ++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

James


