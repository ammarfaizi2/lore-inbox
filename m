Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTBLTFv>; Wed, 12 Feb 2003 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTBLTFv>; Wed, 12 Feb 2003 14:05:51 -0500
Received: from ztxmail02.ztx.compaq.com ([161.114.1.206]:34830 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S267267AbTBLTFu>; Wed, 12 Feb 2003 14:05:50 -0500
Date: Wed, 12 Feb 2003 13:16:10 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071610.GE1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zero out cylinders when zeroing out other disk info in cciss driver.
(patch 5 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss.c~zero_cyls	2003-02-12 10:12:56.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:12:56.000000000 +0600
@@ -809,6 +809,7 @@ static int deregister_disk(int ctlr, int
 	/* zero out the disk size info */ 
 	h->drv[logvol].nr_blocks = 0;
 	h->drv[logvol].block_size = 0;
+	h->drv[logvol].cylinders = 0;
 	h->drv[logvol].LunID = 0;
 	return(0);
 }

_
