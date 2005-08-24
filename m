Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVHXI5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVHXI5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 04:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVHXI5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 04:57:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61967 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750762AbVHXI5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 04:57:52 -0400
Date: Wed, 24 Aug 2005 10:57:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] #include <asm/irq.h> in interrupt.h
Message-ID: <20050824085750.GG5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If #includ'ing interrupt.h should be enough for getting the prototype of 
e.g. enable_irq() on all architectures, we need this patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-modular/include/linux/interrupt.h.old	2005-08-22 23:44:42.000000000 +0200
+++ linux-2.6.13-rc6-mm1-modular/include/linux/interrupt.h	2005-08-22 23:45:04.000000000 +0200
@@ -12,6 +12,7 @@
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
+#include <asm/irq.h>
 
 /*
  * For 2.4.x compatibility, 2.4.x can use

