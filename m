Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVC3Sms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVC3Sms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVC3Skn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:40:43 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:8071 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262388AbVC3SgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:36:01 -0500
Subject: [patch 3/3] x86_64: remove dup syscall
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:32:18 +0200
Message-Id: <20050330173219.83466EFED1@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove duplicated syscall entry.

This likely affects compilation with older GCC's (2.95.x), since in
arch/x86_64/kernel/syscall.c this will result in assigning twice the same
array element.

By experience, this works with newer GCC's but not with 2.95.3/4.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-x86_64/unistd.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN include/asm-x86_64/unistd.h~remove-dup-sc include/asm-x86_64/unistd.h
--- linux-2.6.11/include/asm-x86_64/unistd.h~remove-dup-sc	2005-03-29 19:52:55.000000000 +0200
+++ linux-2.6.11-paolo/include/asm-x86_64/unistd.h	2005-03-29 19:53:12.000000000 +0200
@@ -533,8 +533,6 @@ __SYSCALL(__NR_tgkill, sys_tgkill)
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR_vserver		236
 __SYSCALL(__NR_vserver, sys_ni_syscall)
-#define __NR_vserver		236
-__SYSCALL(__NR_vserver, sys_ni_syscall)
 #define __NR_mbind 		237
 __SYSCALL(__NR_mbind, sys_mbind)
 #define __NR_set_mempolicy 	238
_
