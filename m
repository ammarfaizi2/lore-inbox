Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbULPA4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbULPA4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbULPA4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:56:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:58276 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262565AbULPAaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:30:03 -0500
Date: Thu, 16 Dec 2004 01:40:29 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 26/30] return statement cleanup - kill pointless parentheses
 in arch/um/include/sysdep-i386/checksum.h
Message-ID: <Pine.LNX.4.61.0412160139390.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
arch/um/include/sysdep-i386/checksum.h

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.10-rc3-bk8-orig/arch/um/include/sysdep-i386/checksum.h	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.10-rc3-bk8/arch/um/include/sysdep-i386/checksum.h	2004-12-15 23:57:46.000000000 +0100
@@ -49,7 +49,7 @@ unsigned int csum_partial_copy_nocheck(c
 				       int len, int sum)
 {
 	memcpy(dst, src, len);
-	return(csum_partial(dst, len, sum));
+	return csum_partial(dst, len, sum);
 }
 
 static __inline__
@@ -105,7 +105,7 @@ static inline unsigned short ip_fast_csu
 	: "=r" (sum), "=r" (iph), "=r" (ihl)
 	: "1" (iph), "2" (ihl)
 	: "memory");
-	return(sum);
+	return sum;
 }
 
 /*
@@ -197,7 +197,7 @@ static __inline__ unsigned int csum_and_
 						     int sum, int *err_ptr)
 {
 	if (access_ok(VERIFY_WRITE, dst, len))
-		return(csum_partial_copy_to(src, dst, len, sum, err_ptr));
+		return csum_partial_copy_to(src, dst, len, sum, err_ptr);
 
 	if (len)
 		*err_ptr = -EFAULT;



