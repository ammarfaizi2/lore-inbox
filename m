Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWBHHLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWBHHLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWBHHLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:19869 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161056AbWBHHLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] s390 __get_user() bogus warnings removal
Cc: schwidefsky@de.ibm.com
Message-Id: <E1F6jTr-0002eB-2O@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1139015512 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-s390/uaccess.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

97fa5a664e69f2fcdd2120e7f4765f8c1df56282
diff --git a/include/asm-s390/uaccess.h b/include/asm-s390/uaccess.h
index e2c73b4..0b7c0ca 100644
--- a/include/asm-s390/uaccess.h
+++ b/include/asm-s390/uaccess.h
@@ -208,25 +208,25 @@ extern int __put_user_bad(void) __attrib
 	case 1: {						\
 		unsigned char __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = *(__typeof__(*(ptr)) *) &__x;		\
+		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	case 2: {						\
 		unsigned short __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = *(__typeof__(*(ptr)) *) &__x;		\
+		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	case 4: {						\
 		unsigned int __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = *(__typeof__(*(ptr)) *) &__x;		\
+		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	case 8: {						\
 		unsigned long long __x;				\
 		__get_user_asm(__x, ptr, __gu_err);		\
-		(x) = *(__typeof__(*(ptr)) *) &__x;		\
+		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	default:						\
-- 
0.99.9.GIT

