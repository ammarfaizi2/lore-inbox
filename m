Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSECMmx>; Fri, 3 May 2002 08:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSECMmw>; Fri, 3 May 2002 08:42:52 -0400
Received: from gear.torque.net ([204.138.244.1]:15887 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S310806AbSECMmv>;
	Fri, 3 May 2002 08:42:51 -0400
Message-ID: <3CD284A9.5FE8C329@torque.net>
Date: Fri, 03 May 2002 08:38:01 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jurriaan on Alpha <thunder7@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.13 on Alpha: undefined reference to vmalloc in scsidrv.o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:

<snip/>
> drivers/scsi/scsidrv.o: In function `sd_init':
> drivers/scsi/scsidrv.o(.text+0x1e3f0): undefined reference to `vmalloc'
<snip/>

Does this patch help?

Doug Gilbert


--- linux/drivers/scsi/sd.c	Thu May  2 22:53:03 2002
+++ linux/drivers/scsi/sd.c2513vm	Fri May  3 08:33:06 2002
@@ -41,6 +41,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/vmalloc.h>
 
 #include <linux/smp.h>
 

