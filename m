Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293533AbSBZHQg>; Tue, 26 Feb 2002 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293532AbSBZHQ2>; Tue, 26 Feb 2002 02:16:28 -0500
Received: from 24-168-148-159.nj.rr.com ([24.168.148.159]:52079 "HELO
	larvalstage.com") by vger.kernel.org with SMTP id <S292318AbSBZHQQ>;
	Tue, 26 Feb 2002 02:16:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: John Kim <john@larvalstage.com>
Reply-To: john@larvalstage.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] broken compile fixes for 2.4.18 or 2.4.19-pre1
Date: Tue, 26 Feb 2002 02:22:37 -0500
X-Mailer: KMail [version 1.3.1]
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020226072237.A5EA8247B8@larvalstage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found few places with broken open or close comment.  
This patch applies cleanly to either 2.4.18 or 2.4.19-pre1.

John Kim


--- arch/arm/kernel/dma-arc.c	Wed Jul  4 17:56:44 2001
+++ arch/arm/kernel/dma-arc.c	Sun Feb 24 05:31:48 2002
@@ -96,7 +96,7 @@
 	/* 10/1/1999 DAG - Presume whether there is an outstanding command? */
 	extern unsigned int fdc1772_fdc_int_done;

-	* Explicit! If the int done is 0 then 1 int to go */
+	/* Explicit! If the int done is 0 then 1 int to go */
 	return (fdc1772_fdc_int_done==0)?1:0;
 }


--- arch/cris/drivers/lpslave/e100lpslavenet.c	Thu Jul 26 18:10:06 2001
+++ arch/cris/drivers/lpslave/e100lpslavenet.c	Sun Feb 24 05:32:42 2002
@@ -310,7 +310,7 @@
 		IO_STATE(R_PAR0_CONFIG, iautofd, noninv)    |
           /* Not used in reverse direction, don't care */
 		IO_STATE(R_PAR0_CONFIG, istrb,   noninv)    |
-          /* Not connected, don't care /
+          /* Not connected, don't care */
 		IO_STATE(R_PAR0_CONFIG, iinit,   noninv)    |
           /* perror is GND and reverse wants 0, noninv */
 		IO_STATE(R_PAR0_CONFIG, iperr,   noninv)    |

--- arch/mips/kernel/smp.c	Fri Dec 21 12:41:53 2001
+++ arch/mips/kernel/smp.c	Sun Feb 24 05:34:18 2002
@@ -156,7 +156,7 @@
 		sprintf(p->comm, "%s%d", "Idle", i);
 		init_tasks[i] = p;
 		p->processor = i;
-		p->cpus_runnable = 1 << i; /* we schedule the first task manually *
+		p->cpus_runnable = 1 << i; /* we schedule the first task manually */
 		del_from_runqueue(p);
 		unhash_process(p);
 		/* Attach to the address space of init_task. */

--- arch/mips64/math-emu/cp1emu.c	Sun Sep  9 13:43:02 2001
+++ arch/mips64/math-emu/cp1emu.c	Sun Feb 24 05:31:12 2002
@@ -29,7 +29,7 @@
  * Notes:
  *  1) the IEEE754 library (-le) performs the actual arithmetic;
  *  2) if you know that you won't have an fpu, then you'll get much
- *     better performance by compiling with -msoft-float!  */
+ *     better performance by compiling with -msoft-float!
  *
  *  Nov 7, 2000
  *  Massive changes to integrate with Linux kernel.

--- drivers/char/rocket_int.h	Mon Dec 11 15:51:57 2000
+++ drivers/char/rocket_int.h	Sun Feb 24 05:33:02 2002
@@ -185,7 +185,7 @@

 /* Old clock prescale definition and baud rates associated with it */

-#define CLOCK_PRESC 0x19  */        /* mod 9 (divide by 10) prescale */
+#define CLOCK_PRESC 0x19          /* mod 9 (divide by 10) prescale */
 #define BRD50             4607
 #define BRD75             3071
 #define BRD110            2094

--- drivers/char/serial_tx3912.h	Fri Sep  7 12:28:38 2001
+++ drivers/char/serial_tx3912.h	Sun Feb 24 05:33:26 2002
@@ -24,7 +24,7 @@
 #define UART_TXOVERRUN_INT  3  /* transmit overrun error          (25, 15) */
 #define UART_EMPTY_INT      2  /* both trans/recv regs empty      (24, 14) */
 #define UART_DMAFULL_INT    1  /* DMA at end of buffer            (23, 13) */
-#define UART_DMAHALF_INT    0  /* DMA halfway through buffer */   (22, 12) */
+#define UART_DMAHALF_INT    0  /* DMA halfway through buffer      (22, 12) */

 #define UARTA_SHIFT        22
 #define UARTB_SHIFT        12


