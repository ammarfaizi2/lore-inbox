Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289657AbSAJU2S>; Thu, 10 Jan 2002 15:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289658AbSAJU2A>; Thu, 10 Jan 2002 15:28:00 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:58974 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289657AbSAJU1s>; Thu, 10 Jan 2002 15:27:48 -0500
Date: Thu, 10 Jan 2002 15:27:47 -0500 (EST)
From: Peter Jones <pjones@redhat.com>
X-X-Sender: <pjones@devserv.devel.redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] #ifdef __cplusplus removal (fwd)
Message-ID: <Pine.LNX.4.33.0201101527140.7586-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And again for my bad email aliases :)

-- 
        Peter

---------- Forwarded message ----------
Date: Thu, 10 Jan 2002 15:23:09 -0500 (EST)
From: Peter Jones <pjones@redhat.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.rutgers.edu
Subject: [PATCH] #ifdef __cplusplus removal

Marcello,

This patch removes the "#ifdef __cplusplus" from within a "#ifdef
__KERNEL__" in linux/string.h.  It really isn't needed AFACIT.  It was put
in for 1.1.0, which was before __KERNEL__ appeared.  Alan told me to send 
it to you.

--- linux/include/linux/string.h.orig   Thu Jan 10 01:14:48 2002
+++ linux/include/linux/string.h        Thu Jan 10 01:14:50 2002
@@ -8,10 +8,6 @@
 #include <linux/types.h>       /* for size_t */
 #include <linux/stddef.h>      /* for NULL */
 
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 extern char * ___strtok;
 extern char * strpbrk(const char *,const char *);
 extern char * strtok(char *,const char *);
@@ -78,10 +74,6 @@
 #endif
 #ifndef __HAVE_ARCH_MEMCHR
 extern void * memchr(const void *,int,__kernel_size_t);
-#endif
-
-#ifdef __cplusplus
-}
 #endif
 
 #endif

-- 
        Peter





