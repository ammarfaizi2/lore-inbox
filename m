Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbTAHJxF>; Wed, 8 Jan 2003 04:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267794AbTAHJwH>; Wed, 8 Jan 2003 04:52:07 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:32518 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267785AbTAHJvI>; Wed, 8 Jan 2003 04:51:08 -0500
Date: Wed, 8 Jan 2003 09:59:20 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/10] dm: Simplify error->map
Message-ID: <20030108095920.GI2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just return an error from the error targets map function, rather than
erroring the buffer_head.
--- diff/drivers/md/dm-target.c	2003-01-02 11:26:44.000000000 +0000
+++ source/drivers/md/dm-target.c	2003-01-02 11:27:04.000000000 +0000
@@ -163,8 +163,7 @@
 
 static int io_err_map(struct dm_target *ti, struct bio *bio)
 {
-	bio_io_error(bio, 0);
-	return 0;
+	return -EIO;
 }
 
 static struct target_type error_target = {
