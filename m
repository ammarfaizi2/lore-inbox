Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbUB0RSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbUB0RSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:18:53 -0500
Received: from topaz.cx ([66.220.6.227]:28037 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S263066AbUB0RSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:18:30 -0500
Date: Fri, 27 Feb 2004 12:18:19 -0500
From: Chip Salzenberg <chip@pobox.com>
To: nfs@lists.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.3-bk9: nfsd module needs locks_remove_posix()
Message-ID: <20040227171819.GA23518@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: OUTLOOK ERROR: Message text violates P.A.T.R.I.O.T. act
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.3-bk9 is missing an export, patch below.

Also, does this new nfsd make the comments on locks_remove_posix()
obsolete, or maybe incomplete?  I couldn't tell.

--- x/fs/locks.c.old	2004-02-17 22:59:31.000000000 -0500
+++ x/fs/locks.c	2004-02-27 12:16:59.000000000 -0500
@@ -1700,4 +1700,6 @@
 }
 
+EXPORT_SYMBOL(locks_remove_posix);
+
 /*
  * This function is called on the last close of an open file.

-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
