Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTJZQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJZQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:50:58 -0500
Received: from m77.net81-65-140.noos.fr ([81.65.140.77]:20905 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263303AbTJZQuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:50:55 -0500
Date: Sun, 26 Oct 2003 17:50:18 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.23-pre8] compile mii when using usbnet
Message-ID: <20031026165018.GT4013@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is necessary in order to select the compilation of mii.o
when selecting usbnet.o.

Marcelo, please apply.

Thanks,

Stelian.


===== drivers/net/Makefile 1.39 vs edited =====
--- 1.39/drivers/net/Makefile	Wed Sep  3 18:45:33 2003
+++ edited/drivers/net/Makefile	Fri Oct 24 18:22:50 2003
@@ -242,6 +242,7 @@
 
 # non-drivers/net drivers who want mii lib
 obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
+obj-$(CONFIG_USB_USBNET) += mii.o
 
 ifeq ($(CONFIG_ARCH_ACORN),y)
 mod-subdirs	+= ../acorn/net
-- 
Stelian Pop <stelian@popies.net>
