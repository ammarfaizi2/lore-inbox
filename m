Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSJKOGo>; Fri, 11 Oct 2002 10:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbSJKOGo>; Fri, 11 Oct 2002 10:06:44 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:37125 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S262457AbSJKOGn>; Fri, 11 Oct 2002 10:06:43 -0400
Date: Fri, 11 Oct 2002 08:08:38 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss (1 of 3)
Message-ID: <20021011080838.A1911@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zero out cylinders too, when zeroing out disk size info. 

diff -urN linux-2.5.41-n/drivers/block/cciss.c linux-2.5.41-o/drivers/block/cciss.c
--- linux-2.5.41-n/drivers/block/cciss.c	Wed Oct  9 14:29:15 2002
+++ linux-2.5.41-o/drivers/block/cciss.c	Wed Oct  9 15:08:22 2002
@@ -829,6 +829,7 @@
 	/* zero out the disk size info */ 
 	h->drv[logvol].nr_blocks = 0;
 	h->drv[logvol].block_size = 0;
+	h->drv[logvol].cylinders = 0;
 	h->drv[logvol].LunID = 0;
 	return(0);
 }
