Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUEFTC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUEFTC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUEFS72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:59:28 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:8015 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262273AbUEFSt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:57 -0400
Date: Thu, 6 May 2004 11:48:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 5/15] pj-fix-5-syscall-return-semicolon
Message-Id: <20040506114826.199feb1e.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes to system call return value were missing a semi-colon.

Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-sparc/unistd.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-sparc/unistd.h	2004-05-06 03:57:38.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-sparc/unistd.h	2004-05-06 04:37:39.000000000 -0700
@@ -325,7 +325,7 @@
 		      : "=r" (__res)\
 		      : "r" (__g1) \
 		      : "o0", "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall1(type,name,type1,arg1) \
@@ -342,7 +342,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall2(type,name,type1,arg1,type2,arg2) \
@@ -360,7 +360,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
@@ -379,7 +379,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
@@ -399,7 +399,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 } 
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
@@ -421,7 +421,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 #ifdef __KERNEL_SYSCALLS__
 
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-sparc64/unistd.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-sparc64/unistd.h	2004-05-06 03:57:38.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-sparc64/unistd.h	2004-05-06 04:37:39.000000000 -0700
@@ -324,7 +324,7 @@
 		      : "=r" (__res)\
 		      : "r" (__g1) \
 		      : "o0", "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall1(type,name,type1,arg1) \
@@ -339,7 +339,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall2(type,name,type1,arg1,type2,arg2) \
@@ -355,7 +355,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
@@ -372,7 +372,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
@@ -390,7 +390,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 } 
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
@@ -410,7 +410,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
 		      : "cc"); \
-	__syscall_return(type, __res) \
+	__syscall_return(type, __res); \
 }
 #ifdef __KERNEL_SYSCALLS__
 
Index: 2.6.6-rc3-mm2-bitmapv5/include/asm-mips/unistd.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/asm-mips/unistd.h	2004-05-06 03:57:38.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/asm-mips/unistd.h	2004-05-06 04:39:10.000000000 -0700
@@ -847,7 +847,7 @@
 	: "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 /*
@@ -871,7 +871,7 @@
 	: "r" (__a0), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall2(type,name,atype,a,btype,b) \
@@ -892,7 +892,7 @@
 	: "r" (__a0), "r" (__a1), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall3(type,name,atype,a,btype,b,ctype,c) \
@@ -914,7 +914,7 @@
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall4(type,name,atype,a,btype,b,ctype,c,dtype,d) \
@@ -936,7 +936,7 @@
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #if (_MIPS_SIM == _MIPS_SIM_ABI32)
@@ -969,7 +969,7 @@
 	  "m" ((unsigned long)e) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
@@ -998,7 +998,7 @@
 	  "m" ((unsigned long)e), "m" ((unsigned long)f) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */
@@ -1025,7 +1025,7 @@
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
@@ -1050,7 +1050,7 @@
 	  "i" (__NR_##name) \
 	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	__syscall_return(type, __v0) \
+	__syscall_return(type, __v0); \
 }
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
