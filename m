Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUEOIYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUEOIYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUEOIYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 04:24:36 -0400
Received: from ozlabs.org ([203.10.76.45]:44235 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264668AbUEOIYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 04:24:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16549.54177.936133.186576@cargo.ozlabs.ibm.com>
Date: Sat, 15 May 2004 18:24:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Some whitespace fixes
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does nothing but fix up whitespace in three files in
arch/ppc.  It deletes trailing blanks and tabs in several places and
joins two lines that didn't need to be split.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/platforms/pmac_pic.c pmac-2.5/arch/ppc/platforms/pmac_pic.c
--- linux-2.5/arch/ppc/platforms/pmac_pic.c	2004-03-03 16:04:18.000000000 +1100
+++ pmac-2.5/arch/ppc/platforms/pmac_pic.c	2004-03-16 20:09:38.000000000 +1100
@@ -260,7 +260,7 @@
 					node->child->intrs = &gatwick_int_pool[count];
 					count += 3;
 				}
-				node->child->n_intrs = 3;			
+				node->child->n_intrs = 3;
 				node->child->intrs[0].line = 15+irq_base;
 				node->child->intrs[1].line =  4+irq_base;
 				node->child->intrs[2].line =  5+irq_base;
@@ -279,7 +279,7 @@
 			node->intrs[0].line = 29+irq_base;
 			printk(KERN_INFO "irq: fixed media-bay on second controller (%d)\n",
 					node->intrs[0].line);
-		
+
 			ya_node = node->child;
 			while(ya_node)
 			{
@@ -501,7 +501,7 @@
 				pmac_irq_hw[i] = (volatile struct pmac_irq_hw*)
 					(addr + (2 - i) * 0x10);
 		}
-	
+
 		/* get addresses of second controller */
 		irqctrler = irqctrler->next;
 		if (irqctrler && irqctrler->n_addrs > 0) {
diff -urN linux-2.5/arch/ppc/platforms/pmac_setup.c pmac-2.5/arch/ppc/platforms/pmac_setup.c
--- linux-2.5/arch/ppc/platforms/pmac_setup.c	2004-02-06 22:15:13.000000000 +1100
+++ pmac-2.5/arch/ppc/platforms/pmac_setup.c	2004-05-08 17:16:35.000000000 +1000
@@ -136,7 +136,7 @@
 
 	if (pmac_call_feature(PMAC_FTR_GET_MB_INFO, NULL, PMAC_MB_INFO_NAME, (int)&mbname) != 0)
 		mbname = "Unknown";
-	
+
 	/* find motherboard type */
 	seq_printf(m, "machine\t\t: ");
 	np = find_devices("device-tree");
@@ -196,7 +196,7 @@
 		int n;
 		struct reg_property *reg = (struct reg_property *)
 			get_property(np, "reg", &n);
-	
+
 		if (reg != 0) {
 			unsigned long total = 0;
 
@@ -207,9 +207,9 @@
 	}
 
 	/* Checks "l2cr-value" property in the registry */
-	np = find_devices("cpus");	
+	np = find_devices("cpus");
 	if (np == 0)
-		np = find_type_devices("cpu");	
+		np = find_type_devices("cpu");
 	if (np != 0) {
 		unsigned int *l2cr = (unsigned int *)
 			get_property(np, "l2cr-value", NULL);
@@ -277,9 +277,9 @@
 
 	/* Checks "l2cr-value" property in the registry */
 	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
-		struct device_node *np = find_devices("cpus");	
+		struct device_node *np = find_devices("cpus");
 		if (np == 0)
-			np = find_type_devices("cpu");	
+			np = find_type_devices("cpu");
 		if (np != 0) {
 			unsigned int *l2cr = (unsigned int *)
 				get_property(np, "l2cr-value", NULL);
@@ -478,11 +478,11 @@
 			cuda_poll();
 		break;
 #endif /* CONFIG_ADB_CUDA */
-#ifdef CONFIG_ADB_PMU	
+#ifdef CONFIG_ADB_PMU
 	case SYS_CTRLER_PMU:
 		pmu_restart();
 		break;
-#endif /* CONFIG_ADB_PMU */	
+#endif /* CONFIG_ADB_PMU */
 	default: ;
 	}
 }
diff -urN linux-2.5/arch/ppc/syslib/prom_init.c pmac-2.5/arch/ppc/syslib/prom_init.c
--- linux-2.5/arch/ppc/syslib/prom_init.c	2004-02-06 22:15:13.000000000 +1100
+++ pmac-2.5/arch/ppc/syslib/prom_init.c	2004-03-11 17:08:56.000000000 +1100
@@ -800,8 +800,7 @@
 
 	/* First get a handle for the stdout device */
 	prom = pp;
-	prom_chosen = call_prom("finddevice", 1, 1,
-				       "/chosen");
+	prom_chosen = call_prom("finddevice", 1, 1, "/chosen");
 	if (prom_chosen == (void *)-1)
 		prom_exit();
 	if ((int) call_prom("getprop", 4, 1, prom_chosen,
