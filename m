Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130601AbQKAVDq>; Wed, 1 Nov 2000 16:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbQKAVDh>; Wed, 1 Nov 2000 16:03:37 -0500
Received: from sephiroth.byte-me.org ([216.15.105.106]:38016 "EHLO
	sephiroth.byte-me.org") by vger.kernel.org with ESMTP
	id <S131641AbQKAVDQ>; Wed, 1 Nov 2000 16:03:16 -0500
From: Mark Allen <mallen@byte-me.org>
Message-Id: <200011012103.NAA06478@sephiroth.byte-me.org>
Subject: test 10 breaks on alpha
To: linux-kernel@vger.kernel.org
Date: Wed, 1 Nov 2000 13:03:09 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the patch to make it compile.  I haven't tested this yet, but
I will once I can actually get a chance to sit at the console...

--- SNIP ---

--- /usr/src/linux/include/asm-alpha/param.h.orig	Wed Nov  1 12:31:56 2000
+++ /usr/src/linux/include/asm-alpha/param.h	Wed Nov  1 12:33:22 2000
@@ -27,4 +27,8 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#ifdef __KERNEL__
+# define CLOCKS_PER_SEC	1024	/* frequency at which times() counts */
+#endif
+
 #endif /* _ASM_ALPHA_PARAM_H */

-- 
Mark Allen -- mallen@byte-me.org -- http://www.byte-me.org/~mallen/
PGP1: 0x5CDC2161 Mark Allen (Personal Key) <mallen@byte-me.org> 
PGP2: 0x80402A46 Mark Allen (Work) <mallen@tuxtops.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
