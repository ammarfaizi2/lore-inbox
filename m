Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSLPKKM>; Mon, 16 Dec 2002 05:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbSLPKJW>; Mon, 16 Dec 2002 05:09:22 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:28422 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266686AbSLPKIO>; Mon, 16 Dec 2002 05:08:14 -0500
Date: Mon, 16 Dec 2002 10:16:20 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 15/19
Message-ID: <20021216101620.GP7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some paranoia in highmem.c
--- diff/mm/highmem.c	2002-11-11 11:09:43.000000000 +0000
+++ source/mm/highmem.c	2002-12-16 09:41:30.000000000 +0000
@@ -452,8 +452,6 @@
 	mempool_t *pool;
 	int bio_gfp;
 
-	BUG_ON((*bio_orig)->bi_idx);
-
 	/*
 	 * for non-isa bounce case, just check if the bounce pfn is equal
 	 * to or bigger than the highest pfn in the system -- in that case,
