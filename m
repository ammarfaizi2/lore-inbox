Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUGHNE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUGHNE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGHNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:03:43 -0400
Received: from mail.donpac.ru ([80.254.111.2]:22459 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264419AbUGHNBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:01:36 -0400
Subject: [PATCH 5/5] 2.6.7-mm6, CRC16 renaming in VIA Velocity ethernet driver
In-Reply-To: <10892916902912@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 8 Jul 2004 17:01:33 +0400
Message-Id: <10892916931944@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 drivers/net/via-velocity.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpNX /usr/share/dontdiff linux-2.6.7-mm6.vanilla/drivers/net/via-velocity.c linux-2.6.7-mm6/drivers/net/via-velocity.c
--- linux-2.6.7-mm6.vanilla/drivers/net/via-velocity.c	Wed Jul  7 20:07:11 2004
+++ linux-2.6.7-mm6/drivers/net/via-velocity.c	Wed Jul  7 20:36:19 2004
@@ -78,7 +78,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 #include <linux/crc32.h>
 
 #include "via-velocity.h"
@@ -3086,7 +3086,7 @@ u16 wol_calc_crc(int size, u8 * pattern,
 				continue;
 			}
 			mask >>= 1;
-			crc = crc16(crc, &(pattern[i * 8 + j]), 1);
+			crc = crc_ccitt(crc, &(pattern[i * 8 + j]), 1);
 		}
 	}
 	/*	Finally, invert the result once to get the correct data */

