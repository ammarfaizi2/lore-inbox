Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVIJXYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVIJXYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIJXYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:24:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5579 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932375AbVIJXYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:24:33 -0400
Date: Sun, 11 Sep 2005 00:24:27 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uml spinlock breakage
Message-ID: <20050910232427.GG25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo missed that one...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git10-base/include/asm-um/spinlock_types.h current/include/asm-um/spinlock_types.h
--- RC13-git10-base/include/asm-um/spinlock_types.h	1969-12-31 19:00:00.000000000 -0500
+++ current/include/asm-um/spinlock_types.h	2005-09-10 19:08:33.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_SPINLOCK_TYPES_H
+#define __UM_SPINLOCK_TYPES_H
+
+#include "asm/arch/spinlock_types.h"
+
+#endif
