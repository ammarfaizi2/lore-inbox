Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbUBWVH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUBWVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:05:06 -0500
Received: from mail.convergence.de ([212.84.236.4]:43242 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261386AbUBWVEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:04:55 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 3/9] Minor DVB Skystar2 updates
In-Reply-To: <10775702813454@convergence.de>
Message-Id: <1077570282137@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:04:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - skystar2: renamed two functions, deleted spurious spaces.
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/b2c2/skystar2.c linux-2.6.3.p/drivers/media/dvb/b2c2/skystar2.c
--- xx-linux-2.6.3/drivers/media/dvb/b2c2/skystar2.c	2004-01-09 09:22:39.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/b2c2/skystar2.c	2004-02-02 19:28:29.000000000 +0100
@@ -500,7 +501,7 @@
 	}
 }
 
-static void sram_writeChunk(struct adapter *adapter, u32 addr, u8 *buf, u16 len)
+static void sram_write_chunk(struct adapter *adapter, u32 addr, u8 *buf, u16 len)
 {
 	u32 bank;
 
@@ -520,7 +521,7 @@
 	flex_sram_write(adapter, bank, addr & 0x7fff, buf, len);
 }
 
-static void sram_readChunk(struct adapter *adapter, u32 addr, u8 *buf, u16 len)
+static void sram_read_chunk(struct adapter *adapter, u32 addr, u8 *buf, u16 len)
 {
 	u32 bank;
 
@@ -554,7 +555,7 @@
 			length = (((addr >> 0x0f) + 1) << 0x0f) - addr;
 		}
 
-		sram_readChunk(adapter, addr, buf, length);
+		sram_read_chunk(adapter, addr, buf, length);
 
 		addr = addr + length;
 		buf = buf + length;
@@ -576,7 +577,7 @@
 			length = (((addr >> 0x0f) + 1) << 0x0f) - addr;
 		}
 
-		sram_writeChunk(adapter, addr, buf, length);
+		sram_write_chunk(adapter, addr, buf, length);
 
 		addr = addr + length;
 		buf = buf + length;


