Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUJIUIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUJIUIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJIUGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:06:41 -0400
Received: from [145.85.127.2] ([145.85.127.2]:43237 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267354AbUJIUGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:06:09 -0400
Message-ID: <54649.217.121.83.210.1097352355.squirrel@217.121.83.210>
Date: Sat, 9 Oct 2004 22:05:55 +0200 (CEST)
Subject: [Patch 5/5] xbox: add Xbox hz in timex.h
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Microsoft Xbox has a different clock than a generic x86 or AMD Elan
machine. Therefore we need to add this frequency to timex.h.

You can also download this patch at:
http://linux.g-rave.nl/patches/patch-xbox-timex.diff
---

 timex.h |    2 ++
 1 files changed, 2 insertions(+)

diff -u -r --new-file linux-2.6.9-rc3/include/asm-i386/timex.h
linux-2.6.9-rc3-ed0/include/asm-i386/timex.h
--- linux-2.6.9-rc3/include/asm-i386/timex.h	2004-09-30 05:04:25.000000000
+0200
+++ linux-2.6.9-rc3-ed0/include/asm-i386/timex.h	2004-10-09
20:01:25.027610000 +0200
@@ -11,6 +11,8 @@

 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
+#elif CONFIG_X86_XBOX
+#  define CLOCK_TICK_RATE 1125000 /* Microsoft Xbox */
 #else
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif
