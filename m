Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTFJUzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFJUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:54:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9391 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263915AbTFJShQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:16 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709682208@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709683613@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1366, 2003/06/09 16:09:41-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/sym53c8xx_comm.h


 drivers/scsi/sym53c8xx_comm.h |    8 --------
 1 files changed, 8 deletions(-)


diff -Nru a/drivers/scsi/sym53c8xx_comm.h b/drivers/scsi/sym53c8xx_comm.h
--- a/drivers/scsi/sym53c8xx_comm.h	Tue Jun 10 11:18:29 2003
+++ b/drivers/scsi/sym53c8xx_comm.h	Tue Jun 10 11:18:29 2003
@@ -319,8 +319,6 @@
 #define PciDeviceFn(d)		((d)&0xff)
 #define __PciDev(busn, devfn)	(((busn)<<8)+(devfn))
 
-#define pci_present pcibios_present
-
 #define pci_read_config_byte(d, w, v) \
 	pcibios_read_config_byte(PciBusNumber(d), PciDeviceFn(d), w, v)
 #define pci_read_config_word(d, w, v) \
@@ -2530,12 +2528,6 @@
 #ifdef SCSI_NCR_NVRAM_SUPPORT
 	ncr_nvram  nvram0, nvram, *nvp;
 #endif
-
-	/*
-	**    PCI is required.
-	*/
-	if (!pci_present())
-		return 0;
 
 #ifdef SCSI_NCR_DEBUG_INFO_SUPPORT
 	ncr_debug = driver_setup.debug;

