Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUGHNIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUGHNIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUGHNDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:03:01 -0400
Received: from mail.donpac.ru ([80.254.111.2]:13243 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263804AbUGHNBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:01:30 -0400
Subject: [PATCH 2/5] 2.6.7-mm6, CRC16 renaming in IRDA drivers
In-Reply-To: <10892916813150@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 8 Jul 2004 17:01:24 +0400
Message-Id: <10892916843577@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 include/net/irda/crc.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/include/net/irda/crc.h linux-2.6.7-mm5/include/net/irda/crc.h
--- linux-2.6.7-mm5.vanilla/include/net/irda/crc.h	Thu Jul  1 20:58:31 2004
+++ linux-2.6.7-mm5/include/net/irda/crc.h	Thu Jul  1 22:45:07 2004
@@ -15,15 +15,15 @@
 #define IRDA_CRC_H
 
 #include <linux/types.h>
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 
 #define INIT_FCS  0xffff   /* Initial FCS value */
 #define GOOD_FCS  0xf0b8   /* Good final FCS value */
 
 /* Recompute the FCS with one more character appended. */
-#define irda_fcs(fcs, c) crc16_byte(fcs, c)
+#define irda_fcs(fcs, c) crc_ccitt_byte(fcs, c)
 
 /* Recompute the FCS with len bytes appended. */
-#define irda_calc_crc16(fcs, buf, len) crc16(fcs, buf, len)
+#define irda_calc_crc16(fcs, buf, len) crc_ccitt(fcs, buf, len)
 
 #endif

