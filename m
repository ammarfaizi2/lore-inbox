Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbTIIXEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbTIIXEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:04:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:47782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265034AbTIIXDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:03:12 -0400
Date: Tue, 9 Sep 2003 16:02:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] video/hexium_orion warning removal
Message-Id: <20030909160245.49e8bddd.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hexium_orion driver in 2.6.0-test5 gets a warning because it defines
setup data that is never used.

Builds fine if it is deleted; don't have real hardware.

diff -Nru a/drivers/media/video/hexium_orion.h b/drivers/media/video/hexium_orion.h
--- a/drivers/media/video/hexium_orion.h	Tue Sep  9 15:56:54 2003
+++ b/drivers/media/video/hexium_orion.h	Tue Sep  9 15:56:54 2003
@@ -30,109 +30,4 @@
 /*30*/ 0x44,0x75,0x01,0x8C,0x03
 };
 
-static struct {
-	struct hexium_data data[8];	
-} hexium_input_select[] = {
-{
-	{ /* input 0 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xD9 },
-		{ 0x21, 0x17 }, // 0x16,
-		{ 0x22, 0x40 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 }, // ??
-		{ 0x21, 0x16 }, // 0x03,
-	}
-}, {
-	{ /* input 1 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xD8 },
-		{ 0x21, 0x17 }, // 0x16,
-		{ 0x22, 0x40 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 }, // ??
-		{ 0x21, 0x16 }, // 0x03,
-	}
-}, {
-	{ /* input 2 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xBA },
-		{ 0x21, 0x07 }, // 0x05,
-		{ 0x22, 0x91 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ??
-		{ 0x21, 0x05 }, // 0x03,
-	}
-}, {
-	{ /* input 3 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0xB8 },
-		{ 0x21, 0x07 }, // 0x05,
-		{ 0x22, 0x91 },
-		{ 0x2C, 0x03 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ??
-		{ 0x21, 0x05 }, // 0x03,
-	}
-}, {
-	{ /* input 4 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0x7C },
-		{ 0x21, 0x07 }, // 0x03
-		{ 0x22, 0xD2 },
-		{ 0x2C, 0x83 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ??
-		{ 0x21, 0x03 },
-	} 
-}, {
-	{ /* input 5 */
-		{ 0x06, 0x00 },
-		{ 0x20, 0x78 },
-		{ 0x21, 0x07 }, // 0x03,
-		{ 0x22, 0xD2 },
-		{ 0x2C, 0x83 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 }, // ?
-		{ 0x21, 0x03 },
-	}
-}, {
-	{ /* input 6 */
-		{ 0x06, 0x80 },
-		{ 0x20, 0x59 },
-		{ 0x21, 0x17 },
-		{ 0x22, 0x42 },
-		{ 0x2C, 0xA3 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 },
-		{ 0x21, 0x12 },
-	}
-}, {
-	{ /* input 7 */
-		{ 0x06, 0x80 },
-		{ 0x20, 0x9A },
-		{ 0x21, 0x17 },
-		{ 0x22, 0xB1 },
-		{ 0x2C, 0x13 },
-		{ 0x30, 0x60 },
-		{ 0x31, 0xB5 },
-		{ 0x21, 0x14 },
-	}
-}, {
-	{ /* input 8 */
-		{ 0x06, 0x80 },
-		{ 0x20, 0x3C },
-		{ 0x21, 0x27 },
-		{ 0x22, 0xC1 },
-		{ 0x2C, 0x23 },
-		{ 0x30, 0x44 },
-		{ 0x31, 0x75 },
-		{ 0x21, 0x21 },
-	}
-}	
-};
-
 #endif
