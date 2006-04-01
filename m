Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWDAUyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWDAUyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWDAUyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 15:54:41 -0500
Received: from mail.parknet.jp ([210.171.160.80]:46344 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932192AbWDAUyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 15:54:40 -0500
X-AuthUser: hirofumi@parknet.jp
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove sys_ prefix of new syscalls from __NR_sys_*
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Apr 2006 05:54:32 +0900
Message-ID: <87k6a910fr.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, we don't use sys_ prefix for __NR_*. This patch removes it.
[FWIW, _syscall*() macros will generate foo() instead of sys_foo().]

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 include/asm-i386/unistd.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN include/asm-i386/unistd.h~remove-sys_-prefix include/asm-i386/unistd.h
--- linux-2.6/include/asm-i386/unistd.h~remove-sys_-prefix	2006-04-02 05:23:57.000000000 +0900
+++ linux-2.6-hirofumi/include/asm-i386/unistd.h	2006-04-02 05:24:10.000000000 +0900
@@ -318,8 +318,8 @@
 #define __NR_unshare		310
 #define __NR_set_robust_list	311
 #define __NR_get_robust_list	312
-#define __NR_sys_splice		313
-#define __NR_sys_sync_file_range 314
+#define __NR_splice		313
+#define __NR_sync_file_range	314
 
 #define NR_syscalls 315
 
_
