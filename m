Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUGHNId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUGHNId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUGHNDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:03:36 -0400
Received: from mail.donpac.ru ([80.254.111.2]:17339 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263824AbUGHNBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:01:33 -0400
Subject: [PATCH 4/5] 2.6.7-mm6, CRC16 renaming in PPP driver
In-Reply-To: <10892916872918@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 8 Jul 2004 17:01:30 +0400
Message-Id: <10892916902912@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 drivers/net/ppp_async.c  |    2 +-
 include/linux/ppp_defs.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/drivers/net/ppp_async.c linux-2.6.7-mm5/drivers/net/ppp_async.c
--- linux-2.6.7-mm5.vanilla/drivers/net/ppp_async.c	Thu Jul  1 20:58:12 2004
+++ linux-2.6.7-mm5/drivers/net/ppp_async.c	Thu Jul  1 22:47:57 2004
@@ -24,7 +24,7 @@
 #include <linux/tty.h>
 #include <linux/netdevice.h>
 #include <linux/poll.h>
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 #include <linux/ppp_defs.h>
 #include <linux/if_ppp.h>
 #include <linux/ppp_channel.h>
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/include/linux/ppp_defs.h linux-2.6.7-mm5/include/linux/ppp_defs.h
--- linux-2.6.7-mm5.vanilla/include/linux/ppp_defs.h	Thu Jul  1 20:58:31 2004
+++ linux-2.6.7-mm5/include/linux/ppp_defs.h	Thu Jul  1 22:45:25 2004
@@ -42,7 +42,7 @@
 #ifndef _PPP_DEFS_H_
 #define _PPP_DEFS_H_
 
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 
 /*
  * The basic PPP frame.
@@ -97,7 +97,7 @@
 
 #define PPP_INITFCS	0xffff	/* Initial FCS value */
 #define PPP_GOODFCS	0xf0b8	/* Good final FCS value */
-#define PPP_FCS(fcs, c) crc16_byte(fcs, c)
+#define PPP_FCS(fcs, c) crc_ccitt_byte(fcs, c)
 
 /*
  * Extended asyncmap - allows any character to be escaped.

