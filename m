Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTAISxA>; Thu, 9 Jan 2003 13:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTAISxA>; Thu, 9 Jan 2003 13:53:00 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:39647 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266941AbTAISxA>; Thu, 9 Jan 2003 13:53:00 -0500
Date: Thu, 9 Jan 2003 20:02:40 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.55] cpufreq: new p4-m stepping 7
Message-ID: <20030109190240.GA10449@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mobile Pentium IV processors with stepping 7.

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-09 19:15:40.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-09 19:20:33.000000000 +0100
@@ -447,7 +447,7 @@
 		if (c->x86_model != 2)
 			return 0;
 
-		if (c->x86_mask != 4)
+		if ((c->x86_mask != 4) && (c->x86_mask != 7))
 			return 0;
 
 		ebx = cpuid_ebx(0x00000001);
