Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVCOOCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVCOOCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVCOOCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:02:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:59112 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261243AbVCOOB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:01:56 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.60099.277316.423488@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 15:01:39 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] 
Cc: kraxel@bytesex.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one array-of-incomplete-type error from gcc4 in bttvp.h.

/Mikael

--- linux-2.6.11/drivers/media/video/bttvp.h.~1~	2005-03-02 19:24:16.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttvp.h	2005-03-15 12:47:57.000000000 +0100
@@ -230,7 +230,6 @@ extern int fini_bttv_i2c(struct bttv *bt
 /* our devices */
 #define BTTV_MAX 16
 extern unsigned int bttv_num;
-extern struct bttv bttvs[BTTV_MAX];
 
 #define BTTV_MAX_FBUF   0x208000
 #define VBIBUF_SIZE     (2048*VBI_MAXLINES*2)
@@ -378,6 +377,8 @@ struct bttv {
 	struct bttv_fh init;
 };
 
+extern struct bttv bttvs[BTTV_MAX];
+
 /* private ioctls */
 #define BTTV_VERSION            _IOR('v' , BASE_VIDIOCPRIVATE+6, int)
 #define BTTV_VBISIZE            _IOR('v' , BASE_VIDIOCPRIVATE+8, int)
