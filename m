Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbULUAlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbULUAlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULUAlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:41:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:781 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261262AbULUAlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:41:47 -0500
Date: Tue, 21 Dec 2004 01:41:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: langa2@kph.uni-mainz.de, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI ibmmca.c: make a struct static (fwd)
Message-ID: <20041221004141.GD21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 15 Nov 2004 03:06:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: langa2@kph.uni-mainz.de
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI ibmmca.c: make a struct static

The patch below makes a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ibmmca.c.old	2004-11-13 21:50:36.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ibmmca.c	2004-11-13 21:50:49.000000000 +0100
@@ -292,7 +292,7 @@
 #define INTEGRATED_SCSI          101
 
 /* List of possible IBM-SCSI-adapters */
-struct subsys_list_struct subsys_list[] = {
+static struct subsys_list_struct subsys_list[] = {
 	{0x8efc, "IBM SCSI-2 F/W Adapter"},	/* special = 0 */
 	{0x8efd, "IBM 7568 Industrial Computer SCSI Adapter w/Cache"},	/* special = 1 */
 	{0x8ef8, "IBM Expansion Unit SCSI Controller"},	/* special = 2 */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

