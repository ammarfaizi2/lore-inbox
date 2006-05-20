Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWETCx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWETCx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 22:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWETCx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 22:53:56 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:16464 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964846AbWETCxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 22:53:55 -0400
Date: Fri, 19 May 2006 19:53:53 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] i386: don't consider regparm EXPERIMENTAL anymore
Message-ID: <20060520025353.GE9486@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
cx: Linus Torvalds <torvalds@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [This might be a tad premature given recent tail-call fixups?]

---

Drop EXPERIMENTAL status from REGPARM as a lot of people seem to use
it and it seems to be pretty stable these days.


Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 5b1a7d4..2b8657d 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -660,8 +660,7 @@ config BOOT_IOREMAP
 	default y
 
 config REGPARM
-	bool "Use register arguments (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	bool "Use register arguments"
 	default n
 	help
 	Compile the kernel with -mregparm=3. This uses a different ABI
