Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTHZIZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbTHZIZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:25:06 -0400
Received: from aneto.able.es ([212.97.163.22]:33163 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263362AbTHZIZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:25:00 -0400
Date: Tue, 26 Aug 2003 10:24:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4: always_inline for gcc3
Message-ID: <20030826082459.GC2017@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Resending for 2.4.23-pre ;)

--- 25/include/linux/compiler.h~gcc3-inline-fix	2003-03-06
03:02:43.000000000 -0800
+++ 25-akpm/include/linux/compiler.h	2003-03-06 03:11:42.000000000 -0800
@@ -1,6 +1,13 @@
 #ifndef __LINUX_COMPILER_H
 #define __LINUX_COMPILER_H
 
+#if __GNUC__ >= 3
+#define inline		__inline__ __attribute__((always_inline))
+#define inline__	__inline__ __attribute__((always_inline))
+#define __inline	__inline__ __attribute__((always_inline))
+#define __inline__	__inline__ __attribute__((always_inline))
+#endif
+
 /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
    a mechanism by which the user can annotate likely branch directions and
    expect the blocks to be reordered appropriately.  Define __builtin_expect


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
