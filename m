Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311630AbSCNOp0>; Thu, 14 Mar 2002 09:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311632AbSCNOpQ>; Thu, 14 Mar 2002 09:45:16 -0500
Received: from dialup-7-5.net.ic.ac.uk ([155.198.8.101]:47488 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S311630AbSCNOpE>; Thu, 14 Mar 2002 09:45:04 -0500
Date: Thu, 14 Mar 2002 14:49:53 +0000
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.21 crash on boot fix.
Message-ID: <20020314144953.A11010@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Patch below fixes the crash-on-boot problem Leonard Zubkoff found.


diff -urN --exclude-from=/home/davej/.exclude linux-rc1/arch/i386/kernel/setup.c linux-rc1-dj1/arch/i386/kernel/setup.c
--- linux-rc1/arch/i386/kernel/setup.c	Thu Mar 14 12:48:56 2002
+++ linux-rc1-dj1/arch/i386/kernel/setup.c	Thu Mar 14 13:38:02 2002
@@ -1081,7 +1081,7 @@
 
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
-	char *p;
+	char *p = NULL;
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
 	if (c->cpuid_level > 1) {

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
