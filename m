Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQK3XRF>; Thu, 30 Nov 2000 18:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbQK3XQz>; Thu, 30 Nov 2000 18:16:55 -0500
Received: from groupwise.hlyw.com ([207.115.234.141]:59658 "HELO hlyw.com")
	by vger.kernel.org with SMTP id <S129572AbQK3XQl> convert rfc822-to-8bit;
	Thu, 30 Nov 2000 18:16:41 -0500
Message-Id: <sa26679d.082@hlyw.com>
X-Mailer: Novell GroupWise 5.5.2
Date: Thu, 30 Nov 2000 14:43:15 -0800
From: "Richard Pries" <PriesRx@hlyw.com>
To: <axboe@suse.de>
Cc: "Glen Gerber" <GlenG.CORP.HLYW@hlyw.com>, <linux-kernel@vger.kernel.org>
Subject: [Patch] Correct cdrom.h comments.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

The following patch corrects the comments in cdrom.h for CDROMREADRAW, CDROMREADMODE1, and CDROMREADMODE2 that erroneously refer to the cdrom_read structure.  With this patch, they refer to the cdrom_msf structure.

--- /usr/src/linux-2.2.17/include/linux/cdrom.h	Wed Nov 29 10:34:29 2000
+++ /usr/src/linux-2.2.17rap/include/linux/cdrom.h	Thu Nov 30 14:23:32 2000
@@ -66,9 +66,9 @@
 #define CDROMSUBCHNL		0x530b /* Read subchannel data 
                                            (struct cdrom_subchnl) */
 #define CDROMREADMODE2		0x530c /* Read CDROM mode 2 data (2336 Bytes) 
-                                           (struct cdrom_read) */
+                                           (struct cdrom_msf) */
 #define CDROMREADMODE1		0x530d /* Read CDROM mode 1 data (2048 Bytes)
-                                           (struct cdrom_read) */
+                                           (struct cdrom_msf) */
 #define CDROMREADAUDIO		0x530e /* (struct cdrom_read_audio) */
 #define CDROMEJECT_SW		0x530f /* enable(1)/disable(0) auto-ejecting */
 #define CDROMMULTISESSION	0x5310 /* Obtain the start-of-last-session 
@@ -82,7 +82,7 @@
 #define CDROMVOLREAD		0x5313 /* Get the drive's volume setting 
                                           (struct cdrom_volctrl) */
 #define CDROMREADRAW		0x5314	/* read data in raw mode (2352 Bytes)
-                                           (struct cdrom_read) */
+                                           (struct cdrom_msf) */
 /* 
  * These ioctls are used only used in aztcd.c and optcd.c
  */
@@ -159,7 +159,9 @@
 	int			lba;
 };
 
-/* This struct is used by the CDROMPLAYMSF ioctl */ 
+/* This struct is used by the CDROMPLAYMSF, CDROMREADRAW, CDROMREADMODE1, 
+ * and CDROMREADMODE2 ioctls.
+ */
 struct cdrom_msf 
 {
 	__u8	cdmsf_min0;	/* start minute */
@@ -219,8 +221,7 @@
 	union cdrom_addr cdte_addr;
 	__u8	cdte_datamode;
 };
-
-/* This struct is used by the CDROMREADMODE1, and CDROMREADMODE2 ioctls */
+ 
 struct cdrom_read      
 {
 	int	cdread_lba;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
