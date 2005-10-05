Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVJEATh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVJEATh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVJEATh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:19:37 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:35767 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965049AbVJEATh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:19:37 -0400
Date: Tue, 4 Oct 2005 17:19:47 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] Fix IXDP2x01 config files
Message-ID: <20051005001947.GA17324@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IXDP2401 config file has wrong baudrate and both boards have 3 UARTs.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/arch/arm/configs/ixdp2401_defconfig b/arch/arm/configs/ixdp2401_defconfig
--- a/arch/arm/configs/ixdp2401_defconfig
+++ b/arch/arm/configs/ixdp2401_defconfig
@@ -152,7 +152,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyS0,57600 root=/dev/nfs ip=bootp mem=64M@0x0 pci=firmware"
+CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp mem=64M@0x0 pci=firmware"
 # CONFIG_XIP_KERNEL is not set
 
 #
@@ -560,7 +560,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=3
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
diff --git a/arch/arm/configs/ixdp2801_defconfig b/arch/arm/configs/ixdp2801_defconfig
--- a/arch/arm/configs/ixdp2801_defconfig
+++ b/arch/arm/configs/ixdp2801_defconfig
@@ -560,7 +560,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=3
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
