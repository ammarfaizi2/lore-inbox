Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSK3Vnu>; Sat, 30 Nov 2002 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSK3Vnu>; Sat, 30 Nov 2002 16:43:50 -0500
Received: from [64.4.123.13] ([64.4.123.13]:14480 "HELO paul.hn.org")
	by vger.kernel.org with SMTP id <S262826AbSK3Vnt>;
	Sat, 30 Nov 2002 16:43:49 -0500
Message-ID: <20021130215119.30256.qmail@paul.hn.org>
From: wrightws@paul.hn.org
Subject: [PATCH] drivers/net/Makefile fixes smc91c92 module linkage, kernel 2.4.20
To: linux-kernel@vger.kernel.org
Date: Sat, 30 Nov 2002 16:51:19 -0500 (EST)
Cc: marcelo@freak.distro.conectiva
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.30099.1038693079--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.30099.1038693079--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

modprobe on smc91c92.o seems to be missing linked mii related functions.
Add CONFIG_PCMCIA_SMC91C92 entry containing mii.o to drivers/net/Makefile
so that things link together properly.

-- Wes


*** linux-2.4.20/drivers/net/Makefile   2002-11-28 18:53:13.000000000 -0500
--- linux-2.4.20-ww1/drivers/net/Makefile       2002-11-30 16:26:32.000000000 -0500
***************
*** 122,127 ****
--- 122,128 ----
  obj-$(CONFIG_MAC8390) += daynaport.o 8390.o
  obj-$(CONFIG_APNE) += apne.o 8390.o
  obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
+ obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
  obj-$(CONFIG_SHAPER) += shaper.o
  obj-$(CONFIG_SK_G16) += sk_g16.o
  obj-$(CONFIG_HP100) += hp100.o

--%--multipart-mixed-boundary-1.30099.1038693079--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="README"

modprobe on smc91c92.o seems to be missing linked mii related functions.
Add CONFIG_PCMCIA_SMC91C92 entry containing mii.o to drivers/net/Makefile
so that things link together properly.

Wes Wright
wes@paul.hn.org

--%--multipart-mixed-boundary-1.30099.1038693079--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: 'diff' output text
Content-Disposition: attachment; filename="fix_pcmcia_smc91c92_link.patch"

*** linux-2.4.20/drivers/net/Makefile	2002-11-28 18:53:13.000000000 -0500
--- linux-2.4.20-ww1/drivers/net/Makefile	2002-11-30 16:26:32.000000000 -0500
***************
*** 122,127 ****
--- 122,128 ----
  obj-$(CONFIG_MAC8390) += daynaport.o 8390.o
  obj-$(CONFIG_APNE) += apne.o 8390.o
  obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
+ obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
  obj-$(CONFIG_SHAPER) += shaper.o
  obj-$(CONFIG_SK_G16) += sk_g16.o
  obj-$(CONFIG_HP100) += hp100.o

--%--multipart-mixed-boundary-1.30099.1038693079--%--
