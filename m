Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSGVTzO>; Mon, 22 Jul 2002 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317787AbSGVTzO>; Mon, 22 Jul 2002 15:55:14 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:1191 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S317786AbSGVTzN> convert rfc822-to-8bit; Mon, 22 Jul 2002 15:55:13 -0400
Date: Mon, 22 Jul 2002 15:58:21 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [microPATCH] kernel .config support broken in 2.4.19-rc1-ac3 ff
Message-ID: <20020722195821.GA4489@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though one line extra might have been removed from
kernel/Makefile when SWSUSPEND was taken out.  This one-liner makes
kernel .config support work again:

--- linux-2.4.19-rc3-ac1/kernel/Makefile.orig	2002-07-22 15:45:43.000000000 -0400
+++ linux-2.4.19-rc3-ac1/kernel/Makefile	2002-07-22 15:45:43.000000000 -0400
@@ -20,6 +20,7 @@
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
+obj-$(CONFIG_IKCONFIG) += configs.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is


-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |

Header information for this message:
Subject: [microPATCH] kernel .config support broken in 2.4.19-rc1-ac3 ff
     To: LKML <linux-kernel@vger.kernel.org>
   From: Greg Louis <glouis@dynamicro.on.ca>
