Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTHJVYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTHJVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:24:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41187 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270716AbTHJVYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:24:52 -0400
Date: Sun, 10 Aug 2003 23:24:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jens Axboe <axboe@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.6.0-test3: typo in hd.c
Message-ID: <20030810212444.GE16091@fs.tum.de>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 10:40:37PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test2 to v2.6.0-test3
> ====================================================
>...
> Jens Axboe:
>...
>   o Proper block queue reference counting
>...

This contains a typo that is fixed with the following patch:

--- linux-2.6.0-test3-not-full/drivers/ide/legacy/hd.c.old	2003-08-10 23:21:04.000000000 +0200
+++ linux-2.6.0-test3-not-full/drivers/ide/legacy/hd.c	2003-08-10 23:21:56.000000000 +0200
@@ -715,7 +715,7 @@
 
 	hd_queue = blk_init_queue(do_hd_request, &hd_lock);
 	if (!hd_queue) {
-		unegister_blkdev(MAJOR_NR,"hd");
+		unregister_blkdev(MAJOR_NR,"hd");
 		return -ENOMEM;
 	}
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

