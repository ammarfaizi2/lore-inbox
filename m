Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271834AbRIMQrJ>; Thu, 13 Sep 2001 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271845AbRIMQrD>; Thu, 13 Sep 2001 12:47:03 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:16901 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271847AbRIMQqu>; Thu, 13 Sep 2001 12:46:50 -0400
Date: Thu, 13 Sep 2001 18:30:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 2/11] Fix bad #include in Eicon Diva ISDN driver
Message-ID: <20010913183007.A2552@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Eicon Diva includes an userland errno.h. This is wrong and has been
spotted because of crosscompiling the kernel.

diff -urN linux-x86_64/drivers/isdn/eicon/Divas_mod.c linux/drivers/isdn/eicon/Divas_mod.c
--- linux-x86_64/drivers/isdn/eicon/Divas_mod.c	Thu Apr 19 22:01:35 2001
+++ linux/drivers/isdn/eicon/Divas_mod.c	Thu Sep 13 10:05:28 2001
@@ -29,7 +29,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
-#include <errno.h>
+#include <asm/errno.h>
 
 #include "adapter.h"
 #include "uxio.h"

-- 
Vojtech Pavlik
SuSE Labs
