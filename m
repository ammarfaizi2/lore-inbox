Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSKRQnO>; Mon, 18 Nov 2002 11:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSKRQnN>; Mon, 18 Nov 2002 11:43:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262881AbSKRQnN>;
	Mon, 18 Nov 2002 11:43:13 -0500
Date: Mon, 18 Nov 2002 16:50:10 +0000
From: Matthew Wilcox <willy@debian.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix topology.c
Message-ID: <20021118165010.K7530@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Missing smp.h

diff -urpNX dontdiff linux-2.5.48/arch/i386/mach-generic/topology.c linux-2.5.48-header/arch/i386/mach-generic/topology.c
--- linux-2.5.48/arch/i386/mach-generic/topology.c	2002-11-17 23:29:53.000000000 -0500
+++ linux-2.5.48-header/arch/i386/mach-generic/topology.c	2002-11-18 10:16:10.000000000 -0500
@@ -26,6 +26,7 @@
  * Send feedback to <colpatch@us.ibm.com>
  */
 #include <linux/init.h>
+#include <linux/smp.h>
 #include <asm/cpu.h>
 
 struct i386_cpu cpu_devices[NR_CPUS];

-- 
Revolutions do not require corporate support.
