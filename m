Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJPVgy>; Wed, 16 Oct 2002 17:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJPVgw>; Wed, 16 Oct 2002 17:36:52 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:19473 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S261448AbSJPVfa>; Wed, 16 Oct 2002 17:35:30 -0400
Date: Wed, 16 Oct 2002 15:37:47 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 5/8] 2.5.43 cciss zero cyls too
Message-ID: <20021016153747.E2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zero out cylinders when zeroing out other disk info.

diff -urN linux-2.5.43-d/drivers/block/cciss.c linux-2.5.43-e/drivers/block/cciss.c
--- linux-2.5.43-d/drivers/block/cciss.c	Wed Oct 16 08:22:21 2002
+++ linux-2.5.43-e/drivers/block/cciss.c	Wed Oct 16 08:24:19 2002
@@ -810,6 +810,7 @@
 	/* zero out the disk size info */ 
 	h->drv[logvol].nr_blocks = 0;
 	h->drv[logvol].block_size = 0;
+	h->drv[logvol].cylinders = 0;
 	h->drv[logvol].LunID = 0;
 	return(0);
 }
