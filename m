Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbUK3Ci2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUK3Ci2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbUK3CAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:00:23 -0500
Received: from baikonur.stro.at ([213.239.196.228]:58521 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261925AbUK3B5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:38 -0500
Subject: [patch 09/11] Subject: ifdef typos mips: AU1[0X]00_USB_DEVICE
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:35 +0100
Message-ID: <E1CYxGp-0002zG-MP@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



AU1000_USB_DEVICE appears 3 times.
AU1X00_USB_DEVICE appears 44 times, and is nowhere defined.
One ifdef starts with "X" version, and ends with "0", so it's quite
obvious these is supposed to be one option.

Makes you wonder if anybody uses these devices.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/arch/mips/Kconfig                    |    2 +-
 linux-2.6.10-rc2-bk13-max/arch/mips/au1000/mtx-1/board_setup.c |    2 +-
 linux-2.6.10-rc2-bk13-max/arch/mips/configs/pb1500_defconfig   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/mips/au1000/mtx-1/board_setup.c~ifdef-mips-au100_usb_device arch/mips/au1000/mtx-1/board_setup.c
--- linux-2.6.10-rc2-bk13/arch/mips/au1000/mtx-1/board_setup.c~ifdef-mips-au100_usb_device	2004-11-30 02:41:43.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/mips/au1000/mtx-1/board_setup.c	2004-11-30 02:41:43.000000000 +0100
@@ -60,7 +60,7 @@ void __init board_setup(void)
 	// enable USB power switch
 	au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
 	au_writel( 0x100000, GPIO2_OUTPUT );
-#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1000_USB_DEVICE)
+#endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
 
 #ifdef CONFIG_PCI
 #if defined(__MIPSEB__)
diff -puN arch/mips/configs/pb1500_defconfig~ifdef-mips-au100_usb_device arch/mips/configs/pb1500_defconfig
--- linux-2.6.10-rc2-bk13/arch/mips/configs/pb1500_defconfig~ifdef-mips-au100_usb_device	2004-11-30 02:41:43.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/mips/configs/pb1500_defconfig	2004-11-30 02:41:43.000000000 +0100
@@ -99,7 +99,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_CPU_LITTLE_ENDIAN=y
-# CONFIG_AU1000_USB_DEVICE is not set
+# CONFIG_AU1X00_USB_DEVICE is not set
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_FB is not set
 
diff -puN arch/mips/Kconfig~ifdef-mips-au100_usb_device arch/mips/Kconfig
--- linux-2.6.10-rc2-bk13/arch/mips/Kconfig~ifdef-mips-au100_usb_device	2004-11-30 02:41:43.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/mips/Kconfig	2004-11-30 02:41:43.000000000 +0100
@@ -959,7 +959,7 @@ config SYSCLK_100
 
 endchoice
 
-config AU1000_USB_DEVICE
+config AU1X00_USB_DEVICE
 	bool
 	depends on MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000
 	default n
_
