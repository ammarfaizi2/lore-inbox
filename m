Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbSLKMOV>; Wed, 11 Dec 2002 07:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSLKMOU>; Wed, 11 Dec 2002 07:14:20 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:50958 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267135AbSLKMOE>; Wed, 11 Dec 2002 07:14:04 -0500
Date: Wed, 11 Dec 2002 12:21:49 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Kevin Corry <corryk@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c  -  device-mapper I/O path fixes
Message-ID: <20021211122149.GE20782@reti>
References: <02121016034706.02220@boiler> <20021211121749.GA20782@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211121749.GA20782@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some paranoia in highmem.c, need to check this with Jens Axboe.

--- diff/mm/highmem.c	2002-11-11 11:09:43.000000000 +0000
+++ source/mm/highmem.c	2002-12-11 12:00:48.000000000 +0000
@@ -452,8 +452,6 @@
 	mempool_t *pool;
 	int bio_gfp;
 
-	BUG_ON((*bio_orig)->bi_idx);
-
 	/*
 	 * for non-isa bounce case, just check if the bounce pfn is equal
 	 * to or bigger than the highest pfn in the system -- in that case,
