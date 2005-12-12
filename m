Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVLLBiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVLLBiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVLLBfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:35:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15120 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750996AbVLLBfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:35:42 -0500
Date: Mon, 12 Dec 2005 02:35:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/parport_pc.h: "extern inline" -> "static inline"
Message-ID: <20051212013542.GI23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Nov 2005

--- linux-2.6.15-rc1-mm2-full/include/linux/parport_pc.h.old	2005-11-19 02:33:28.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/linux/parport_pc.h	2005-11-19 02:33:44.000000000 +0100
@@ -79,7 +79,7 @@
 }
 
 #ifdef DEBUG_PARPORT
-extern __inline__ void dump_parport_state (char *str, struct parport *p)
+static inline void dump_parport_state (char *str, struct parport *p)
 {
 	/* here's hoping that reading these ports won't side-effect anything underneath */
 	unsigned char ecr = inb (ECONTROL (p));

