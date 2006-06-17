Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWFQSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWFQSXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFQSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:23:34 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:56673 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWFQSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:23:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BgLu9B5yVs2cITPlhNBE6TcPeAFdUOyAow5W7I5WuHN5y840JGEgjYnvI6ZWQ13z4eISbbi4i4iFKNBKqSe7k7E4ll6/QE3ISmQfuYTo5EfQETOmINU4OIOoMxxzpasBV2qfF7gNFhhwjaRHy4LCmRK9LCtKJaM7O752YRVsZpc=
Message-ID: <449448A2.7030702@gmail.com>
Date: Sat, 17 Jun 2006 12:23:30 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 01/20] chardev: GPIO for SCx200 & PC-8736x:  whitespace
 pre-clean
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/20. patch.preclean

Removed editor format-control comments, and used scripts/Lindent to
clean up whitespace, then deleted the bogus chunks :-(

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.preclean
 arch/i386/kernel/scx200.c   |    7 -------
 drivers/char/scx200_gpio.c  |   26 +++++++++-----------------
 include/linux/scx200.h      |    7 -------
 include/linux/scx200_gpio.h |    7 -------
 4 files changed, 9 insertions(+), 38 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-0/arch/i386/kernel/scx200.c ax-1/arch/i386/kernel/scx200.c
--- ax-0/arch/i386/kernel/scx200.c	2006-03-19 22:53:29.000000000 -0700
+++ ax-1/arch/i386/kernel/scx200.c	2006-06-17 00:55:59.000000000 -0600
@@ -159,10 +159,3 @@ EXPORT_SYMBOL(scx200_gpio_base);
 EXPORT_SYMBOL(scx200_gpio_shadow);
 EXPORT_SYMBOL(scx200_gpio_configure);
 EXPORT_SYMBOL(scx200_cb_base);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel modules"
-        c-basic-offset: 8
-    End:
-*/
diff -ruNp -X dontdiff -X exclude-diffs ax-0/drivers/char/scx200_gpio.c ax-1/drivers/char/scx200_gpio.c
--- ax-0/drivers/char/scx200_gpio.c	2006-03-19 22:53:29.000000000 -0700
+++ ax-1/drivers/char/scx200_gpio.c	2006-06-17 00:55:59.000000000 -0600
@@ -1,4 +1,4 @@
-/* linux/drivers/char/scx200_gpio.c 
+/* linux/drivers/char/scx200_gpio.c
 
    National Semiconductor SCx200 GPIO driver.  Allows a user space
    process to play with the GPIO pins.
@@ -26,7 +26,7 @@ static int major = 0;		/* default to dyn
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
-static ssize_t scx200_gpio_write(struct file *file, const char __user *data, 
+static ssize_t scx200_gpio_write(struct file *file, const char __user *data,
 				 size_t len, loff_t *ppos)
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
@@ -34,15 +34,14 @@ static ssize_t scx200_gpio_write(struct 
 
 	for (i = 0; i < len; ++i) {
 		char c;
-		if (get_user(c, data+i))
+		if (get_user(c, data + i))
 			return -EFAULT;
-		switch (c)
-		{
-		case '0': 
-			scx200_gpio_set(m, 0); 
+		switch (c) {
+		case '0':
+			scx200_gpio_set(m, 0);
 			break;
-		case '1': 
-			scx200_gpio_set(m, 1); 
+		case '1':
+			scx200_gpio_set(m, 1);
 			break;
 		case 'O':
 			printk(KERN_INFO NAME ": GPIO%d output enabled\n", m);
@@ -83,7 +82,7 @@ static ssize_t scx200_gpio_read(struct f
 	value = scx200_gpio_get(m);
 	if (put_user(value ? '1' : '0', buf))
 		return -EFAULT;
-	
+
 	return 1;
 }
 
@@ -140,10 +139,3 @@ static void __exit scx200_gpio_cleanup(v
 
 module_init(scx200_gpio_init);
 module_exit(scx200_gpio_cleanup);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
-        c-basic-offset: 8
-    End:
-*/
diff -ruNp -X dontdiff -X exclude-diffs ax-0/include/linux/scx200_gpio.h ax-1/include/linux/scx200_gpio.h
--- ax-0/include/linux/scx200_gpio.h	2006-03-19 22:53:29.000000000 -0700
+++ ax-1/include/linux/scx200_gpio.h	2006-06-17 00:55:59.000000000 -0600
@@ -87,10 +87,3 @@ static inline void scx200_gpio_change(in
 #undef __SCx200_GPIO_SHADOW
 #undef __SCx200_GPIO_INDEX
 #undef __SCx200_GPIO_OUT
-
-/*
-    Local variables:
-        compile-command: "make -C ../.. bzImage modules"
-        c-basic-offset: 8
-    End:
-*/
diff -ruNp -X dontdiff -X exclude-diffs ax-0/include/linux/scx200.h ax-1/include/linux/scx200.h
--- ax-0/include/linux/scx200.h	2006-03-19 22:53:29.000000000 -0700
+++ ax-1/include/linux/scx200.h	2006-06-17 00:55:59.000000000 -0600
@@ -49,10 +49,3 @@ extern unsigned scx200_cb_base;
 #define SCx200_REV 0x3d		/* Revision Register */
 #define SCx200_CBA 0x3e		/* Configuration Base Address Register */
 #define SCx200_CBA_SCRATCH 0x64	/* Configuration Base Address Scratchpad */
-
-/*
-    Local variables:
-        compile-command: "make -C ../.. bzImage modules"
-        c-basic-offset: 8
-    End:
-*/


