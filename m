Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRE1VGM>; Mon, 28 May 2001 17:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263151AbRE1VGC>; Mon, 28 May 2001 17:06:02 -0400
Received: from smtp6vepub.gte.net ([206.46.170.27]:59514 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S263149AbRE1VFx>; Mon, 28 May 2001 17:05:53 -0400
From: George France <france@handhelds.org>
Date: Mon, 28 May 2001 17:05:45 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_L9D24QYWXHP617EAYU7A"
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jay Thorne <Yohimbe@userfriendly.org>
Subject: PATCH - ksymoops on Alpha - 2.4.5-ac3
MIME-Version: 1.0
Message-Id: <01052817054503.17841@shadowfax.middleearth>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_L9D24QYWXHP617EAYU7A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Here is a trivial patch that will make ksymoops work again on Alpha.

--George

diff -urN linux-2.4.5-ac3-orig/arch/alpha/kernel/traps.c 
linux/arch/alpha/kernel/traps.c
--- linux-2.4.5-ac3-orig/arch/alpha/kernel/traps.c	Thu May 24 17:24:37 2001
+++ linux/arch/alpha/kernel/traps.c	Mon May 28 16:38:25 2001
@@ -286,11 +286,7 @@
 			continue;
 		if (tmp >= (unsigned long) &_etext)
 			continue;
-		/*
-		 * Assume that only the low 24-bits of a kernel text address
-		 * is interesting.
-		 */
-		printk("%6x%c", (int)tmp & 0xffffff, (++i % 11) ? ' ' : '\n');
+		printk("%16lx%c", tmp);
 #if 0
 		if (i > 40) {
 			printk(" ...");


--------------Boundary-00=_L9D24QYWXHP617EAYU7A
Content-Type: text/english;
  name="patch-ksymoops-alpha"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-ksymoops-alpha"

ZGlmZiAtdXJOIGxpbnV4LTIuNC41LWFjMy1vcmlnL2FyY2gvYWxwaGEva2VybmVsL3RyYXBzLmMg
bGludXgvYXJjaC9hbHBoYS9rZXJuZWwvdHJhcHMuYwotLS0gbGludXgtMi40LjUtYWMzLW9yaWcv
YXJjaC9hbHBoYS9rZXJuZWwvdHJhcHMuYwlUaHUgTWF5IDI0IDE3OjI0OjM3IDIwMDEKKysrIGxp
bnV4L2FyY2gvYWxwaGEva2VybmVsL3RyYXBzLmMJTW9uIE1heSAyOCAxNjozODoyNSAyMDAxCkBA
IC0yODYsMTEgKzI4Niw3IEBACiAJCQljb250aW51ZTsKIAkJaWYgKHRtcCA+PSAodW5zaWduZWQg
bG9uZykgJl9ldGV4dCkKIAkJCWNvbnRpbnVlOwotCQkvKgotCQkgKiBBc3N1bWUgdGhhdCBvbmx5
IHRoZSBsb3cgMjQtYml0cyBvZiBhIGtlcm5lbCB0ZXh0IGFkZHJlc3MKLQkJICogaXMgaW50ZXJl
c3RpbmcuCi0JCSAqLwotCQlwcmludGsoIiU2eCVjIiwgKGludCl0bXAgJiAweGZmZmZmZiwgKCsr
aSAlIDExKSA/ICcgJyA6ICdcbicpOworCQlwcmludGsoIiUxNmx4JWMiLCB0bXApOwogI2lmIDAK
IAkJaWYgKGkgPiA0MCkgewogCQkJcHJpbnRrKCIgLi4uIik7Cg==

--------------Boundary-00=_L9D24QYWXHP617EAYU7A--
