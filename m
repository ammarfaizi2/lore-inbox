Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263949AbRFZKNd>; Tue, 26 Jun 2001 06:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263485AbRFZKNX>; Tue, 26 Jun 2001 06:13:23 -0400
Received: from [203.143.19.4] ([203.143.19.4]:52486 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S263473AbRFZKNN>;
	Tue, 26 Jun 2001 06:13:13 -0400
Date: Tue, 26 Jun 2001 01:04:53 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] GCC v3 warning fixes #2
Message-ID: <20010626010453.B346@bee.lk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch fixes compiler warnings on a couple of __asm__ calls. Please let me know
if they effect the readability of the code (they _do_).

Regards,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.6-pre5)

If I were to walk on water, the press would say I'm only doing it
because I can't swim.
		-- Bob Stanfield


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-2

diff -u --recursive --new-file linux-2.4.6-pre5/drivers/acorn/net/ether1.c linux/drivers/acorn/net/ether1.c
--- linux-2.4.6-pre5/drivers/acorn/net/ether1.c	Mon Jun 25 23:50:27 2001
+++ linux/drivers/acorn/net/ether1.c	Tue Jun 26 00:37:29 2001
@@ -153,34 +153,34 @@
 		length -= thislen;
 
 		__asm__ __volatile__(
-	"subs	%3, %3, #2
-	bmi	2f
-1:	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bpl	1b
-2:	adds	%3, %3, #1
-	ldreqb	%0, [%1]
+	"subs	%3, %3, #2\n\
+	bmi	2f\n\
+1:	ldr	%0, [%1], #2\n\
+	mov	%0, %0, lsl #16\n\
+	orr	%0, %0, %0, lsr #16\n\
+	str	%0, [%2], #4\n\
+	subs	%3, %3, #2\n\
+	bmi	2f\n\
+	ldr	%0, [%1], #2\n\
+	mov	%0, %0, lsl #16\n\
+	orr	%0, %0, %0, lsr #16\n\
+	str	%0, [%2], #4\n\
+	subs	%3, %3, #2\n\
+	bmi	2f\n\
+	ldr	%0, [%1], #2\n\
+	mov	%0, %0, lsl #16\n\
+	orr	%0, %0, %0, lsr #16\n\
+	str	%0, [%2], #4\n\
+	subs	%3, %3, #2\n\
+	bmi	2f\n\
+	ldr	%0, [%1], #2\n\
+	mov	%0, %0, lsl #16\n\
+	orr	%0, %0, %0, lsr #16\n\
+	str	%0, [%2], #4\n\
+	subs	%3, %3, #2\n\
+	bpl	1b\n\
+2:	adds	%3, %3, #1\n\
+	ldreqb	%0, [%1]\n\
 	streqb	%0, [%2]"
 		: "=&r" (used), "=&r" (data)
 		: "r"  (addr), "r" (thislen), "1" (data));
@@ -215,34 +215,34 @@
 		length -= thislen;
 
 		__asm__ __volatile__(
-	"subs	%3, %3, #2
-	bmi	2f
-1:	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bpl	1b
-2:	adds	%3, %3, #1
-	ldreqb	%0, [%2]
+	"subs	%3, %3, #2\n\
+	bmi	2f\n\
+1:	ldr	%0, [%2], #4\n\
+	strb	%0, [%1], #1\n\
+	mov	%0, %0, lsr #8\n\
+	strb	%0, [%1], #1\n\
+	subs	%3, %3, #2\n\
+	bmi	2f\n\
+	ldr	%0, [%2], #4\n\
+	strb	%0, [%1], #1\n\
+	mov	%0, %0, lsr #8\n\
+	strb	%0, [%1], #1\n\
+	subs	%3, %3, #2\n\
+	bmi	2f\n\
+	ldr	%0, [%2], #4\n\
+	strb	%0, [%1], #1\n\
+	mov	%0, %0, lsr #8\n\
+	strb	%0, [%1], #1\n\
+	subs	%3, %3, #2\n\
+	bmi	2f\n\
+	ldr	%0, [%2], #4\n\
+	strb	%0, [%1], #1\n\
+	mov	%0, %0, lsr #8\n\
+	strb	%0, [%1], #1\n\
+	subs	%3, %3, #2\n\
+	bpl	1b\n\
+2:	adds	%3, %3, #1\n\
+	ldreqb	%0, [%2]\n\
 	streqb	%0, [%1]"
 		: "=&r" (used), "=&r" (data)
 		: "r"  (addr), "r" (thislen), "1" (data));

--kXdP64Ggrk/fb43R--
