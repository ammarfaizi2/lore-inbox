Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbSLPKAN>; Mon, 16 Dec 2002 05:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSLPKAN>; Mon, 16 Dec 2002 05:00:13 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:11017 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266565AbSLPJ7l>; Mon, 16 Dec 2002 04:59:41 -0500
Date: Mon, 16 Dec 2002 10:07:47 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 3/19
Message-ID: <20021216100747.GD7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENOTBLK if lookup_device() finds the inode, but it
is not a block device. [Cristoph Hellwig]

--- diff/drivers/md/dm-table.c	2002-12-16 09:40:30.000000000 +0000
+++ source/drivers/md/dm-table.c	2002-12-16 09:40:34.000000000 +0000
@@ -312,7 +312,7 @@
 	}
 
 	if (!S_ISBLK(inode->i_mode)) {
-		r = -EINVAL;
+		r = -ENOTBLK;
 		goto out;
 	}
 
