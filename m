Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282924AbRK0UF6>; Tue, 27 Nov 2001 15:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282925AbRK0UFs>; Tue, 27 Nov 2001 15:05:48 -0500
Received: from ns0.cobite.com ([208.222.80.10]:62480 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S282924AbRK0UFm>;
	Tue, 27 Nov 2001 15:05:42 -0500
Date: Tue, 27 Nov 2001 15:05:35 -0500 (EST)
From: David Mansfield <david@cobite.com>
X-X-Sender: <david@admin>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: comment typo for generic_make_request in 2.5.1-pre2?
Message-ID: <Pine.LNX.4.33.0111271455560.4599-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens et al,

Just looking at the bio changes in pre2 and I came across the comment for 
generic_make_request that says it may change bi_dev and/or bi_rsector.  I 
think the bi_rsector is supposed to be bi_sector (since the former no 
longer exists).  Here's a patch if in fact this is just a typo:

--- ll_rw_blk.c.orig	Tue Nov 27 14:57:40 2001
+++ ll_rw_blk.c	Tue Nov 27 15:02:23 2001
@@ -1041,7 +1041,7 @@
  *
  * generic_make_request and the drivers it calls may use bi_next if this
  * bio happens to be merged with someone else, and may change bi_dev and
- * bi_rsector for remaps as it sees fit.  So the values of these fields
+ * bi_sector for remaps as it sees fit.  So the values of these fields
  * should NOT be depended on after the call to generic_make_request.
  *
  * */

It's really no big deal, but I guess even the comments deserve to be 
correct. Anyway, this stuff is certainly fun reading!

David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/


