Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUATTxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265748AbUATTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:52:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:58122 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265729AbUATTtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:49:41 -0500
Date: Tue, 20 Jan 2004 20:53:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig/wireless: Replace enable with select
Message-ID: <20040120195311.GB14417@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'enable' is not documented in Documentation/kbuild/kconfig-language.txt
So remove usage in the only Kconfig file in the kernel tree where it was used.

	Sam

===== drivers/net/wireless/Kconfig 1.16 vs edited =====
--- 1.16/drivers/net/wireless/Kconfig	Sun Jan 11 01:57:32 2004
+++ edited/drivers/net/wireless/Kconfig	Tue Jan 20 20:45:07 2004
@@ -270,8 +270,8 @@
 config PCMCIA_ATMEL
       tristate "Atmel at76c502/at76c504 PCMCIA cards"
       depends on NET_RADIO && EXPERIMENTAL && PCMCIA
-      enable FW_LOADER
-      enable CRC32
+      select FW_LOADER
+      select CRC32
        ---help---
          A driver for PCMCIA 802.11 wireless cards based on the 
          Atmel fast-vnet chips. This driver supports standard
