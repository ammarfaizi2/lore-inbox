Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSKCQdk>; Sun, 3 Nov 2002 11:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbSKCQdk>; Sun, 3 Nov 2002 11:33:40 -0500
Received: from modemcable077.18-202-24.mtl.mc.videotron.ca ([24.202.18.77]:58380
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262126AbSKCQdj>; Sun, 3 Nov 2002 11:33:39 -0500
Date: Sun, 3 Nov 2002 11:43:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5-AC] cistpl.c pcibios_read_config_dword
Message-ID: <Pine.LNX.4.44.0211031123520.14075-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry untested :/

Index: linux-2.5.44-ac5/drivers/pcmcia/cistpl.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.44-ac5/drivers/pcmcia/cistpl.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cistpl.c
--- linux-2.5.44-ac5/drivers/pcmcia/cistpl.c	3 Nov 2002 07:19:08 -0000	1.1.1.1
+++ linux-2.5.44-ac5/drivers/pcmcia/cistpl.c	3 Nov 2002 16:32:36 -0000
@@ -429,7 +429,7 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
 	u_int ptr;
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	pci_read_config_dword(s->cap.cb_dev, PCI_CARDBUS_CIS, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else

-- 
function.linuxpower.ca


