Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSGYNlw>; Thu, 25 Jul 2002 09:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSGYNk7>; Thu, 25 Jul 2002 09:40:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7677 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313687AbSGYNiC>; Thu, 25 Jul 2002 09:38:02 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251455.g6PEtEXB010533@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) Fix cisco aironet tristate check
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:55:14 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/wireless/Config.in linux-2.5.28-ac1/drivers/net/wireless/Config.in
--- linux-2.5.28/drivers/net/wireless/Config.in	Thu Jul 25 10:48:30 2002
+++ linux-2.5.28-ac1/drivers/net/wireless/Config.in	Sun Jul 21 20:51:31 2002
@@ -33,7 +33,7 @@
 
 # 802.11b cards
    dep_tristate '  Hermes PCMCIA card support' CONFIG_PCMCIA_HERMES $CONFIG_HERMES
-   tristate '  Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards' CONFIG_AIRO_CS
+   dep_tristate '  Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards' CONFIG_AIRO_CS $CONFIG_PCMCIA
 fi
 
 # yes, this works even when no drivers are selected
