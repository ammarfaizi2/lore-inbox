Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752455AbWAFQbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbWAFQbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbWAFQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752455AbWAFQaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:04 -0500
Date: Fri, 6 Jan 2006 16:29:36 GMT
Message-Id: <200601061629.k06GTaNW011378@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 9/17] FRV: Fix PCMCIA configuration
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes PCMCIA configuration for FRV by including the stock
PCMCIA configuration description file.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-pcmcia-2615.diff
 arch/frv/Kconfig |   18 +-----------------
 1 files changed, 1 insertion(+), 17 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/Kconfig linux-2.6.15-frv/arch/frv/Kconfig
--- /warthog/kernels/linux-2.6.15/arch/frv/Kconfig	2005-08-30 13:56:10.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/Kconfig	2006-01-06 14:43:43.000000000 +0000
@@ -305,23 +310,7 @@ config RESERVE_DMA_COHERENT
 
 source "drivers/pci/Kconfig"
 
-config PCMCIA
-	tristate "Use PCMCIA"
-	help
-	  Say Y here if you want to attach PCMCIA- or PC-cards to your FR-V
-	  board.  These are credit-card size devices such as network cards,
-	  modems or hard drives often used with laptops computers.  There are
-	  actually two varieties of these cards: the older 16 bit PCMCIA cards
-	  and the newer 32 bit CardBus cards.  If you want to use CardBus
-	  cards, you need to say Y here and also to "CardBus support" below.
-
-	  To use your PC-cards, you will need supporting software from David
-	  Hinds pcmcia-cs package (see the file <file:Documentation/Changes>
-	  for location).  Please also read the PCMCIA-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  To compile this driver as modules, choose M here: the
-	  modules will be called pcmcia_core and ds.
+source "drivers/pcmcia/Kconfig"
 
 #config MATH_EMULATION
 #	bool "Math emulation support (EXPERIMENTAL)"
