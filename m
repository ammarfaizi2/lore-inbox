Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWIMIGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWIMIGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWIMIGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:06:00 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:49393 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751681AbWIMIF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:05:59 -0400
Date: Wed, 13 Sep 2006 10:07:08 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: -mm patch] AVR32: Remove set_wmb()
Message-ID: <20060913100708.39735131@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove definition of set_wmb on AVR32 since it isn't used. This has
already been done for all other architectures by commit
52393ccc0a53c130f31fbbdb8b40b2aadb55ee72 in Linus' tree.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/system.h |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.18-rc5-mm1/include/asm-avr32/system.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/asm-avr32/system.h	2006-09-06 17:11:21.000000000 +0200
+++ linux-2.6.18-rc5-mm1/include/asm-avr32/system.h	2006-09-06 17:11:26.000000000 +0200
@@ -24,7 +24,6 @@
 #define wmb()			asm volatile("sync 0" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
 #define set_mb(var, value)      do { var = value; mb(); } while(0)
-#define set_wmb(var, value)     do { var = value; wmb(); } while(0)
 
 /*
  * Help PathFinder and other Nexus-compliant debuggers keep track of
