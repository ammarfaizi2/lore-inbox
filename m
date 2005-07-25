Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVGYTs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVGYTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVGYTnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:43:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63478 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261479AbVGYTnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:43:33 -0400
Subject: Re: [PATCH] jsm driver - Linux-2.6.12.3
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, rmk+lkml@arm.linux.org.uk, akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-V7s29rv7q3vKprVsie58"
Date: Mon, 25 Jul 2005 14:34:35 -0500
Message-Id: <1122320075.3730.30.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V7s29rv7q3vKprVsie58
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

  I would like to rescind the patch that was posted here on Jul 19, 2005
with the subject [PATCH] jsm driver - Linux-2.6.12.3, since I am
submitting the patch against development kernel-2.6.13-rc3. The patch
takes care of the major device number change. A full description of the
change is given below.

  In the kernel-2.6.12.3 version, the jsm driver uses a static number of
253.  The major number 253 is a reserved for "LOCAL/EXPERIMENTAL USE" by
both char and block devices.  So the current patch takes advantage of
the dynamic allocation of major number by the kernel.
 
  Please CC me your comments.  Thanks.
  Signed-off-by: V. Ananda Krishnan <mansarov@us.ibm.com>
                                    



--=-V7s29rv7q3vKprVsie58
Content-Disposition: attachment; filename=patch_jsm_korg-072505
Content-Type: text/x-patch; name=patch_jsm_korg-072505; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.12.3/drivers/serial/jsm/jsm_driver.c linux-2.6.12.3-new/drivers/serial/jsm/jsm_driver.c
--- linux-2.6.12.3/drivers/serial/jsm/jsm_driver.c	2005-07-25 17:13:59.000000000 -0500
+++ linux-2.6.12.3-new/drivers/serial/jsm/jsm_driver.c	2005-07-25 17:14:39.000000000 -0500
@@ -42,7 +42,7 @@
 	.owner		= THIS_MODULE,
 	.driver_name	= JSM_DRIVER_NAME,
 	.dev_name	= "ttyn",
-	.major		= 253,
+	.major		= 0,
 	.minor		= JSM_MINOR_START,
 	.nr		= NR_PORTS,
 };

--=-V7s29rv7q3vKprVsie58--

