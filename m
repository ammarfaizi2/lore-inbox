Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVDYTFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVDYTFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVDYTFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:05:23 -0400
Received: from fmr20.intel.com ([134.134.136.19]:23750 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262736AbVDYTEw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:04:52 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: akpm@osdl.org, tiwai@suse.de, perex@suse.cz
Subject: [PATCH 2.6.12-rc3 1/1] hda_intel: patch for Intel ESB2
Date: Mon, 25 Apr 2005 08:19:17 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504250819.17584.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 HD Audio DID to the hda_intel.c audio driver.  This patch was built against the 2.6.12-rc3 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.12-rc3/sound/pci/hda/hda_intel.c.orig	2005-04-25 08:05:09.989614696 -0700
+++ linux-2.6.12-rc3/sound/pci/hda/hda_intel.c	2005-04-25 08:12:48.780867824 -0700
@@ -64,7 +64,8 @@
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
 			 "{Intel, ICH6M},"
-			 "{Intel, ICH7}}");
+			 "{Intel, ICH7},"
+			 "{Intel, ESB2}}");
 MODULE_DESCRIPTION("Intel HDA driver");
 
 #define SFX	"hda-intel: "
@@ -1422,6 +1423,7 @@
 static struct pci_device_id azx_ids[] = {
 	{ 0x8086, 0x2668, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH6 */
 	{ 0x8086, 0x27d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ICH7 */
+	{ 0x8086, 0x269a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* ESB2 */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
