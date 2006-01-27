Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWA0Wyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWA0Wyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWA0Wye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:54:34 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:13708 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422664AbWA0WyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:54:20 -0500
Date: Sat, 28 Jan 2006 00:54:19 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] sh/sh64: Fix bogus TIOCGICOUNT definitions.
Message-ID: <20060127225419.GL30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Russell King, sh and sh64 currently have bogus
definitions for TIOCGICOUNT, particularly referencing a kernel
only structure. Switch to using a sensible ioctl value.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 include/asm-sh/ioctls.h   |    2 +-
 include/asm-sh64/ioctls.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

60ddf0b381277105382046b3181e00046b0f2137
diff --git a/include/asm-sh/ioctls.h b/include/asm-sh/ioctls.h
index 1866f3f..9d84a2d 100644
--- a/include/asm-sh/ioctls.h
+++ b/include/asm-sh/ioctls.h
@@ -94,6 +94,6 @@
 #define TIOCSERSETMULTI _IOW('T', 91, struct serial_multiport_struct) /* 0x545B */ /* Set multiport config */
 
 #define TIOCMIWAIT	_IO('T', 92) /* 0x545C */	/* wait for a change on serial input line(s) */
-#define TIOCGICOUNT	_IOR('T', 93, struct async_icount) /* 0x545D */	/* read serial port inline interrupt counts */
+#define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
 
 #endif /* __ASM_SH_IOCTLS_H */
diff --git a/include/asm-sh64/ioctls.h b/include/asm-sh64/ioctls.h
index 08f3c1f..6b0c04f 100644
--- a/include/asm-sh64/ioctls.h
+++ b/include/asm-sh64/ioctls.h
@@ -111,6 +111,6 @@
 #define TIOCSERSETMULTI 0x40a8545b	/* _IOW('T', 91, struct serial_multiport_struct) 0x545B */ /* Set multiport config */
 
 #define TIOCMIWAIT	0x545c		/* _IO('T', 92) wait for a change on serial input line(s) */
-#define TIOCGICOUNT	0x802c545d	/* _IOR('T', 93, struct async_icount) 0x545D */	/* read serial port inline interrupt counts */
+#define TIOCGICOUNT	0x545d		/* read serial port inline interrupt counts */
 
 #endif /* __ASM_SH64_IOCTLS_H */
