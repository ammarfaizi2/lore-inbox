Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267264AbUHMTYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUHMTYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHMTYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:24:24 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:16106 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267330AbUHMTWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:22:30 -0400
Message-ID: <411D14AD.4090908@ttnet.net.tr>
Date: Fri, 13 Aug 2004 22:21:17 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] various "unused" warnings
Content-Type: multipart/mixed;
	boundary="------------090704020009060608020001"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090704020009060608020001
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

$SUBJECT


--------------090704020009060608020001
Content-Type: text/plain;
	name="riva-unused.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="riva-unused.diff"

--- 27rc5~/drivers/video/riva/fbdev.c	2004-08-07 14:02:36.000000000 +0300
+++ 27rc5/drivers/video/riva/fbdev.c	2004-08-07 14:09:39.000000000 +0300
@@ -2221,7 +2221,6 @@
 	release_mem_region(rinfo->fb_base_phys, rinfo->base1_region_size);
 err_out_free_base0:
 	release_mem_region(rinfo->ctrl_base_phys, rinfo->base0_region_size);
-err_out_kfree:
 	kfree(rinfo);
 err_out:
 	return -ENODEV;

--------------090704020009060608020001
Content-Type: text/plain;
	name="sstfb-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sstfb-fixes.diff"

--- 27rc5~/drivers/video/sstfb.c	2004-02-18 15:36:31.000000000 +0200
+++ 27rc5/drivers/video/sstfb.c	2004-08-07 14:09:39.000000000 +0300
@@ -968,7 +968,6 @@
                        struct fb_info *info)
 {
 #define sst_info	((struct sstfb_info *) info)
-	int i;
 	u_long p;
 	u32 tmp, val;
 	u32 fbiinit0;
@@ -980,12 +979,14 @@
 		
 #if (SST_DEBUG_VAR >0)
 	/* tmp ioctl : dumps fb_display[0-5] */
-	case _IO('F', 0xdb):		/* 0x46db */
+	case _IO('F', 0xdb):		/* 0x46db */ {
+		int i;
 		f_dprintk("dumping fb_display[0-5].var\n");
 		for (i = 0 ; i< 6 ; i++) {
 			print_var(&fb_display[i].var, "var(%d)", i);
 		}
 		return 0;
+	}
 #endif /* (SST_DEBUG_VAR >0) */
 
 	/* fills the lfb up to given count of pixels */

--------------090704020009060608020001
Content-Type: text/plain;
	name="matroxfb_g450-unused.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="matroxfb_g450-unused.diff"

--- 27rc5~/drivers/video/matrox/matroxfb_g450.c	2003-06-13 17:51:37.000000000 +0300
+++ 27rc5/drivers/video/matrox/matroxfb_g450.c	2004-08-07 14:09:39.000000000 +0300
@@ -558,7 +558,7 @@
 }
 
 static int matroxfb_g450_verify_mode(void* md, u_int32_t arg) {
-	MINFO_FROM(md);
+//	MINFO_FROM(md);
 	
 	switch (arg) {
 		case MATROXFB_OUTPUT_MODE_PAL:

--------------090704020009060608020001
Content-Type: text/plain;
	name="sddr09-unused.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sddr09-unused.diff"

--- 27rc5~/drivers/usb/storage/sddr09.c	2003-08-25 14:44:42.000000000 +0300
+++ 27rc5/drivers/usb/storage/sddr09.c	2004-08-07 14:09:39.000000000 +0300
@@ -444,6 +444,7 @@
  * byte 0: opcode: 03
  * byte 4: data length
  */
+#if 0
 static int
 sddr09_request_sense(struct us_data *us, unsigned char *sensebuf, int buflen) {
 	unsigned char command[12] = {
@@ -465,7 +466,7 @@
 
 	return result;
 }
-
+#endif
 /*
  * Read Command: 12 bytes.
  * byte 0: opcode: E8

--------------090704020009060608020001--
