Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUIFM4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUIFM4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUIFMzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:55:50 -0400
Received: from mail.renesas.com ([202.234.163.13]:393 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267890AbUIFMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:55:28 -0400
Date: Mon, 06 Sep 2004 21:55:12 +0900 (JST)
Message-Id: <20040906.215512.861025296.takata.hirokazu@renesas.com>
To: akpm@osdl.org, zwane@linuxpower.ca
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc1-mm3] [m32r] Change from EXPORT_SYMBOL_NOVERS to
 EXPORT_SYMBOL
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
References: <20040903104239.A3077@infradead.org>
	<Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
	<Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

From: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: 2.6.9-rc1-mm3
Date: Fri, 3 Sep 2004 08:48:27 -0400 (EDT)
> Just a few comments.
Thank you.

> - There appears to be yet another smc 91C111 driver in there, Takata,
>   there should be a unified one in drivers/net/smc91x.c.
Yes.  I would like to use drivers/net/smc91x.c.  Now investigating it...

> - arch/m32r/Kconfig could do with some trimming.
Yes.  I am going to clean up it.

> - arch/m32r/kernel/irq.c shows that we really could do with that irq
>   consolidation.
I see.  Some i386 code and comments are remained in there.

> - arch/m32r/kernel/m32r_ksyms, EXPORT_SYMBOL_NOVERS is deprecated, use
>   EXPORT_SYMBOL.
Here is a patch for that.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>


diff -rup linux-2.6.9-rc1-mm3.orig/arch/m32r/kernel/m32r_ksyms.c linux-2.6.9-rc1-mm3/arch/m32r/kernel/m32r_ksyms.c
--- linux-2.6.9-rc1-mm3.orig/arch/m32r/kernel/m32r_ksyms.c	2004-09-03 20:46:13.000000000 +0900
+++ linux-2.6.9-rc1-mm3/arch/m32r/kernel/m32r_ksyms.c	2004-09-06 17:12:18.000000000 +0900
@@ -48,9 +48,9 @@ EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);
 
-EXPORT_SYMBOL_NOVERS(__get_user_1);
-EXPORT_SYMBOL_NOVERS(__get_user_2);
-EXPORT_SYMBOL_NOVERS(__get_user_4);
+EXPORT_SYMBOL(__get_user_1);
+EXPORT_SYMBOL(__get_user_2);
+EXPORT_SYMBOL(__get_user_4);
 
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
@@ -87,57 +87,57 @@ extern void __ashrdi3(void);
 extern void __lshldi3(void);
 extern void __lshrdi3(void);
 extern void __muldi3(void);
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-EXPORT_SYMBOL_NOVERS(__lshldi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__lshldi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__muldi3);
 
 /* memory and string operations */
-EXPORT_SYMBOL_NOVERS(memchr);
-EXPORT_SYMBOL_NOVERS(memcpy);
-/* EXPORT_SYMBOL_NOVERS(memcpy_fromio); // not implement yet */
-/* EXPORT_SYMBOL_NOVERS(memcpy_toio); // not implement yet */
-EXPORT_SYMBOL_NOVERS(memset);
-/* EXPORT_SYMBOL_NOVERS(memset_io); // not implement yet */
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(copy_page);
-EXPORT_SYMBOL_NOVERS(clear_page);
-
-EXPORT_SYMBOL_NOVERS(strcat);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strcmp);
-EXPORT_SYMBOL_NOVERS(strcpy);
-EXPORT_SYMBOL_NOVERS(strlen);
-EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(strncmp);
-EXPORT_SYMBOL_NOVERS(strnlen);
-EXPORT_SYMBOL_NOVERS(strncpy);
-
-EXPORT_SYMBOL_NOVERS(_inb);
-EXPORT_SYMBOL_NOVERS(_inw);
-EXPORT_SYMBOL_NOVERS(_inl);
-EXPORT_SYMBOL_NOVERS(_outb);
-EXPORT_SYMBOL_NOVERS(_outw);
-EXPORT_SYMBOL_NOVERS(_outl);
-EXPORT_SYMBOL_NOVERS(_inb_p);
-EXPORT_SYMBOL_NOVERS(_inw_p);
-EXPORT_SYMBOL_NOVERS(_inl_p);
-EXPORT_SYMBOL_NOVERS(_outb_p);
-EXPORT_SYMBOL_NOVERS(_outw_p);
-EXPORT_SYMBOL_NOVERS(_outl_p);
-EXPORT_SYMBOL_NOVERS(_insb);
-EXPORT_SYMBOL_NOVERS(_insw);
-EXPORT_SYMBOL_NOVERS(_insl);
-EXPORT_SYMBOL_NOVERS(_outsb);
-EXPORT_SYMBOL_NOVERS(_outsw);
-EXPORT_SYMBOL_NOVERS(_outsl);
-EXPORT_SYMBOL_NOVERS(_readb);
-EXPORT_SYMBOL_NOVERS(_readw);
-EXPORT_SYMBOL_NOVERS(_readl);
-EXPORT_SYMBOL_NOVERS(_writeb);
-EXPORT_SYMBOL_NOVERS(_writew);
-EXPORT_SYMBOL_NOVERS(_writel);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(memcpy);
+/* EXPORT_SYMBOL(memcpy_fromio); // not implement yet */
+/* EXPORT_SYMBOL(memcpy_toio); // not implement yet */
+EXPORT_SYMBOL(memset);
+/* EXPORT_SYMBOL(memset_io); // not implement yet */
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(copy_page);
+EXPORT_SYMBOL(clear_page);
+
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(strncat);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(strncpy);
+
+EXPORT_SYMBOL(_inb);
+EXPORT_SYMBOL(_inw);
+EXPORT_SYMBOL(_inl);
+EXPORT_SYMBOL(_outb);
+EXPORT_SYMBOL(_outw);
+EXPORT_SYMBOL(_outl);
+EXPORT_SYMBOL(_inb_p);
+EXPORT_SYMBOL(_inw_p);
+EXPORT_SYMBOL(_inl_p);
+EXPORT_SYMBOL(_outb_p);
+EXPORT_SYMBOL(_outw_p);
+EXPORT_SYMBOL(_outl_p);
+EXPORT_SYMBOL(_insb);
+EXPORT_SYMBOL(_insw);
+EXPORT_SYMBOL(_insl);
+EXPORT_SYMBOL(_outsb);
+EXPORT_SYMBOL(_outsw);
+EXPORT_SYMBOL(_outsl);
+EXPORT_SYMBOL(_readb);
+EXPORT_SYMBOL(_readw);
+EXPORT_SYMBOL(_readl);
+EXPORT_SYMBOL(_writeb);
+EXPORT_SYMBOL(_writew);
+EXPORT_SYMBOL(_writel);
 
