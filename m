Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTFJVgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTFJVfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:35:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39044 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263823AbTFJShI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:08 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270967992@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709671561@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1351, 2003/06/09 16:01:36-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/BusLogic.c


 drivers/scsi/BusLogic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
--- a/drivers/scsi/BusLogic.c	Tue Jun 10 11:19:48 2003
+++ b/drivers/scsi/BusLogic.c	Tue Jun 10 11:19:48 2003
@@ -1183,7 +1183,7 @@
     If a PCI BIOS is present, interrogate it for MultiMaster and FlashPoint
     Host Adapters; otherwise, default to the standard ISA MultiMaster probe.
   */
-  if (!BusLogic_ProbeOptions.NoProbePCI && pci_present())
+  if (!BusLogic_ProbeOptions.NoProbePCI)
     {
       if (BusLogic_ProbeOptions.MultiMasterFirst)
 	{
@@ -5133,3 +5133,4 @@
 	.use_clustering		= ENABLE_CLUSTERING,
 };
 #include "scsi_module.c"
+

