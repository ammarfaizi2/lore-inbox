Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWFVSvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWFVSvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWFVSvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:51:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:61397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161187AbWFVSvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:51:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=d2EXO3iKVcMWhsNTTTRktPFggjJzVW9RPkBrwaNWjjPWlsURdxZl2NQZopMt2Vs4g7YmEeNSQX9T+gZtawMHC6h5n1FF6QKx7Wbm0+hcs5bP7FliIxQlhDpC7rxHoGW5kqFZpx60/uMI9/xxFcrsWqF/TNFN1Pnmur2FgMVAy1w=
Message-ID: <449AE6C2.3090905@gmail.com>
Date: Thu, 22 Jun 2006 12:51:46 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 05/11 ] gpio-patchset-fixups: include linux/io.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.  Im somewhat ambivalent about this patch,
since with it, driver wont build for vanilla 17 or older.

Its also only 1/2 of your suggestion - when I tried it, I was building 
against vanilla 17,
and asm/uaccess.h cause compilation failure.
Looking back, Im perplexed as to why linux/io.h didnt cause same failure ?!?

----

diff.13-fix-include-linux-io

use linux/io.h rather than asm/io.h

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 13/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 13/drivers/char/pc8736x_gpio.c	2006-06-21 10:31:31.000000000 -0600
@@ -15,12 +15,12 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
-#include <asm/io.h>
 
 #define DEVNAME "pc8736x_gpio"
 


