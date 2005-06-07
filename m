Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVFGSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVFGSqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVFGSqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:46:34 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:37896 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261873AbVFGSqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:46:31 -0400
Date: Tue, 7 Jun 2005 20:47:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-Id: <20050607204733.1a48e5dc.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> Alan Cox:
>   remove non-cleanroom pwc driver compression

This one triggers a compilation warning. Proposed fix:

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/usb/media/pwc/pwc-uncompress.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc6.orig/drivers/usb/media/pwc/pwc-uncompress.c	2005-06-07 07:14:50.000000000 +0200
+++ linux-2.6.12-rc6/drivers/usb/media/pwc/pwc-uncompress.c	2005-06-07 20:35:12.000000000 +0200
@@ -120,7 +120,6 @@
 
 		switch (pdev->type)
 		 {
-#if 0		 
 		  case 675:
 		  case 680:
 		  case 690:
@@ -128,15 +127,16 @@
 		  case 730:
 		  case 740:
 		  case 750:
+#if 0
 		    pwc_dec23_decompress(&pdev->image, &pdev->view, &pdev->offset,
 				yuv, image,
 				flags,
 				pdev->decompress_data, pdev->vbandlength);
 		    break;
+#endif
 		  case 645:
 		  case 646:
 		    /* TODO & FIXME */
-#endif		    
 		    return -ENXIO; /* No such device or address: missing decompressor */
 		    break;
 		 }


-- 
Jean Delvare
