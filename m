Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWJKQW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWJKQW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWJKQW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:22:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48828 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161103AbWJKQWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:22:55 -0400
To: torvalds@osdl.org
Subject: [PATCH] arm: use unsigned long instead of unsigned int in get_user()
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Message-Id: <E1GXgr8-0005UR-D1@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:22:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-arm/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-arm/uaccess.h b/include/asm-arm/uaccess.h
index 87aba57..09ad0ca 100644
--- a/include/asm-arm/uaccess.h
+++ b/include/asm-arm/uaccess.h
@@ -110,7 +110,7 @@ #define __get_user_x(__r2,__p,__e,__s,__
 #define get_user(x,p)							\
 	({								\
 		const register typeof(*(p)) __user *__p asm("r0") = (p);\
-		register unsigned int __r2 asm("r2");			\
+		register unsigned long __r2 asm("r2");			\
 		register int __e asm("r0");				\
 		switch (sizeof(*(__p))) {				\
 		case 1:							\
-- 
1.4.2.GIT

