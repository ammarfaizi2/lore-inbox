Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTKMROL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTKMROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:14:11 -0500
Received: from vpn-19-5.aset.psu.edu ([146.186.19.5]:24961 "EHLO
	funkmachine.cac.psu.edu") by vger.kernel.org with ESMTP
	id S264353AbTKMROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:14:08 -0500
Message-ID: <3FB3BBE0.D4D0EACC@psu.edu>
Date: Thu, 13 Nov 2003 12:14:08 -0500
From: Jason Holmes <jholmes@psu.edu>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19-pre3-rmap12h i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make 2.6 megaraid recognize intel vendor id
Content-Type: multipart/mixed;
 boundary="------------3A8963A11DAC098267A4157D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3A8963A11DAC098267A4157D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

The 2.4 megaraid driver recognizes the Intel PCI vendor id whereas the
2.6 driver does not.  The attached patch against 2.6.0-test9 adds the
missing two lines from the 2.4 driver to enable this.

Thanks,

--
Jason Holmes
--------------3A8963A11DAC098267A4157D
Content-Type: text/plain; charset=us-ascii;
 name="2.6.0-test9-megaraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.0-test9-megaraid.patch"

diff -uNr linux-2.6.0-test9.clean/drivers/scsi/megaraid.c linux-2.6.0-test9/drivers/scsi/megaraid.c
--- linux-2.6.0-test9.clean/drivers/scsi/megaraid.c	Sat Oct 25 14:42:42 2003
+++ linux-2.6.0-test9/drivers/scsi/megaraid.c	Thu Nov 13 06:58:04 2003
@@ -295,6 +295,7 @@
 		if( subsysvid && (subsysvid != AMI_SUBSYS_VID) &&
 				(subsysvid != DELL_SUBSYS_VID) &&
 				(subsysvid != HP_SUBSYS_VID) &&
+				(subsysvid != INTEL_SUBSYS_VID) &&
 				(subsysvid != LSI_SUBSYS_VID) ) continue;
 
 
diff -uNr linux-2.6.0-test9.clean/drivers/scsi/megaraid.h linux-2.6.0-test9/drivers/scsi/megaraid.h
--- linux-2.6.0-test9.clean/drivers/scsi/megaraid.h	Sat Oct 25 14:43:42 2003
+++ linux-2.6.0-test9/drivers/scsi/megaraid.h	Thu Nov 13 06:56:20 2003
@@ -82,6 +82,7 @@
 #define DELL_SUBSYS_VID			0x1028
 #define	HP_SUBSYS_VID			0x103C
 #define LSI_SUBSYS_VID			0x1000
+#define INTEL_SUBSYS_VID		0x8086
 
 #define HBA_SIGNATURE	      		0x3344
 #define HBA_SIGNATURE_471	  	0xCCCC

--------------3A8963A11DAC098267A4157D--

