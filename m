Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTBLRKe>; Wed, 12 Feb 2003 12:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTBLRKe>; Wed, 12 Feb 2003 12:10:34 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:43184 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266210AbTBLRKe>; Wed, 12 Feb 2003 12:10:34 -0500
Date: Wed, 12 Feb 2003 18:19:57 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: torvalds@transmeta.com
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Molina <tmolina@cox.net>
Subject: [PATCH] export allow_signal()
Message-ID: <20030212171957.GD4009@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export allow_signal().  It's needed by lockd, sunrpc and other modules.
Patch against current BK.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2003-02-12 18:16:30.000000000 +0100
+++ b/kernel/exit.c	2003-02-12 18:10:34.000000000 +0100
@@ -293,7 +293,7 @@
 	spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
-	
+EXPORT_SYMBOL(allow_signal);
 
 /*
  *	Put all the gunge required to become a kernel thread without
