Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMMio>; Mon, 13 Nov 2000 07:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQKMMiY>; Mon, 13 Nov 2000 07:38:24 -0500
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:13774 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129050AbQKMMiO>; Mon, 13 Nov 2000 07:38:14 -0500
To: Hans Grobler <grobh@sun.ac.za>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11pre3: MD module compile fail, sysctl.h again
In-Reply-To: <Pine.LNX.4.21.0011130757210.19245-100000@ccs.sun.ac.za>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 13 Nov 2000 04:37:46 -0800
In-Reply-To: <Pine.LNX.4.21.0011130757210.19245-100000@ccs.sun.ac.za>
Message-ID: <m3n1f4cajp.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Grobler <grobh@sun.ac.za> writes:

> make -C md modules
> make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'
> kgcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11-pre3/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -pipe -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.0-test11-pre3/include/linux/modversions.h
> -DEXPORT_SYMTAB -c md.c

patch from jgarzik :

--- linux/include/linux/sysctl.h.chmou	Sat Nov 11 22:13:13 2000
+++ linux/include/linux/sysctl.h	Sun Nov 12 12:08:15 2000
@@ -24,8 +24,12 @@
 #ifndef _LINUX_SYSCTL_H
 #define _LINUX_SYSCTL_H
 
+#include <linux/kernel.h>
+#include <linux/types.h>
 #include <linux/list.h>
+
+struct file;
 
 #define CTL_MAXNAME 10
 




-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
