Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVARCTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVARCTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVARCTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:19:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261166AbVARB5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:57:24 -0500
Date: Mon, 17 Jan 2005 17:57:09 -0800
Message-Id: <200501180157.j0I1v9YI013216@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cputime.h seems to assume HZ==1000
X-Shopping-List: (1) Omniscient retarders
   (2) Trans-Atlantic pompous bracelet adhesives
   (3) Luminescent luscious consolation
   (4) Victorious load griddles
   (5) Noxious uninteresting metronome sofas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't msecs mean msecs, not secs/HZ?

--- linux-2.6/include/asm-generic/cputime.h
+++ linux-2.6/include/asm-generic/cputime.h
@@ -35,8 +35,8 @@ typedef u64 cputime64_t;
 /*
  * Convert cputime to seconds and back.
  */
-#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / HZ)
-#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * HZ))
+#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / 1000)
+#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * 1000))
 
 /*
  * Convert cputime to timespec and back.
