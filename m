Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTBLMsB>; Wed, 12 Feb 2003 07:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTBLMsB>; Wed, 12 Feb 2003 07:48:01 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:7916 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267065AbTBLMsA>; Wed, 12 Feb 2003 07:48:00 -0500
Date: Wed, 12 Feb 2003 13:57:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [patch] fix missing cfi_cmdset_0020 in drivers/mtd/chips/Makefile
Message-ID: <20030212125728.GA22472@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is needed for pre4 and pre4-ac3. It appears to be missing
from cvs as well, David. I'll apply it later today.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong

diff -Naur linux-2.4.21-pre4-ac3/drivers/mtd/chips/Makefile scratch/drivers/mtd/chips/Makefile
--- linux-2.4.21-pre4-ac3/drivers/mtd/chips/Makefile	Wed Feb 12 13:42:01 2003
+++ scratch/drivers/mtd/chips/Makefile	Wed Feb 12 13:42:29 2003
@@ -17,7 +17,6 @@
 obj-$(CONFIG_MTD)		+= chipreg.o
 obj-$(CONFIG_MTD_AMDSTD)	+= amd_flash.o 
 obj-$(CONFIG_MTD_CFI)		+= cfi_probe.o
+obj-$(CONFIG_MTD_CFI_STAA)	+= cfi_cmdset_0020.o
 obj-$(CONFIG_MTD_CFI_AMDSTD)	+= cfi_cmdset_0002.o
 obj-$(CONFIG_MTD_CFI_INTELEXT)	+= cfi_cmdset_0001.o
 obj-$(CONFIG_MTD_GEN_PROBE)	+= gen_probe.o
