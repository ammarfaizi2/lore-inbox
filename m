Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJNVJZ>; Mon, 14 Oct 2002 17:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262234AbSJNVJY>; Mon, 14 Oct 2002 17:09:24 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:783 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S262239AbSJNVI1>; Mon, 14 Oct 2002 17:08:27 -0400
Date: Mon, 14 Oct 2002 15:10:33 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.42, cciss, zero cylinders (4 of 7)
Message-ID: <20021014151033.D1257@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch 4 of 7 
zero out cylinders too when zeroing disk info.
applies to 2.5.42

diff -urN linux-2.5.42-d/drivers/block/cciss.c linux-2.5.42-e/drivers/block/cciss.c
--- linux-2.5.42-d/drivers/block/cciss.c	Mon Oct 14 10:28:19 2002
+++ linux-2.5.42-e/drivers/block/cciss.c	Mon Oct 14 11:06:29 2002
@@ -810,6 +810,7 @@
 	/* zero out the disk size info */ 
 	h->drv[logvol].nr_blocks = 0;
 	h->drv[logvol].block_size = 0;
+	h->drv[logvol].cylinders = 0;
 	h->drv[logvol].LunID = 0;
 	return(0);
 }
