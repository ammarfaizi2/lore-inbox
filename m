Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271968AbTHDRJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271966AbTHDRJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:09:24 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:30151 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S271968AbTHDRI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:08:59 -0400
Date: Mon, 4 Aug 2003 13:09:00 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22pre10: fs/aio.c should include <linux/poll.h>
Message-ID: <20030804170900.GA8221@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since fs/aio.c calls async_poll(), it should include <linux/poll.h> to
get its declaration.

Index: linux/fs/aio.c
--- linux/fs/aio.c.old	2003-08-04 12:08:49.000000000 -0400
+++ linux/fs/aio.c	2003-08-04 12:50:45.000000000 -0400
@@ -12,4 +12,5 @@
 #include <linux/errno.h>
 #include <linux/time.h>
+#include <linux/poll.h>
 #include <linux/aio_abi.h>
 

-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
