Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUFSLUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUFSLUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 07:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUFSLUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 07:20:21 -0400
Received: from aun.it.uu.se ([130.238.12.36]:7126 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265489AbUFSLUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 07:20:16 -0400
Date: Sat, 19 Jun 2004 13:20:06 +0200 (MEST)
Message-Id: <200406191120.i5JBK6tL025970@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH][2.4.27-pre6] x86_64 bluesmoke linkage error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

2.4.27-pre6 changed arch/x86_64/kernel/bluesmoke.c to
reference safe_smp_processor_id(), causing a linkage
error in UP kernels. Fixed by including <asm/smp.h>.

/Mikael

--- linux-2.4.27-pre6/arch/x86_64/kernel/bluesmoke.c.~1~	2004-06-19 12:36:05.000000000 +0200
+++ linux-2.4.27-pre6/arch/x86_64/kernel/bluesmoke.c	2004-06-19 13:05:37.000000000 +0200
@@ -19,6 +19,7 @@
 #include <asm/processor.h> 
 #include <asm/msr.h>
 #include <asm/kdebug.h>
+#include <asm/smp.h>
 
 static int mce_disabled __initdata;
 static unsigned long mce_cpus; 
