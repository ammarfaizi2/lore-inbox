Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSGUUyV>; Sun, 21 Jul 2002 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSGUUyV>; Sun, 21 Jul 2002 16:54:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317192AbSGUUyU>; Sun, 21 Jul 2002 16:54:20 -0400
Subject: PATCH: 2.5.27 missing config constraint on AIRO_CS
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 22:21:41 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WO97-0007ed-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- drivers/net/wireless/Config.in~	Sun Jul 21 20:51:00 2002
+++ drivers/net/wireless/Config.in	Sun Jul 21 20:51:31 2002
@@ -33,7 +33,7 @@
 
 # 802.11b cards
    dep_tristate '  Hermes PCMCIA card support' CONFIG_PCMCIA_HERMES $CONFIG_HERMES
-   tristate '  Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards' CONFIG_AIRO_CS
+   dep_tristate '  Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards' CONFIG_AIRO_CS $CONFIG_PCMCIA
 fi
 
 # yes, this works even when no drivers are selected
