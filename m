Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292925AbSB1Xcr>; Thu, 28 Feb 2002 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310215AbSB1X3C>; Thu, 28 Feb 2002 18:29:02 -0500
Received: from 24-168-148-159.nj.rr.com ([24.168.148.159]:17747 "HELO
	larvalstage.com") by vger.kernel.org with SMTP id <S310204AbSB1XXo>;
	Thu, 28 Feb 2002 18:23:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: John Kim <john@larvalstage.com>
Reply-To: john@larvalstage.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] broken compile fixes for 2.4.18 or 2.4.19-pre1
Date: Thu, 28 Feb 2002 18:30:17 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.21.0202281259260.2117-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202281259260.2117-100000@freak.distro.conectiva>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020228233018.F04E024B95@larvalstage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 February 2002 11:00 am, you wrote:
> Your patch has not applied cleanly here in some places.
>
> Please regenerate it against -pre2 as soon as its out and resend me.
>
> Thanks
>
> On Tue, 26 Feb 2002, John Kim wrote:
> > I found few places with broken open or close comment.
> > This patch applies cleanly to either 2.4.18 or 2.4.19-pre1.

Sorry about that.   Here is new patch to apply against 2.4.19-pre2.  Thanks.

John Kim



--- arch/arm/kernel/dma-arc.c	Wed Jul  4 17:56:44 2001
+++ arch/arm/kernel/dma-arc.c	Thu Feb 28 17:45:18 2002
@@ -96,7 +96,7 @@
 	/* 10/1/1999 DAG - Presume whether there is an outstanding command? */
 	extern unsigned int fdc1772_fdc_int_done;
 
-	* Explicit! If the int done is 0 then 1 int to go */
+	/* Explicit! If the int done is 0 then 1 int to go */
 	return (fdc1772_fdc_int_done==0)?1:0;
 }
 
--- arch/cris/drivers/lpslave/e100lpslavenet.c	Thu Jul 26 18:10:06 2001
+++ arch/cris/drivers/lpslave/e100lpslavenet.c	Thu Feb 28 17:46:31 2002
@@ -310,7 +310,7 @@
 		IO_STATE(R_PAR0_CONFIG, iautofd, noninv)    |
           /* Not used in reverse direction, don't care */
 		IO_STATE(R_PAR0_CONFIG, istrb,   noninv)    |
-          /* Not connected, don't care /
+          /* Not connected, don't care */
 		IO_STATE(R_PAR0_CONFIG, iinit,   noninv)    |
           /* perror is GND and reverse wants 0, noninv */
 		IO_STATE(R_PAR0_CONFIG, iperr,   noninv)    |
--- arch/mips64/math-emu/cp1emu.c	Thu Feb 28 17:30:25 2002
+++ arch/mips64/math-emu/cp1emu.c	Thu Feb 28 17:46:59 2002
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
+++ drivers/char/rocket_int.h	Thu Feb 28 17:48:16 2002
@@ -185,7 +185,7 @@
 
 /* Old clock prescale definition and baud rates associated with it */
 
-#define CLOCK_PRESC 0x19  */        /* mod 9 (divide by 10) prescale */
+#define CLOCK_PRESC 0x19          /* mod 9 (divide by 10) prescale */
 #define BRD50             4607
 #define BRD75             3071
 #define BRD110            2094
