Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTARX0l>; Sat, 18 Jan 2003 18:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTARX0Z>; Sat, 18 Jan 2003 18:26:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46308 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265197AbTARX0X>; Sat, 18 Jan 2003 18:26:23 -0500
Date: Sun, 19 Jan 2003 00:35:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove #if'd kernel 2.0 code from ipchains_core.h
Message-ID: <20030118233517.GW10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some #if'd kernel 2.0 code from 
include/linux/netfilter_ipv4/ipchains_core.h.

Please apply
Adrian


--- linux-2.5.59-full/include/linux/netfilter_ipv4/ipchains_core.h.old	2003-01-19 00:31:59.000000000 +0100
+++ linux-2.5.59-full/include/linux/netfilter_ipv4/ipchains_core.h	2003-01-19 00:32:49.000000000 +0100
@@ -178,12 +178,8 @@
 
 #include <linux/config.h>
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
 #include <linux/init.h>
 extern void ip_fw_init(void) __init;
-#else /* 2.0.x */
-extern void ip_fw_init(void);
-#endif /* 2.1.x */
 extern int ip_fw_ctl(int, void *, int);
 #ifdef CONFIG_IP_MASQUERADE
 extern int ip_masq_uctl(int, char *, int);

