Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUAFJJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUAFJJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:09:20 -0500
Received: from host249-74.pool80117.interbusiness.it ([80.117.74.249]:59556
	"EHLO noriega.dopenet.org") by vger.kernel.org with ESMTP
	id S261681AbUAFJJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:09:14 -0500
Subject: [PATCH][SCSI][kernel 2.6.0]
From: noreaga <noreaga@virgilio.it>
Reply-To: noreaga@virgilio.it
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: text/plain
Message-Id: <1073379928.244.11.camel@gianplacido.dopenet.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 10:05:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix wrong data types in include/scsi/scsi.h


in file include/scsi/scsi.h (lines 203 to 221, structs css_modsel_head
and scsi_lun) i found data types u8 instead of __u8.

massimiliano picco
noreaga@virgilio.it



--- linux-2.6.0/include/scsi/scsi.h     2003-12-18 03:59:54.000000000
+0100
+++ linux/include/scsi/scsi.h   2004-01-02 22:05:11.000000000 +0100
@@ -200,25 +200,25 @@
  */
                                                                                                                               
 struct ccs_modesel_head {
-       u8 _r1;                 /* reserved */
-       u8 medium;              /* device-specific medium type */
-       u8 _r2;                 /* reserved */
-       u8 block_desc_length;   /* block descriptor length */
-       u8 density;             /* device-specific density code */
-       u8 number_blocks_hi;    /* number of blocks in this block desc */
-       u8 number_blocks_med;
-       u8 number_blocks_lo;
-       u8 _r3;
-       u8 block_length_hi;     /* block length for blocks in this desc */
-       u8 block_length_med;
-       u8 block_length_lo;
+       __u8 _r1;                       /* reserved */
+       __u8 medium;            /* device-specific medium type */
+       __u8 _r2;                       /* reserved */
+       __u8 block_desc_length; /* block descriptor length */
+       __u8 density;           /* device-specific density code */
+       __u8 number_blocks_hi;  /* number of blocks in this block desc */
+       __u8 number_blocks_med;
+       __u8 number_blocks_lo;
+       __u8 _r3;
+       __u8 block_length_hi;   /* block length for blocks in this desc */
+       __u8 block_length_med;
+       __u8 block_length_lo;
 };
                                                                                                                               
 /*
  * ScsiLun: 8 byte LUN.
  */
 struct scsi_lun {
-       u8 scsi_lun[8];
+       __u8 scsi_lun[8];
 };
                                                                                                                               
 /*

