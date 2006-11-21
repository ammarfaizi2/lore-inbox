Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031344AbWKUTlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031344AbWKUTlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031345AbWKUTlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:41:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2057 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031344AbWKUTli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:41:38 -0500
Date: Tue, 21 Nov 2006 20:41:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: [2.6.19 patch] i386/x86_64: remove the unused EXPORT_SYMBOL(dump_trace)
Message-ID: <20061121194138.GF5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(dump_trace) added on i386 
and x86_64 in 2.6.19-rc.

By removing them before the final 2.6.19 we avoid the possibility of 
people later whining that we removed exports they started using.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/traps.c   |    1 -
 arch/x86_64/kernel/traps.c |    1 -
 2 files changed, 2 deletions(-)

--- linux-2.6.19-rc5-mm2/arch/i386/kernel/traps.c.old	2006-11-21 19:45:10.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/i386/kernel/traps.c	2006-11-21 19:45:26.000000000 +0100
@@ -247,7 +247,6 @@
 			break;
 	}
 }
-EXPORT_SYMBOL(dump_trace);
 
 static void
 print_trace_warning_symbol(void *data, char *msg, unsigned long symbol)
--- linux-2.6.19-rc5-mm2/arch/x86_64/kernel/traps.c.old	2006-11-21 19:45:33.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/x86_64/kernel/traps.c	2006-11-21 19:45:59.000000000 +0100
@@ -377,7 +377,6 @@
 out:
 	put_cpu();
 }
-EXPORT_SYMBOL(dump_trace);
 
 static void
 print_trace_warning_symbol(void *data, char *msg, unsigned long symbol)

