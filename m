Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVHXLUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVHXLUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVHXLUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:20:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750876AbVHXLUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:20:17 -0400
Date: Wed, 24 Aug 2005 13:20:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [2.6 patch] i386/x86_64: make get_cpu_vendor() static
Message-ID: <20050824112015.GP5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_cpu_vendor() no longer has any users in other files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/cpu/common.c |    2 +-
 arch/x86_64/kernel/setup.c    |    2 +-
 include/asm-x86_64/proto.h    |    1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.13-rc6-mm1-full/arch/i386/kernel/cpu/common.c.old	2005-08-23 01:42:41.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/i386/kernel/cpu/common.c	2005-08-23 01:43:12.000000000 +0200
@@ -151,7 +151,7 @@
 }
 
 
-void __devinit get_cpu_vendor(struct cpuinfo_x86 *c, int early)
+static void __devinit get_cpu_vendor(struct cpuinfo_x86 *c, int early)
 {
 	char *v = c->x86_vendor_id;
 	int i;
--- linux-2.6.13-rc6-mm1-full/include/asm-x86_64/proto.h.old	2005-08-23 01:43:21.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/include/asm-x86_64/proto.h	2005-08-23 01:43:27.000000000 +0200
@@ -8,7 +8,6 @@
 struct cpuinfo_x86; 
 struct pt_regs;
 
-extern void get_cpu_vendor(struct cpuinfo_x86*);
 extern void start_kernel(void);
 extern void pda_init(int); 
 
--- linux-2.6.13-rc6-mm1-full/arch/x86_64/kernel/setup.c.old	2005-08-23 01:43:35.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/x86_64/kernel/setup.c	2005-08-23 01:43:47.000000000 +0200
@@ -929,7 +929,7 @@
  	c->x86_num_cores = intel_num_cpu_cores(c);
 }
 
-void __cpuinit get_cpu_vendor(struct cpuinfo_x86 *c)
+static void __cpuinit get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
 

