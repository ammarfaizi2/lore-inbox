Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263421AbTDCVbd 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263430AbTDCVb3 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:31:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22165 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263421AbTDCVbQ 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 16:31:16 -0500
Date: Thu, 3 Apr 2003 16:42:44 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux390@de.ibm.com, Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch to move MAX_INIT_ARGS
Message-ID: <20030403164244.C15640@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All:

I would like to move MAX_INIT_ARGS to param.h (to make it bigger).
Please let me know if you disagree.

-- Pete

diff -urN -X dontdiff linux-2.5.66/include/asm-alpha/param.h linux-2.5.66-s390/include/asm-alpha/param.h
--- linux-2.5.66/include/asm-alpha/param.h	2003-03-24 14:00:21.000000000 -0800
+++ linux-2.5.66-s390/include/asm-alpha/param.h	2003-04-03 13:17:16.000000000 -0800
@@ -33,4 +33,7 @@
 # define CLOCKS_PER_SEC	HZ	/* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _ASM_ALPHA_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-arm/param.h linux-2.5.66-s390/include/asm-arm/param.h
--- linux-2.5.66/include/asm-arm/param.h	2003-03-24 14:00:41.000000000 -0800
+++ linux-2.5.66-s390/include/asm-arm/param.h	2003-04-03 13:17:22.000000000 -0800
@@ -36,5 +36,8 @@
 /* max length of hostname */
 #define MAXHOSTNAMELEN  64
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
 
diff -urN -X dontdiff linux-2.5.66/include/asm-cris/param.h linux-2.5.66-s390/include/asm-cris/param.h
--- linux-2.5.66/include/asm-cris/param.h	2003-03-24 14:00:48.000000000 -0800
+++ linux-2.5.66-s390/include/asm-cris/param.h	2003-04-03 13:17:29.000000000 -0800
@@ -21,4 +21,7 @@
 # define CLOCKS_PER_SEC        100     /* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-i386/param.h linux-2.5.66-s390/include/asm-i386/param.h
--- linux-2.5.66/include/asm-i386/param.h	2003-03-24 14:00:08.000000000 -0800
+++ linux-2.5.66-s390/include/asm-i386/param.h	2003-04-03 13:16:26.000000000 -0800
@@ -23,4 +23,10 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+/*
+ * Boot command-line arguments
+ */
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-ia64/param.h linux-2.5.66-s390/include/asm-ia64/param.h
--- linux-2.5.66/include/asm-ia64/param.h	2003-03-24 14:00:39.000000000 -0800
+++ linux-2.5.66-s390/include/asm-ia64/param.h	2003-04-03 13:17:38.000000000 -0800
@@ -37,4 +37,7 @@
 # define CLOCKS_PER_SEC	HZ	/* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _ASM_IA64_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-m68k/param.h linux-2.5.66-s390/include/asm-m68k/param.h
--- linux-2.5.66/include/asm-m68k/param.h	2003-03-24 14:00:49.000000000 -0800
+++ linux-2.5.66-s390/include/asm-m68k/param.h	2003-04-03 13:17:48.000000000 -0800
@@ -23,4 +23,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _M68K_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-m68knommu/param.h linux-2.5.66-s390/include/asm-m68knommu/param.h
--- linux-2.5.66/include/asm-m68knommu/param.h	2003-03-24 14:00:41.000000000 -0800
+++ linux-2.5.66-s390/include/asm-m68knommu/param.h	2003-04-03 13:17:45.000000000 -0800
@@ -54,4 +54,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _M68KNOMMU_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-mips/param.h linux-2.5.66-s390/include/asm-mips/param.h
--- linux-2.5.66/include/asm-mips/param.h	2003-03-24 14:00:09.000000000 -0800
+++ linux-2.5.66-s390/include/asm-mips/param.h	2003-04-03 13:18:00.000000000 -0800
@@ -68,4 +68,7 @@
 # define CLOCKS_PER_SEC	100	/* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _ASM_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-mips64/param.h linux-2.5.66-s390/include/asm-mips64/param.h
--- linux-2.5.66/include/asm-mips64/param.h	2003-03-24 14:00:18.000000000 -0800
+++ linux-2.5.66-s390/include/asm-mips64/param.h	2003-04-03 13:17:54.000000000 -0800
@@ -33,4 +33,7 @@
 # define CLOCKS_PER_SEC	100	/* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _ASM_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-parisc/param.h linux-2.5.66-s390/include/asm-parisc/param.h
--- linux-2.5.66/include/asm-parisc/param.h	2003-03-24 14:00:21.000000000 -0800
+++ linux-2.5.66-s390/include/asm-parisc/param.h	2003-04-03 13:18:03.000000000 -0800
@@ -27,4 +27,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-ppc/param.h linux-2.5.66-s390/include/asm-ppc/param.h
--- linux-2.5.66/include/asm-ppc/param.h	2003-03-24 14:00:20.000000000 -0800
+++ linux-2.5.66-s390/include/asm-ppc/param.h	2003-04-03 13:18:10.000000000 -0800
@@ -23,4 +23,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-ppc64/param.h linux-2.5.66-s390/include/asm-ppc64/param.h
--- linux-2.5.66/include/asm-ppc64/param.h	2003-03-24 14:01:25.000000000 -0800
+++ linux-2.5.66-s390/include/asm-ppc64/param.h	2003-04-03 13:18:07.000000000 -0800
@@ -30,4 +30,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _ASM_PPC64_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-s390/param.h linux-2.5.66-s390/include/asm-s390/param.h
--- linux-2.5.66/include/asm-s390/param.h	2003-03-24 14:00:00.000000000 -0800
+++ linux-2.5.66-s390/include/asm-s390/param.h	2003-04-03 13:19:12.000000000 -0800
@@ -31,4 +31,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 25	/* param.parm deck for installs */
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-s390x/param.h linux-2.5.66-s390/include/asm-s390x/param.h
--- linux-2.5.66/include/asm-s390x/param.h	2003-03-24 13:59:46.000000000 -0800
+++ linux-2.5.66-s390/include/asm-s390x/param.h	2003-04-03 13:19:27.000000000 -0800
@@ -31,4 +31,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 25	/* param.parm deck for installs */
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-sh/param.h linux-2.5.66-s390/include/asm-sh/param.h
--- linux-2.5.66/include/asm-sh/param.h	2003-03-24 14:01:47.000000000 -0800
+++ linux-2.5.66-s390/include/asm-sh/param.h	2003-04-03 13:18:21.000000000 -0800
@@ -21,4 +21,7 @@
 #define CLOCKS_PER_SEC	HZ	/* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* __ASM_SH_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-sparc/param.h linux-2.5.66-s390/include/asm-sparc/param.h
--- linux-2.5.66/include/asm-sparc/param.h	2003-03-24 14:00:08.000000000 -0800
+++ linux-2.5.66-s390/include/asm-sparc/param.h	2003-04-03 13:18:29.000000000 -0800
@@ -24,4 +24,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-sparc64/param.h linux-2.5.66-s390/include/asm-sparc64/param.h
--- linux-2.5.66/include/asm-sparc64/param.h	2003-03-24 13:59:54.000000000 -0800
+++ linux-2.5.66-s390/include/asm-sparc64/param.h	2003-04-03 13:18:25.000000000 -0800
@@ -24,4 +24,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* _ASMSPARC64_PARAM_H */
diff -urN -X dontdiff linux-2.5.66/include/asm-um/param.h linux-2.5.66-s390/include/asm-um/param.h
--- linux-2.5.66/include/asm-um/param.h	2003-03-24 14:00:03.000000000 -0800
+++ linux-2.5.66-s390/include/asm-um/param.h	2003-04-03 13:18:34.000000000 -0800
@@ -19,4 +19,7 @@
 #define CLOCKS_PER_SEC (USER_HZ)  /* frequency at which times() counts */
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/include/asm-v850/param.h linux-2.5.66-s390/include/asm-v850/param.h
--- linux-2.5.66/include/asm-v850/param.h	2003-03-24 14:01:53.000000000 -0800
+++ linux-2.5.66-s390/include/asm-v850/param.h	2003-04-03 13:18:39.000000000 -0800
@@ -33,4 +33,7 @@
 # define CLOCKS_PER_SEC	USER_HZ
 #endif
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif /* __V850_PARAM_H__ */
diff -urN -X dontdiff linux-2.5.66/include/asm-x86_64/param.h linux-2.5.66-s390/include/asm-x86_64/param.h
--- linux-2.5.66/include/asm-x86_64/param.h	2003-03-24 14:00:46.000000000 -0800
+++ linux-2.5.66-s390/include/asm-x86_64/param.h	2003-04-03 13:18:44.000000000 -0800
@@ -23,4 +23,7 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#define MAX_INIT_ARGS 8
+#define MAX_INIT_ENVS 8
+
 #endif
diff -urN -X dontdiff linux-2.5.66/init/main.c linux-2.5.66-s390/init/main.c
--- linux-2.5.66/init/main.c	2003-03-24 14:00:08.000000000 -0800
+++ linux-2.5.66-s390/init/main.c	2003-04-03 13:20:13.000000000 -0800
@@ -39,6 +39,7 @@
 
 #include <asm/io.h>
 #include <asm/bugs.h>
+#include <asm/param.h>
 
 /*
  * This is one of the first .c files built. Error out early
@@ -98,12 +99,6 @@
  */
 int system_running = 0;
 
-/*
- * Boot command-line arguments
- */
-#define MAX_INIT_ARGS 8
-#define MAX_INIT_ENVS 8
-
 extern void time_init(void);
 extern void softirq_init(void);
 
