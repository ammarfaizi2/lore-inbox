Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVLLBfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVLLBfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLLBfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:35:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751000AbVLLBfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:35:39 -0500
Date: Mon, 12 Dec 2005 02:35:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/video/newport.h: "extern inline" -> "static inline"
Message-ID: <20051212013539.GH23349@stusta.de>
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

 include/video/newport.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm2-full/include/video/newport.h.old	2005-11-19 02:34:35.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/video/newport.h	2005-11-19 02:35:42.000000000 +0100
@@ -382,7 +382,8 @@
 #define VC2_IREG_CONTROL       0x10
 #define VC2_IREG_CONFIG        0x20
 
-extern __inline__ void newport_vc2_set(struct newport_regs *regs, unsigned char vc2ireg,
+static inline void newport_vc2_set(struct newport_regs *regs,
+				   unsigned char vc2ireg,
 				   unsigned short val)
 {
 	regs->set.dcbmode = (NPORT_DMODE_AVC2 | VC2_REGADDR_INDEX | NPORT_DMODE_W3 |
@@ -390,7 +391,7 @@
 	regs->set.dcbdata0.byword = (vc2ireg << 24) | (val << 8);
 }
 
-extern __inline__ unsigned short newport_vc2_get(struct newport_regs *regs,
+static inline unsigned short newport_vc2_get(struct newport_regs *regs,
 					     unsigned char vc2ireg)
 {
 	regs->set.dcbmode = (NPORT_DMODE_AVC2 | VC2_REGADDR_INDEX | NPORT_DMODE_W1 |

