Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTFFTOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFFTOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:14:42 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:23486 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262251AbTFFTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:14:41 -0400
Date: Fri, 6 Jun 2003 21:28:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib merge #2 return code
Message-ID: <20030606192814.GH10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de> <20030606183920.GC10487@wohnheim.fh-wedel.de> <20030606185210.GE10487@wohnheim.fh-wedel.de> <20030606192325.GG10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606192325.GG10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Don't think anyone actually bothers to check specific error codes, but
it shouldn't hurt either.

Jörn

-- 
A surrounded army must be given a way out.
-- Sun Tzu

--- linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c~zlib_merge_return	2003-06-06 20:47:11.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c	2003-06-06 21:25:10.000000000 +0200
@@ -229,7 +229,7 @@
 
         /* allocate new table */
         if (*hn + z > MANY)     /* (note: doesn't matter for fixed) */
-          return Z_MEM_ERROR;   /* not enough memory */
+          return Z_DATA_ERROR;  /* overflow of MANY */
         u[h] = q = hp + *hn;
         *hn += z;
 
