Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVAMMmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVAMMmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 07:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVAMMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 07:42:20 -0500
Received: from aun.it.uu.se ([130.238.12.36]:684 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261608AbVAMMmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 07:42:16 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16870.27803.8328.83623@alkaid.it.uu.se>
Date: Thu, 13 Jan 2005 13:42:02 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.10-mm3] perfctr x86_64 native syscall numbers fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

2.6.10-mm3 added some syscalls to x86-64, but the preliminary syscall
numbers for perfctr weren't adjusted, causing an overlap. Fix below.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.10-mm3/include/asm-x86_64/unistd.h.~1~	2005-01-12 23:06:15.000000000 +0100
+++ linux-2.6.10-mm3/include/asm-x86_64/unistd.h	2005-01-12 23:14:14.000000000 +0100
@@ -562,7 +562,7 @@ __SYSCALL(__NR_add_key, sys_add_key)
 __SYSCALL(__NR_request_key, sys_request_key)
 #define __NR_keyctl		250
 __SYSCALL(__NR_keyctl, sys_keyctl)
-#define __NR_vperfctr_open	248
+#define __NR_vperfctr_open	251
 __SYSCALL(__NR_vperfctr_open, sys_vperfctr_open)
 #define __NR_vperfctr_control	(__NR_vperfctr_open+1)
 __SYSCALL(__NR_vperfctr_control, sys_vperfctr_control)
