Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSCUCVM>; Wed, 20 Mar 2002 21:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSCUCUx>; Wed, 20 Mar 2002 21:20:53 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:2360 "HELO
	larvalstage.com") by vger.kernel.org with SMTP id <S291401AbSCUCUt>;
	Wed, 20 Mar 2002 21:20:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: John Kim <john@larvalstage.com>
Reply-To: john@larvalstage.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial broken compile fixes for 2.4.19-pre4
Date: Wed, 20 Mar 2002 21:28:55 -0500
X-Mailer: KMail [version 1.3.1]
Cc: marcelo@connectiva.com.br, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020321022855.4788C23BAA@larvalstage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo and Alan,

This patch fixes trivial syntax errors due to missing comment open or close or one too many comment open or close.  It will fix some compile errors as a result.  It should apply cleanly to 2.4.19-pre4.  Thanks.

John Kim



diff -Naur linux/arch/arm/kernel/dma-arc.c linux-new/arch/arm/kernel/dma-arc.c
--- linux/arch/arm/kernel/dma-arc.c	Wed Jul  4 17:56:44 2001
+++ linux-new/arch/arm/kernel/dma-arc.c	Wed Mar 20 20:47:35 2002
@@ -96,7 +96,7 @@
 	/* 10/1/1999 DAG - Presume whether there is an outstanding command? */
 	extern unsigned int fdc1772_fdc_int_done;
 
-	* Explicit! If the int done is 0 then 1 int to go */
+	/* Explicit! If the int done is 0 then 1 int to go */
 	return (fdc1772_fdc_int_done==0)?1:0;
 }
 
diff -Naur linux/arch/mips64/math-emu/cp1emu.c linux-new/arch/mips64/math-emu/cp1emu.c
--- linux/arch/mips64/math-emu/cp1emu.c	Wed Mar 20 20:31:38 2002
+++ linux-new/arch/mips64/math-emu/cp1emu.c	Wed Mar 20 20:46:31 2002
@@ -29,7 +29,7 @@
  * Notes: 
  *  1) the IEEE754 library (-le) performs the actual arithmetic;
  *  2) if you know that you won't have an fpu, then you'll get much 
- *     better performance by compiling with -msoft-float!  */
+ *     better performance by compiling with -msoft-float!
  *
  *  Nov 7, 2000
  *  Massive changes to integrate with Linux kernel.
diff -Naur linux/drivers/char/rocket_int.h linux-new/drivers/char/rocket_int.h
--- linux/drivers/char/rocket_int.h	Mon Dec 11 15:51:57 2000
+++ linux-new/drivers/char/rocket_int.h	Wed Mar 20 20:46:55 2002
@@ -185,7 +185,7 @@
 
 /* Old clock prescale definition and baud rates associated with it */
 
-#define CLOCK_PRESC 0x19  */        /* mod 9 (divide by 10) prescale */
+#define CLOCK_PRESC 0x19          /* mod 9 (divide by 10) prescale */
 #define BRD50             4607
 #define BRD75             3071
 #define BRD110            2094
diff -Naur linux/fs/udf/ecma_167.h linux-new/fs/udf/ecma_167.h
--- linux/fs/udf/ecma_167.h	Wed Mar 20 20:31:40 2002
+++ linux-new/fs/udf/ecma_167.h	Wed Mar 20 20:45:53 2002
@@ -606,7 +606,7 @@
 #define FE_RECORD_FMT_CRLF		0x0A
 #define FE_RECORD_FMT_LFCR		0x0B
 
-#define Record Display Attributes (ECMA 167r3 4/14.9.8) */
+/* Record Display Attributes (ECMA 167r3 4/14.9.8) */
 #define FE_RECORD_DISPLAY_ATTR_UNDEF	0x00
 #define FE_RECORD_DISPLAY_ATTR_1	0x01
 #define FE_RECORD_DISPLAY_ATTR_2	0x02
