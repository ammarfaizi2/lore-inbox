Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVKCCjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVKCCjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVKCCjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:39:21 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:59611 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1030259AbVKCCjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:39:20 -0500
Date: Thu, 3 Nov 2005 13:39:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@davemloft.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] sparc{,64}: remove duplicate TIOCPKT_ definitions
Message-Id: <20051103133907.1fb5008b.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TIOCPKT_ macros are defined by all other architectures in asm/ioctls.h
and so does sparc and sparc64, so reomve the duplicates in asm/termios.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-sparc/termios.h   |    9 ---------
 include/asm-sparc64/termios.h |    9 ---------
 2 files changed, 0 insertions(+), 18 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

applies-to: 14ad9a7d6f9807352187de7947cd8f803ac696a9
689937d433f0925755a91f1f5ee38174ae4054a8
diff --git a/include/asm-sparc/termios.h b/include/asm-sparc/termios.h
index 0a8ad4c..d05f83c 100644
--- a/include/asm-sparc/termios.h
+++ b/include/asm-sparc/termios.h
@@ -38,15 +38,6 @@ struct sunos_ttysize {
 	int st_columns; /* Columns on the terminal */
 };
 
-/* Used for packet mode */
-#define TIOCPKT_DATA		 0
-#define TIOCPKT_FLUSHREAD	 1
-#define TIOCPKT_FLUSHWRITE	 2
-#define TIOCPKT_STOP		 4
-#define TIOCPKT_START		 8
-#define TIOCPKT_NOSTOP		16
-#define TIOCPKT_DOSTOP		32
-
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
diff --git a/include/asm-sparc64/termios.h b/include/asm-sparc64/termios.h
index 9777a9c..ee26a07 100644
--- a/include/asm-sparc64/termios.h
+++ b/include/asm-sparc64/termios.h
@@ -38,15 +38,6 @@ struct sunos_ttysize {
 	int st_columns; /* Columns on the terminal */
 };
 
-/* Used for packet mode */
-#define TIOCPKT_DATA		 0
-#define TIOCPKT_FLUSHREAD	 1
-#define TIOCPKT_FLUSHWRITE	 2
-#define TIOCPKT_STOP		 4
-#define TIOCPKT_START		 8
-#define TIOCPKT_NOSTOP		16
-#define TIOCPKT_DOSTOP		32
-
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
---
0.99.9b
