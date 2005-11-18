Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVKRDeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVKRDeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVKRDdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:33:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56070 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751521AbVKRDd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:33:27 -0500
Date: Fri, 18 Nov 2005 04:33:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/gianfar.h: "extern inline" -> "static inline"
Message-ID: <20051118033326.GT11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/gianfar.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm1-full/drivers/net/gianfar.h.old	2005-11-18 02:38:02.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/net/gianfar.h	2005-11-18 02:38:10.000000000 +0100
@@ -711,14 +711,14 @@
 	uint32_t msg_enable;
 };
 
-extern inline u32 gfar_read(volatile unsigned *addr)
+static inline u32 gfar_read(volatile unsigned *addr)
 {
 	u32 val;
 	val = in_be32(addr);
 	return val;
 }
 
-extern inline void gfar_write(volatile unsigned *addr, u32 val)
+static inline void gfar_write(volatile unsigned *addr, u32 val)
 {
 	out_be32(addr, val);
 }

