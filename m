Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVAWHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVAWHGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVAWHEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:04:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:32178 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261241AbVAWHEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:04:25 -0500
Date: Sat, 22 Jan 2005 22:56:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, ak@suse.de
Subject: [PATCH] x86_64: use UL on TASK_SIZE
Message-Id: <20050122225617.35d1c6ac.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use UL on large constant (kills 3214 sparse warnings :)

include/linux/sched.h:1150:18: warning: constant 0x800000000000 is so big it is long

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 include/asm-x86_64/processor.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./include/asm-x86_64/processor.h~proc_task_size ./include/asm-x86_64/processor.h
--- ./include/asm-x86_64/processor.h~proc_task_size	2005-01-22 19:06:33.765150024 -0800
+++ ./include/asm-x86_64/processor.h	2005-01-22 21:40:48.884158072 -0800
@@ -162,7 +162,7 @@ static inline void clear_in_cr4 (unsigne
 /*
  * User space process size. 47bits.
  */
-#define TASK_SIZE	(0x800000000000)
+#define TASK_SIZE	(0x800000000000UL)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.

--
