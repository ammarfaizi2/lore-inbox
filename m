Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268817AbTBZQ7R>; Wed, 26 Feb 2003 11:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268819AbTBZQ7Q>; Wed, 26 Feb 2003 11:59:16 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:11276 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268817AbTBZQ7O>; Wed, 26 Feb 2003 11:59:14 -0500
Date: Wed, 26 Feb 2003 17:08:43 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] dm: __LOW macro fix no. 1
Message-ID: <20030226170843.GB8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix __LOW macro.  [Kevin Corry]

--- diff/drivers/md/dm-table.c	2003-01-13 14:18:15.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-02-26 16:09:47.000000000 +0000
@@ -79,7 +79,7 @@
 }
 
 #define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
-#define __LOW(l, r) if (*(l) < (r)) *(l) = (r)
+#define __LOW(l, r) if (*(l) > (r)) *(l) = (r)
 
 /*
  * Combine two io_restrictions, always taking the lower value.
