Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVADFIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVADFIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVADEtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:49:16 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:24520 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262037AbVADEoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:44:06 -0500
Date: Tue, 4 Jan 2005 15:19:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/11] PPC64: remove /proc/ppc64/{naca,paca/xx}
Message-Id: <20050104151906.6e50f1d2.sfr@canb.auug.org.au>
In-Reply-To: <20050104151229.521e8083.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_19_06_+1100_fxwzyGQpTYvqA_d/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_19_06_+1100_fxwzyGQpTYvqA_d/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch removes the (unused) /proc entries for the naca and the (per
cpu) pacas.  Also it removes a lot of no longer necessary includes of
<asm/naca.h>.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.3/arch/ppc64/kernel/iSeries_pci.c linus-bk-naca.4/arch/ppc64/kernel/iSeries_pci.c
--- linus-bk-naca.3/arch/ppc64/kernel/iSeries_pci.c	2004-11-16 16:05:10.000000000 +1100
+++ linus-bk-naca.4/arch/ppc64/kernel/iSeries_pci.c	2004-12-10 16:26:54.000000000 +1100
@@ -35,7 +35,6 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppcdebug.h>
-#include <asm/naca.h>
 #include <asm/iommu.h>
 
 #include <asm/iSeries/HvCallPci.h>
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/iSeries_proc.c linus-bk-naca.4/arch/ppc64/kernel/iSeries_proc.c
--- linus-bk-naca.3/arch/ppc64/kernel/iSeries_proc.c	2004-10-22 07:00:21.000000000 +1000
+++ linus-bk-naca.4/arch/ppc64/kernel/iSeries_proc.c	2004-12-10 16:26:54.000000000 +1100
@@ -24,7 +24,6 @@
 #include <asm/paca.h>
 #include <asm/processor.h>
 #include <asm/time.h>
-#include <asm/naca.h>
 #include <asm/iSeries/ItLpPaca.h>
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/iSeries/HvCallXm.h>
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/iSeries_smp.c linus-bk-naca.4/arch/ppc64/kernel/iSeries_smp.c
--- linus-bk-naca.3/arch/ppc64/kernel/iSeries_smp.c	2004-10-30 08:33:22.000000000 +1000
+++ linus-bk-naca.4/arch/ppc64/kernel/iSeries_smp.c	2004-12-10 16:26:54.000000000 +1100
@@ -37,7 +37,6 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/smp.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/iSeries/LparData.h>
 #include <asm/iSeries/HvCall.h>
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/pSeries_pci.c linus-bk-naca.4/arch/ppc64/kernel/pSeries_pci.c
--- linus-bk-naca.3/arch/ppc64/kernel/pSeries_pci.c	2004-12-31 14:53:21.000000000 +1100
+++ linus-bk-naca.4/arch/ppc64/kernel/pSeries_pci.c	2004-12-10 16:26:54.000000000 +1100
@@ -36,7 +36,6 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/naca.h>
 #include <asm/iommu.h>
 #include <asm/rtas.h>
 
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/pSeries_smp.c linus-bk-naca.4/arch/ppc64/kernel/pSeries_smp.c
--- linus-bk-naca.3/arch/ppc64/kernel/pSeries_smp.c	2004-12-31 15:22:45.000000000 +1100
+++ linus-bk-naca.4/arch/ppc64/kernel/pSeries_smp.c	2004-12-31 15:27:45.000000000 +1100
@@ -38,7 +38,6 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/time.h>
 #include <asm/ppcdebug.h>
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/pci_dn.c linus-bk-naca.4/arch/ppc64/kernel/pci_dn.c
--- linus-bk-naca.3/arch/ppc64/kernel/pci_dn.c	2004-10-25 18:18:33.000000000 +1000
+++ linus-bk-naca.4/arch/ppc64/kernel/pci_dn.c	2004-12-10 16:26:54.000000000 +1100
@@ -33,7 +33,6 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppcdebug.h>
-#include <asm/naca.h>
 #include <asm/iommu.h>
 
 #include "pci.h"
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/proc_ppc64.c linus-bk-naca.4/arch/ppc64/kernel/proc_ppc64.c
--- linus-bk-naca.3/arch/ppc64/kernel/proc_ppc64.c	2004-10-27 07:32:57.000000000 +1000
+++ linus-bk-naca.4/arch/ppc64/kernel/proc_ppc64.c	2004-12-10 16:26:54.000000000 +1100
@@ -25,8 +25,6 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 
-#include <asm/naca.h>
-#include <asm/paca.h>
 #include <asm/systemcfg.h>
 #include <asm/rtas.h>
 #include <asm/uaccess.h>
@@ -58,26 +56,6 @@
 #endif
 
 /*
- * NOTE: since paca data is always in flux the values will never be a
- * consistant set.
- */
-static void __init proc_create_paca(struct proc_dir_entry *dir, int num)
-{
-	struct proc_dir_entry *ent;
-	struct paca_struct *lpaca = paca + num;
-	char buf[16];
-
-	sprintf(buf, "%02x", num);
-	ent = create_proc_entry(buf, S_IRUSR, dir);
-	if (ent) {
-		ent->nlink = 1;
-		ent->data = lpaca;
-		ent->size = 4096;
-		ent->proc_fops = &page_map_fops;
-	}
-}
-
-/*
  * Create the ppc64 and ppc64/rtas directories early. This allows us to
  * assume that they have been previously created in drivers.
  */
@@ -104,17 +82,8 @@
 
 static int __init proc_ppc64_init(void)
 {
-	unsigned long i;
 	struct proc_dir_entry *pde;
 
-	pde = create_proc_entry("ppc64/naca", S_IRUSR, NULL);
-	if (!pde)
-		return 1;
-	pde->nlink = 1;
-	pde->data = naca;
-	pde->size = 4096;
-	pde->proc_fops = &page_map_fops;
-
 	pde = create_proc_entry("ppc64/systemcfg", S_IFREG|S_IRUGO, NULL);
 	if (!pde)
 		return 1;
@@ -123,13 +92,6 @@
 	pde->size = 4096;
 	pde->proc_fops = &page_map_fops;
 
-	/* /proc/ppc64/paca/XX -- raw paca contents.  Only readable to root */
-	pde = proc_mkdir("ppc64/paca", NULL);
-	if (!pde)
-		return 1;
-	for_each_cpu(i)
-		proc_create_paca(pde, i);
-
 #ifdef CONFIG_PPC_PSERIES
 	if ((systemcfg->platform & PLATFORM_PSERIES))
 		proc_ppc64_create_ofdt();
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/prom_init.c linus-bk-naca.4/arch/ppc64/kernel/prom_init.c
--- linus-bk-naca.3/arch/ppc64/kernel/prom_init.c	2004-12-08 12:07:34.000000000 +1100
+++ linus-bk-naca.4/arch/ppc64/kernel/prom_init.c	2004-12-10 16:26:54.000000000 +1100
@@ -43,7 +43,6 @@
 #include <asm/system.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/naca.h>
 #include <asm/pci.h>
 #include <asm/iommu.h>
 #include <asm/bootinfo.h>
diff -ruN linus-bk-naca.3/arch/ppc64/kernel/smp.c linus-bk-naca.4/arch/ppc64/kernel/smp.c
--- linus-bk-naca.3/arch/ppc64/kernel/smp.c	2004-12-14 04:07:06.000000000 +1100
+++ linus-bk-naca.4/arch/ppc64/kernel/smp.c	2004-12-31 15:29:14.000000000 +1100
@@ -41,7 +41,6 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/time.h>
 #include <asm/ppcdebug.h>
diff -ruN linus-bk-naca.3/arch/ppc64/mm/init.c linus-bk-naca.4/arch/ppc64/mm/init.c
--- linus-bk-naca.3/arch/ppc64/mm/init.c	2004-11-04 16:05:08.000000000 +1100
+++ linus-bk-naca.4/arch/ppc64/mm/init.c	2004-12-10 16:26:54.000000000 +1100
@@ -52,7 +52,6 @@
 #include <asm/smp.h>
 #include <asm/machdep.h>
 #include <asm/tlb.h>
-#include <asm/naca.h>
 #include <asm/eeh.h>
 #include <asm/processor.h>
 #include <asm/mmzone.h>
diff -ruN linus-bk-naca.3/arch/ppc64/mm/slb.c linus-bk-naca.4/arch/ppc64/mm/slb.c
--- linus-bk-naca.3/arch/ppc64/mm/slb.c	2004-09-06 10:19:04.000000000 +1000
+++ linus-bk-naca.4/arch/ppc64/mm/slb.c	2004-12-10 16:26:54.000000000 +1100
@@ -19,7 +19,6 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
-#include <asm/naca.h>
 #include <asm/cputable.h>
 
 extern void slb_allocate(unsigned long ea);
diff -ruN linus-bk-naca.3/arch/ppc64/mm/stab.c linus-bk-naca.4/arch/ppc64/mm/stab.c
--- linus-bk-naca.3/arch/ppc64/mm/stab.c	2004-09-16 21:51:57.000000000 +1000
+++ linus-bk-naca.4/arch/ppc64/mm/stab.c	2004-12-10 16:26:54.000000000 +1100
@@ -17,7 +17,6 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
-#include <asm/naca.h>
 #include <asm/cputable.h>
 
 /* Both the segment table and SLB code uses the following cache */
diff -ruN linus-bk-naca.3/include/asm-ppc64/iSeries/LparData.h linus-bk-naca.4/include/asm-ppc64/iSeries/LparData.h
--- linus-bk-naca.3/include/asm-ppc64/iSeries/LparData.h	2002-09-18 12:00:50.000000000 +1000
+++ linus-bk-naca.4/include/asm-ppc64/iSeries/LparData.h	2004-12-10 16:26:54.000000000 +1100
@@ -24,11 +24,9 @@
 #include <asm/page.h>
 #include <asm/abs_addr.h>
 
-#include <asm/naca.h>
 #include <asm/iSeries/ItLpNaca.h>
 #include <asm/iSeries/ItLpPaca.h>
 #include <asm/iSeries/ItLpRegSave.h>
-#include <asm/paca.h>
 #include <asm/iSeries/HvReleaseData.h>
 #include <asm/iSeries/LparMap.h>
 #include <asm/iSeries/ItVpdAreas.h>

--Signature=_Tue__4_Jan_2005_15_19_06_+1100_fxwzyGQpTYvqA_d/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hk64CJfqux9a+8RApxnAJ9nNBoZgEQ6XaHunQruXNrryFwDAwCfaPfd
7o2pBOb90tsH1CbBaoKlrRE=
=4EIl
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_19_06_+1100_fxwzyGQpTYvqA_d/--
