Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTDHDxX (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTDHDxX (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:53:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263926AbTDHDxW (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 23:53:22 -0400
From: Mika Kukkonen <mika@osdl.org>
Message-ID: <32810.66.224.33.25.1049774699.squirrel@fire.osdl.org>
Date: Mon, 7 Apr 2003 21:04:59 -0700 (PDT)
Subject: [PATCH][TRIVIAL][2.5.67] Compile fix to file include/linux/inet.h
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was unfortunate enough to have "#include <inet.h>" as a first line in
my c-file, and so got bitten by this. Please apply.

--MiKu

--- stable/include/linux/inet.h 2003-04-07 21:00:37.000000000 -0700
+++ unstable/include/linux/inet.h       2003-04-07 20:59:45.000000000 -0700
@@ -43,6 +43,8 @@
 #define _LINUX_INET_H

 #ifdef __KERNEL__
+#include <asm/types.h>
+
 extern __u32 in_aton(const char *str);
 #endif
 #endif /* _LINUX_INET_H */



