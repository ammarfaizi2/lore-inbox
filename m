Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSFPCFg>; Sat, 15 Jun 2002 22:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSFPCFf>; Sat, 15 Jun 2002 22:05:35 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:32525 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S315785AbSFPCFf>;
	Sat, 15 Jun 2002 22:05:35 -0400
Date: Sat, 15 Jun 2002 22:05:34 -0400
From: Rob Radez <rob@osinvestor.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        engebret@us.ibm.com, rth@twiddle.net
Subject: [PATCH] Remove useless include/asm-*/floppy.h code
Message-ID: <20020615220534.C9029@osinvestor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Attached patch removes some useless code.  Should apply to 2.4.19-pre10 and
2.5.21.  Not sure if the code is still in relevant arch trees, but various
people cc'd so that it can be eliminated.

Regards,
Rob Radez

diff -ruN stock-2.4.19pre10/include/asm-alpha/floppy.h floppy-2.4.19pre10/include/asm-alpha/floppy.h
--- stock-2.4.19pre10/include/asm-alpha/floppy.h	Fri Jun 14 18:48:58 2002
+++ floppy-2.4.19pre10/include/asm-alpha/floppy.h	Sat Jun 15 21:47:04 2002
@@ -76,11 +76,6 @@
 
 #endif /* CONFIG_PCI */
 
-__inline__ void virtual_dma_init(void)
-{
-	/* Nothing to do on an Alpha */
-}
-
 static int FDC1 = 0x3f0;
 static int FDC2 = -1;
 
diff -ruN stock-2.4.19pre10/include/asm-ppc/floppy.h floppy-2.4.19pre10/include/asm-ppc/floppy.h
--- stock-2.4.19pre10/include/asm-ppc/floppy.h	Fri Jun 14 18:49:15 2002
+++ floppy-2.4.19pre10/include/asm-ppc/floppy.h	Sat Jun 15 21:47:12 2002
@@ -33,11 +33,6 @@
 				            "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
-__inline__ void virtual_dma_init(void)
-{
-	/* Nothing to do on PowerPC */
-}
-
 static int FDC1 = 0x3f0;
 static int FDC2 = -1;
 
diff -ruN stock-2.4.19pre10/include/asm-ppc64/floppy.h floppy-2.4.19pre10/include/asm-ppc64/floppy.h
--- stock-2.4.19pre10/include/asm-ppc64/floppy.h	Fri Jun 14 18:49:01 2002
+++ floppy-2.4.19pre10/include/asm-ppc64/floppy.h	Sat Jun 15 21:47:16 2002
@@ -76,11 +76,6 @@
 
 #endif /* CONFIG_PCI */
 
-__inline__ void virtual_dma_init(void)
-{
-	/* Nothing to do on PowerPC */
-}
-
 static int FDC1 = 0x3f0;
 static int FDC2 = -1;
 
diff -ruN stock-2.4.19pre10/include/asm-sparc/floppy.h floppy-2.4.19pre10/include/asm-sparc/floppy.h
--- stock-2.4.19pre10/include/asm-sparc/floppy.h	Fri Jun 14 18:49:02 2002
+++ floppy-2.4.19pre10/include/asm-sparc/floppy.h	Sat Jun 15 21:47:20 2002
@@ -217,11 +217,6 @@
 unsigned long pdma_areasize;
 
 /* Common routines to all controller types on the Sparc. */
-static __inline__ void virtual_dma_init(void)
-{
-	/* nothing... */
-}
-
 static __inline__ void sun_fd_disable_dma(void)
 {
 	doing_pdma = 0;
