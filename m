Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318945AbSHEXvy>; Mon, 5 Aug 2002 19:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSHEXvy>; Mon, 5 Aug 2002 19:51:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63961 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318945AbSHEXvx>;
	Mon, 5 Aug 2002 19:51:53 -0400
Date: Mon, 05 Aug 2002 16:53:33 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA-Q xquad_portio declaration
Message-ID: <349340000.1028591613@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Matt Dobson. It corrects the definition of
xquad_portio, getting rid of a compile warning.
Tested on NUMA-Q and std 2-way SMP system through LTP.

Please apply,

Martin.

diff -Nur linux-2.5.25-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.25-patched/arch/i386/boot/compressed/misc.c
--- linux-2.5.25-vanilla/arch/i386/boot/compressed/misc.c	Fri Jul  5 16:42:31 2002
+++ linux-2.5.25-patched/arch/i386/boot/compressed/misc.c	Thu Jul 11 15:30:03 2002
@@ -121,7 +121,7 @@
 static int lines, cols;
 
 #ifdef CONFIG_MULTIQUAD
-static void * const xquad_portio = NULL;
+static void * xquad_portio = NULL;
 #endif
 
 #include "../../../../lib/inflate.c"

