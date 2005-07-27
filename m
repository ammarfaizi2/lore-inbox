Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVG0SiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVG0SiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVG0Sfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:35:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261688AbVG0Se3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:34:29 -0400
Date: Wed, 27 Jul 2005 20:34:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] arch/mips/Kconfig mustn't include drivers/char/speakup/Kconfig
Message-ID: <20050727183417.GJ3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This broke configuring on mips since drivers/char/speakup/Kconfig 
already gets included through drivers/Kconfig.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm2-full/arch/mips/Kconfig.old	2005-07-27 20:32:41.000000000 +0200
+++ linux-2.6.13-rc3-mm2-full/arch/mips/Kconfig	2005-07-27 20:32:50.000000000 +0200
@@ -839,8 +839,6 @@
 	depends on SIBYTE_SB1xxx_SOC && !SIBYTE_CFE
 	default y
 
-source "drivers/char/speakup/Kconfig"
-
 config SIBYTE_STANDALONE_RAM_SIZE
 	int "Memory size (in megabytes)"
 	depends on SIBYTE_STANDALONE

