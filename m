Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRIMQrJ>; Thu, 13 Sep 2001 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271865AbRIMQrA>; Thu, 13 Sep 2001 12:47:00 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:15621 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271836AbRIMQqt>; Thu, 13 Sep 2001 12:46:49 -0400
Date: Thu, 13 Sep 2001 18:27:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 1/11] AIC7xxx endian include fix
Message-ID: <20010913182743.A2527@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a bunch of patches to make most of the drivers in Linux kernel
compile on the AMD SledgeHammer (x86-64) platform. Most of them are not
x86-64 specific and are general fixes that are needed anyway.

All the patches are generated against x86-64 2.4.9 tree, but were tested
that they apply with some minor offsets to 2.4.10-pre8 as well.

This first patch is a fix for the AIC-7xxx driver to fix the #include it
uses for endianity stuff.

diff -urN linux-x86_64/drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h linux/drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h
--- linux-x86_64/drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h	Fri Jul  6 01:29:20 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h	Thu Sep 13 10:56:25 2001
@@ -35,7 +35,7 @@
  */
 
 #if linux
-#include <endian.h>
+#include <asm/byteorder.h>
 #else
 #include <machine/endian.h>
 #endif

-- 
Vojtech Pavlik
SuSE Labs
